FROM centos:7 as base
FROM base as builder

ADD https://d1cuw2q49dpd0p.cloudfront.net/ASE16/Current/ASE_Suite.linuxamd64.tgz /tmp/ASE/ASE_Suite.linuxamd64.tgz
RUN pushd /tmp/ASE && tar -xvzf /tmp/ASE_Suite.linuxamd64.tgz && rm -f ASE_Suite.linuxamd64.tgz && popd
COPY ./sybase_response.txt /tmp/ASE

FROM base as basedeps
RUN yum update -y \
 && yum install -y libaio net-tools nc \
 && yum clean all

FROM basedeps as setup
COPY --from=builder /tmp/ASE /tmp/ASE

RUN /tmp/ASE/setup.bin -DAGREE_TO_SAP_LICENSE=true -i silent -f /tmp/ASE/sybase_response.txt \
 && rm -rf /tmp/ASE

FROM setup as install
COPY ./srvbuild1027.001-SYBASE.rs /tmp/ASE/srvbuild1027.001-SYBASE.rs
COPY ./sqlloc1027.001-SYBASE.rs /tmp/ASE/sqlloc1027.001-SYBASE.rs
RUN . /opt/sap/SYBASE.sh \ 
 && /opt/sap/ASE-16_0/bin/srvbuildres -r /tmp/ASE/srvbuild1027.001-SYBASE.rs \
 && /opt/sap/ASE-16_0/bin/sqllocres -r /tmp/ASE/sqlloc1027.001-SYBASE.rs \
 && rm -rf /tmp/ASE \
 && sed -i -e 's/enable console logging = DEFAULT/enable console logging = 1/g' /opt/sap/ASE-16_0/SYBASE.cfg \
 && sed -i -e 's/localhost/0.0.0.0/g' /opt/sap/interfaces

FROM basedeps
COPY --from=install /opt/sap /opt/sap

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./healthcheck.sh /usr/local/bin/healthcheck

EXPOSE 5000

ENTRYPOINT docker-entrypoint.sh
FROM centos:7 as base
FROM base as builder

ADD https://d1cuw2q49dpd0p.cloudfront.net/ASE16/Current/ASE_Suite.linuxamd64.tgz /tmp/ASE
RUN pushd /tmp && tar -xvzf /tmp/ASE && rm -f ASE && mv ebf30399 ASE && popd
COPY ./sybase_response.txt /tmp/ASE

FROM base as basedeps
RUN yum update -y \
 && yum install -y libaio net-tools nc \
 && yum clean all

FROM basedeps as setup
COPY --from=builder /tmp/ASE /tmp/ASE

RUN /tmp/ASE/setup.bin -DAGREE_TO_SAP_LICENSE=true -i silent -f /tmp/ASE/sybase_response.txt \
 && rm -rf /tmp/ASE

COPY ./srvbuild.adaptive_server.rs /tmp/ASE/srvbuild.adaptive_server.rs
RUN . /opt/sap/SYBASE.sh && /opt/sap/ASE-16_0/bin/srvbuildres -r /tmp/ASE/srvbuild.adaptive_server.rs \
 && rm -rf /tmp/ASE \
 && sed -i -e 's/enable console logging = DEFAULT/enable console logging = 1/g' /opt/sap/ASE-16_0/SYBASE.cfg \
 && sed -i -e 's/localhost/0.0.0.0/g' /opt/sap/interfaces

FROM basedeps
COPY --from=setup /opt/sap /opt/sap
# COPY --from=setup /var/lib/rpm /var/lib/rpm

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 5000

ENTRYPOINT [ "/docker-entrypoint.sh" ]
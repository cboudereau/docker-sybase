FROM centos:7

ADD https://d1cuw2q49dpd0p.cloudfront.net/ASE16/Current/ASE_Suite.linuxamd64.tgz /tmp/ASE
RUN pushd /tmp && tar -xvzf /tmp/ASE && rm -f ASE && mv ebf30399 ASE && popd

RUN yum update -y && yum install -y libaio && yum clean all

COPY ./sybase_response.txt /tmp/ASE
RUN /tmp/ASE/setup.bin -DAGREE_TO_SAP_LICENSE=true -i silent -f /tmp/ASE/sybase_response.txt && rm -rf /tmp/ASE

COPY ./srvbuild.adaptive_server.rs /tmp/ASE/srvbuild.adaptive_server.rs
RUN . /opt/sap/SYBASE.sh && /opt/sap/ASE-16_0/bin/srvbuildres -r /tmp/ASE/srvbuild.adaptive_server.rs && rm -rf /tmp/ASE

RUN sed -i -e 's/enable console logging = DEFAULT/enable console logging = 1/g' /opt/sap/ASE-16_0/SYBASE.cfg

EXPOSE 5000

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
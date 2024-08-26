ARG BASETAG=release-35.2.0
FROM docker.io/rucio/rucio-clients:$BASETAG

USER root

COPY ./linuxsoft-alma9.repo /etc/yum.repos.d/

# Add Rucio client configuration template
COPY --chown=user:user files/rucio.cfg.j2 /opt/user/rucio.cfg.j2

# Add EGI CA certificates
COPY ./EGI-trustanchors.repo /etc/yum.repos.d/

# Install certificates
RUN yum -y install \
        CERN-CA-certs \
        ca-certificates \
        ca-policy-egi-core && \
    yum -y clean all && \
    rm -rf /var/cache/yum

USER user
WORKDIR /home/user

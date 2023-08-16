ARG BASETAG=release-1.30.0
FROM rucio/rucio-clients:$BASETAG

USER root

COPY ./linuxsupport7s-stable.repo /etc/yum.repos.d/

# Add the rucio configuration template
COPY --chown=user:user files/rucio.cfg.j2 /opt/user/rucio.cfg.j2

# EGI trust anchors

RUN yum -y install ca-certificates ca-policy-egi-core && \
    yum install -y CERN-CA-certs && \
    yum clean all && \
    rm -rf /var/cache/yum

USER user
WORKDIR /home/user

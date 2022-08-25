ARG BASETAG=release-1.29.1
FROM rucio/rucio-clients:$BASETAG

USER root

# CERN certificate
COPY --chown=user:user files/CERN-bundle.pem /etc/pki/tls/certs/CERN-bundle.pem

# Add the rucio configuration template
COPY --chown=user:user files/rucio.cfg.j2 /opt/user/rucio.cfg.j2

# EGI trust anchors
RUN curl -Lo /etc/yum.repos.d/EGI-trustanchors.repo https://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo && \
    yum -y install ca-certificates ca-policy-egi-core && \
    yum clean all && \
    rm -rf /var/cache/yum

USER user
WORKDIR /home/user

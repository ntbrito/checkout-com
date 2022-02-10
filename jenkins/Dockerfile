FROM jenkins/jenkins:lts

USER root
RUN apt-get update \
 && apt-get install -y \
    python3 \
    python3-pip \
    jq \
 && python3 -m pip install -U pip \
 && python3 -m pip install -U setuptools \
 && pip install ansible boto3 awscli

ARG uid=1004
ARG gid=1004
ARG user=jenkins
ARG group=jenkins
ARG http_port=8080
ARG JENKINS_HOME=/var/jenkins_home
ARG REF=/usr/share/jenkins/ref

ENV JENKINS_HOME=${JENKINS_HOME}
ENV REF=${REF}
ENV JENKINS_UC=https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
ENV JAVA_HOME=/opt/java/openjdk

COPY jenkins_home/. ${JENKINS_HOME}
# jenkins uid needs to be changed to something else
# by default jenkins uid is 1000 which is the same as the ec2-user on the host
# and that causes permission problems when mounting the volume
# jenkins_home is bind mounted externally and we need to have the same uid
# as the user owning the external mount point
RUN usermod -u ${uid} jenkins \
 && groupmod -g ${gid} jenkins \
 && chown -R ${uid}:${gid} ${JENKINS_HOME} \
 && chown -R ${uid}:${gid} ${REF}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME $JENKINS_HOME

# for main web interface:
EXPOSE ${http_port}

ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
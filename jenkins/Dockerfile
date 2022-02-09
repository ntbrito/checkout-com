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

ARG uid=1001
ARG gid=1001
ARG user=jenkins
ARG group=jenkins
ARG http_port=8080
ARG JENKINS_HOME=/var/jenkins_home
ARG REF=/usr/share/jenkins/ref

ENV JENKINS_HOME=${JENKINS_HOME}
ENV JENKINS_AGENT_PORT=${agent_port}
ENV REF=${REF}
ENV JENKINS_UC=https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
ENV JAVA_HOME=/opt/java/openjdk

COPY jenkins_home/. ${JENKINS_HOME}
# jenkins uid needs to be changed to 1001
# jenkins_home is bind mounted externally and we need to have the same uid
# as the user owning the external mount point
RUN usermod -u ${uid} jenkins \
 && groupmod -g ${gid} jenkins \
 && chown -R jenkins:jenkins ${JENKINS_HOME} \
 && chown -R jenkins:jenkins ${REF}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME $JENKINS_HOME

# for main web interface:
EXPOSE ${http_port}

ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

USER ${user}
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
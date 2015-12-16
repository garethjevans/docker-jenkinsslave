FROM ubuntu:wily
MAINTAINER Gareth Evans <gareth@bryncynfelin.co.uk>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server
#RUN apt-get install -y openssh-server
#RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
#RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y openjdk-8-jdk git curl wget unzip graphviz build-essential

# Add user jenkins to the image
RUN useradd -ms /bin/bash jenkins

# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
#EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"]

ENV JENKINS_SWARM_VERSION 2.0
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar && \
    chmod 755 /usr/share/jenkins

ENV SONAR_VERSION 2.4 
RUN wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/${SONAR_VERSION}/sonar-runner-dist-${SONAR_VERSION}.zip && \
    unzip sonar-runner-dist-${SONAR_VERSION}.zip && \
    mv sonar-runner-${SONAR_VERSION} /opt/sonar-runner && \
    chown -R jenkins:jenkins /opt/sonar-runner

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY swarm/slave.sh /home/jenkins/slave.sh
RUN chmod +x /home/jenkins/slave.sh

ENTRYPOINT ["/home/jenkins/slave.sh"]

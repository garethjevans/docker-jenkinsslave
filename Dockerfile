FROM evarga/jenkins-slave:latest

ENV JENKINS_SWARM_VERSION 2.0
RUN apt-get update && \
	apt-get install -y git curl && \
	curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar && \
    chmod 755 /usr/share/jenkins


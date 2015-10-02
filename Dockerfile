FROM evarga/jenkins-slave:latest

ENV JENKINS_SWARM_VERSION 2.0
RUN apt-get update && \
	apt-get install -y git curl unzip graphviz && \
	curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar && \
    chmod 755 /usr/share/jenkins

ENV SONAR_VERSION 2.4 
RUN wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/${SONAR_VERSION}/sonar-runner-dist-${SONAR_VERSION}.zip && \
    unzip sonar-runner-dist-${SONAR_VERSION}.zip && \
    mv sonar-runner-${SONAR_VERSION} /opt/sonar-runner && \
    chown -R jenkins:jenkins /opt/sonar-runner


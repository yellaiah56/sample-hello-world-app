FROM tomcat:9.0.70-jdk11-corretto
COPY target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-application.war

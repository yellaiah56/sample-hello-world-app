FROM 9.0.69-jre8-temurin-jammy
COPY target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-application.war

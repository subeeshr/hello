# Dockerfile

FROM centos
RUN yum install -y java-1.7.0-openjdk
MAINTAINER  Author Name <r.subeesh@outlook.com>
EXPOSE 8080
ADD calc.jar /app/calc.jar
ENTRYPOINT ["java", "-jar", "/app/calc.jar"]

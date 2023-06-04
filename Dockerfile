FROM maven:3.8.7-openjdk-18 as builder
WORKDIR /app
COPY . /app
RUN mvn clean package

FROM tomcat:8-jre8
COPY --from=builder /app/webapp/target/webapp.war /usr/local/tomcat/webapps/ROOT.war
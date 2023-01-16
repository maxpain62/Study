FROM maven:3.8.7-openjdk-18 as build
RUN git clone https://github.com/maxpain62/hello-world.git && cd /hello-world && mvn clean install

FROM tomcat:10
COPY --from=build /root/hello-world-exp/webapp/target/webapp.war  /usr/local/tomcat/webapps/webapp.war
EXPOSE 8080
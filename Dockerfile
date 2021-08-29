FROM tomcat:9.0.52
COPY ./latest.war /opt/tomcat/webapp
RUN chmod +x $CATALINA_HOME/bin
EXPOSE 8080
CMD ["catalina.sh","run"]
FROM tomcat:9.0.52
COPY /home/ansibleadmin/latest.war /usr/local/tomcat/webapps
RUN chmod +x $CATALINA_HOME/bin
EXPOSE 8080
CMD ["catalina.sh","run"]
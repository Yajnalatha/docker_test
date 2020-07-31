FROM	tomcat:8.5.35-jre10
COPY Myapp/ /usr/local/tomcat/webapps/
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]

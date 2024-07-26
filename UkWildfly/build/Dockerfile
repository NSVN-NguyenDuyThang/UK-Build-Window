# Build Wildfly
FROM jboss/wildfly:10.1.0.Final
USER root
# copy font
COPY ./fonts/* /usr/share/fonts/
# change timezone
RUN ln -s -f /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
# config
COPY ./files/standalone.xml $JBOSS_HOME/standalone/configuration
COPY ./files/application.keystore $JBOSS_HOME/standalone/configuration
COPY ./files/standalone.conf $JBOSS_HOME/bin
RUN sed -i 's/\r$//' $JBOSS_HOME/bin/standalone.conf
# eclipse link
COPY ./lib/eclipselink-2.6.0.jar $JBOSS_HOME/modules/system/layers/base/org/eclipse/persistence/main
COPY ./lib/jipijapa-eclipselink-1.0.1.Final.jar $JBOSS_HOME/modules/system/layers/base/org/eclipse/persistence/main
COPY ./files/eclipselink/module.xml $JBOSS_HOME/modules/system/layers/base/org/eclipse/persistence/main
# postgresql
RUN mkdir -p $JBOSS_HOME/modules/system/layers/base/org/postgresql/main
COPY ./lib/postgresql-42.2.23.jar $JBOSS_HOME/modules/system/layers/base/org/postgresql/main/
COPY ./files/postgresql/module.xml $JBOSS_HOME/modules/system/layers/base/org/postgresql/main/
# mssql
RUN mkdir -p $JBOSS_HOME/modules/com/microsoft/sqlserver/jdbc/main
COPY ./lib/sqljdbc42.jar $JBOSS_HOME/modules/com/microsoft/sqlserver/jdbc/main
COPY ./files/mssql/module.xml $JBOSS_HOME/modules/com/microsoft/sqlserver/jdbc/main
# start cmd file
COPY ./files/start.sh $JBOSS_HOME/bin/
COPY ./files/config-standalone.sh $JBOSS_HOME/bin/
RUN chmod +x $JBOSS_HOME/bin/config-standalone.sh
RUN sed -i 's/\r$//' $JBOSS_HOME/bin/config-standalone.sh
# copy war file
COPY ./deployments/*.war $JBOSS_HOME/standalone/deployments/
# entry point
CMD ["sh", "/opt/jboss/wildfly/bin/start.sh"]
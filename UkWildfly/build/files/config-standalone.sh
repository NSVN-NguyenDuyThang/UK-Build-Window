if [ $DB_TYPE = 'postgresql' ]
then
	sed -i "s/{PG_DATASOURCE_OPEN}//g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_DATASOURCE_CLOSE}//g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{MSSQL_DATASOURCE_OPEN}/<!--/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{MSSQL_DATASOURCE_CLOSE}/-->/g" wildfly/standalone/configuration/standalone.xml
	
	sed -i "s/{PG_SERVER}/$DB_SERVER/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_DB_NAME}/$DB_NAME/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_USER}/$DB_USER/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_PASSWORD}/$DB_PASSWORD/g" wildfly/standalone/configuration/standalone.xml
else
	sed -i "s/{MSSQL_DATASOURCE_OPEN}//g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{MSSQL_DATASOURCE_CLOSE}//g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_DATASOURCE_OPEN}/<!--/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{PG_DATASOURCE_CLOSE}/-->/g" wildfly/standalone/configuration/standalone.xml
	
	sed -i "s/{MSSQL_SERVER}/$DB_SERVER/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{MSSQL_DB_NAME}/$DB_NAME/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{MSSQL_USER}/$DB_USER/g" wildfly/standalone/configuration/standalone.xml
	sed -i "s/{SA_PASSWORD}/$DB_PASSWORD/g" wildfly/standalone/configuration/standalone.xml
fi

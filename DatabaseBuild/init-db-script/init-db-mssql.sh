sa_password=$1
db_name=$2
mssql_container_name=$3
touch log.txt
docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -e -Q "DROP DATABASE $db_name" -o log.txt
docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -e -Q "CREATE DATABASE $db_name" -o log.txt
cat log.txt
if [ $? -eq 0 ]
then
	echo "Database is ready"
else
	exit 1
fi

docker cp init_db.sql $mssql_container_name:/usr/src/app/init_db.sql
sleep 1

for i in {1..90};
do
    docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -d $db_name -e -i init_db.sql -o log.txt
    if [ $? -eq 0 ]
    then
        echo "init-db.sql completed"
        exit 0
    else
        echo "not ready yet..."
        sleep 1
    fi
done
exit 1

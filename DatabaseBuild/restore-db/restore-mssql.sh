sa_password=$1
db_name=$2
mssql_container_name=$3

docker cp restore-db.bak $mssql_container_name:/usr/src/app/restore-db.bak
sleep 1

for i in {1..10};
do
    docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -d $db_name -Q "RESTORE DATABASE $db_name FROM DISK = 'restore-db.bak' WITH REPLACE;"
    if [ $? -eq 0 ]
    then
        echo "Run restore-db.bak completed"
        exit 0
    else
        echo "not ready yet..."
        sleep 1
    fi
done
exit 1
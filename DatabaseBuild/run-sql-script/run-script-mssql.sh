sa_password=$1
db_name=$2
mssql_container_name=$3

docker cp script.sql $mssql_container_name:/usr/src/app/script.sql
sleep 1

for i in {1..90};
do
    docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -d $db_name -e -i script.sql
    if [ $? -eq 0 ]
    then
        echo "Run script.sql completed"
        exit 0
    else
        echo "not ready yet..."
        sleep 1
    fi
done
exit 1
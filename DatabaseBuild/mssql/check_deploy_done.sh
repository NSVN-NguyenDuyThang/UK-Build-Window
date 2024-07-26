sa_password=$1
mssql_container_name=$2
for i in {1..10};
do
	docker exec -t $mssql_container_name /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $sa_password -Q 'SELECT 1'
	if [ $? -eq 0 ]
    then
        echo "MSSQL has deployed successfully!"
        break
    else
        echo "Not ready yet..."
        sleep 1
    fi
done

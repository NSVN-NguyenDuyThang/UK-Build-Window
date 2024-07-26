echo 'host all all all	password' >> /var/lib/postgresql/data/pg_hba.conf
sed -i 's/\r$//' /var/lib/postgresql/data/pg_hba.conf
#config pg
psql -U $POSTGRES_USER -c "ALTER SYSTEM SET max_wal_size = '2GB'"
/usr/lib/postgresql/14/bin/pg_ctl reload
# check server ready
for i in {1..10};
do
	psql -U $POSTGRES_USER -c '\l'
	if [ $? -eq 0 ]
    then
        echo "Postgresql has deployed successfully!"
        break
    else
        echo "Not ready yet..."
        sleep 1
    fi
done
#create db
DB_EXIST=$( psql -U $POSTGRES_USER -c '\l' | awk '{print($1)}' | grep $DB_NAME | sed 's/\r$//' )
echo $DB_EXIST
if [ $DB_EXIST = $DB_NAME ]
then
    echo "Database is ready!"
else
    echo "Database does not exist"
	psql -U $POSTGRES_USER -c 'CREATE DATABASE '$DB_NAME';'
	psql -U $POSTGRES_USER -c '\l' | grep $DB_NAME
	if [ $? -eq 0 ]
	then 
		echo 'Create database done!!!'	
	fi
	#restore db
	cd /usr/src/app/
	unzip pg_restore.zip
	pg_restore -x --no-owner -U $POSTGRES_USER -d $DB_NAME -v '/usr/src/app/pg_restore.bak'
	if [ $? -eq 0 ]
	then
		echo "Database is ready!"    
	fi
fi
rm -rf /usr/src/app/pg_restore.bak
rm -rf /usr/src/app/pg_restore.zip


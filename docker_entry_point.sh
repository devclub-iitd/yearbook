#!/bin/bash

echo "Script starts"

set -e

# RUN DATABASE_URL='' python manage.py collectstatic --noinput
DATABASE_URL='' python manage.py collectstatic --noinput

until psql $POSTGRES_HOST_URL -c '\l'; do
 	>&2 echo "Postgres is unavailable - sleeping"
 	sleep 1
done

if psql $POSTGRES_HOST_URL -lqt | cut -d \| -f 1 | grep -qw $POSTGRES_DB; then
    echo "DATABASE "$POSTGRES_DB" already exists"
else
    echo "DATABASE "$POSTGRES_DB" does not exists, creating DB"
   	psql $POSTGRES_HOST_URL -c "CREATE DATABASE $POSTGRES_DB ;"
   	psql $POSTGRES_HOST_URL -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER ;"
   	psql $POSTGRES_HOST_URL -l
fi

python3 manage.py makemigrations
python3 manage.py migrate
./yearbook_superuser.sh

## Creating a default admin table object if it does not already exists
python3 setAdminTable.py

## Add Users
python3 Scrape/Scrape.py
python3 CsvToDatabase.py
## Commenting this so that polls are not added multiple times
python3 addPolls.py


echo "Starting WEB Server"
python3 manage.py runserver 0.0.0.0:$DEPLOY_PORT

echo "Script complete"


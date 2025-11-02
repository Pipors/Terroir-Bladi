#!/bin/sh

sleep 3
# whoami
psql "postgresql://anas:mypassword@localhost:5432/mydatabase" -f  ./migration.sql 
psql "postgresql://anas:mypassword@localhost:5432/mydatabase" -f ./sample_data.sql

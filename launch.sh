#!/bin/sh

DOCKER=$(docker system df --format "{{.Size}}")
POSTGRES=$(docker ps --format "{{.Names}}")
# APP="/goinfre/aatbir/Backend/backend/backend"      #-- For School Mac
APP="C:\\Users\\anas\\Desktop\\terroir\\backend\\app"  #-- For Local Windows
# BUILD=$(docker-compose up -d)
IFS=$'\n'

# MIGRATION=$(ls /goinfre/aatbir/Backend/backend/backend/prisma/migrations/20251011154925_init | grep migration.sql) #-- For School Mac
MIGRATION=$(dir C:\\Users\\anas\\Desktop\\terroir\\backend\\app\\prisma\\migrations\\20251031204111_ | findstr migration.sql)
# DATA=$(ls /goinfre/aatbir/Backend/backend/backend | grep sample_data.sql)   #-- For School Mac
DATA=$(dir C:\\Users\\anas\\Desktop\\terroir\\backend\\app | findstr sample_data.sql)
# INIT_DB=$(ls /goinfre/aatbir/Backend/terroir/backend | grep init-database.sh)   #-- For School Mac
INIT_DB=$(dir C:\\Users\\anas\\Desktop\\terroir\\backend | findstr init-database.sql)
A=0
B=0
C=0
D=0

    # for i in {1..20}; do #-- For School Mac
dots() {
    printf "$1"
    for i in $(seq 1 20); do
        dots=$(( i % 4 ))
        printf "\b\b\b%-3s" "$(printf '.%.0s' $(seq 1 $dots))"
        sleep 0.5
    done
}

checkFile() {
  local migration=$(make exec CMD=ls | grep migration.sql)
  local data=$(make exec CMD=ls | grep sample_data.sql)
  local init_db=$(make exec CMD=ls | grep init-database.sh)


  dots "\033[32mSearching for needed dependencies   \033[0m"
  if [[ "$migration" != "migration.sql" ]]; then
    printf "\033[31m\nmigration file for creating relations is not found\033[0m\n"
    dots "\033[40;5;4m(｡◕‿‿◕｡) COPYING MIGRATION FILE (｡◕‿‿◕｡)   \033[0m"
    docker cp C:\\Users\\anas\\Desktop\\terroir\\backend\\app\\prisma\\migrations\\20251031204111_\\migration.sql my_postgres:/
    # docker cp /goinfre/aatbir/Backend/backend/backend/prisma/migrations/20251011154925_init/migration.sql my_postgres:/  #-- For School Mac
    A=1
  fi
  # sleep 1
  if [[ "$data" != "sample_data.sql" ]]; then
    printf "\033[31m\nMock data file is not found \033[0m"
    dots "\n\033[40;5;4m(｡◕‿‿◕｡) COPYING DATA FILE (｡◕‿‿◕｡)   \033[0m"
    docker cp C:\\Users\\anas\\Desktop\\terroir\\backend\\app\\sample_data.sql my_postgres:/
    B=1
  fi
  # sleep 1
  if [[ "$init_db" != "init-database.sh" ]]; then
    printf "\033[31m\nDatabase initialization file is not found \033[0m"
    dots "\033[40;5;4m(｡◕‿‿◕｡) COPYING INIT DATABASE FILE (｡◕‿‿◕｡)   \033[0m"
    docker cp C:\\Users\\anas\\Desktop\\terroir\\backend\\init-database.sh my_postgres:/
    C=1
  fi
  # sleep 1
  # printf "A=$A, B=$B, C=$C"
  if [[ "$A" -eq 1 ]] && [[ "$B" -eq 1 ]] && [[ "$C" -eq 1 ]]; then
    dots "\033[40;5;5m\n(｡◕‿‿◕｡)EXECUTING DATABASE SCRIPTS(｡◕‿‿◕｡)   \033[0m"
    make exec CMD="chmod +x ./init-database.sh"
    # sleep 2
    make exec CMD="./init-database.sh"
    # sleep 3
    D=1
    printf "\033[40;5;5m\nRelations & Mock have been applied to the database\033[0m"
  fi
  # $@
}

dots "\n\033[40;5;37m(｡◕‿‿◕｡) SEARCHING FOR POSTGRES CONTAINER (｡◕‿‿◕｡)   \033[0m"

if  [[ -z "$POSTGRES" ]]; then
	print "\n\033[40;5;1mPOSTGRES CONTAINER 🐳 NOT FOUND... STARTING THE BUILDING 🔨\033[0m\n\n"
	docker-compose up -d
	# break
elif [[ "$POSTGRES" == "my_postgres" ]]; then
	printf "\n\033[40;5;30m\n／人◕ ‿‿ ◕人＼POSTGRES CONTAINER 🐳 IS FOUND... STARTING THE APP 🔨\033[40;5;30m／人◕ ‿‿ ◕人＼\033[0m\n"
  npm --prefix ./app run start:dev
else
	for val in $DOCKER; do
		if [ "$val" != "0B" ]; then
			if  [ "$POSTGRES" != "my_postgres" ]; then
				make stop
				make rmc
				make rmi
				make rmv
				docker-compose up -d
				break;
			else
				break;
			fi
		fi
	done
fi

checkFile

if [[ "$D" -eq 1 ]]; then
  if ! [ -d "./app/node_modules" ]; then
    npm --prefix ./app install
  fi
  npx --prefix .\\app prisma generate --schema=./prisma/schema.prisma
  sleep 2 
  npm --prefix ./app run start:dev
fi
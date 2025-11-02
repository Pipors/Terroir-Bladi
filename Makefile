# This Makefile provides a set of commands to manage Docker containers, images, and volumes.
# images=$$(docker images -aq)  -- IO 
images=$$(docker image ls -aq)    # -- windows cmd
containers=$$(docker ps -aq)
volumes=$$(docker volume ls)
shell:=/bin/bash

#Starts all services defined in the docker-compose file in detached mode.
all: 
	@./launch.sh

#Stops all running Docker containers.
stop:
	@docker stop ${containers}

#Removes all stopped Docker containers.
rmc:
	@docker rm ${containers}

#Removes all Docker images.
rmi:
	@docker rmi ${images}

#Removes all Docker volumes.
rmv:
	@docker volume rm ${volumes}

#Lists all running Docker containers.
ps:
	@docker ps

#Displays Docker system disk usage.
df: 
	@docker system df

#Combines stop, rm, and rmi to clean up containers and images. 
delete: stop rmc rmi rmv

#Removes all unused data (containers, images, volumes).
prune:
	@docker system prune -a

#Executes a command in a running container specified by CMD variable.
exec: 
	@docker exec -it ${containers} ${CMD}

re: delete all
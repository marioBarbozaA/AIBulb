// El primero borra los contenedores, el segundo la network y el tercero borra los volumenes
docker container rm -f $(docker container ls -aq)

docker network rm aibulb_OurNetwork

docker volume prune

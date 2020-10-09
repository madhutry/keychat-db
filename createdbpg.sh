#docker pull postgres



#docker exec -t dev-postgres pg_dumpall -s -U postgres > dev-postgres_dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
rm -rf mkdir ${HOME}/dockervol/
mkdir ${HOME}/dockervol/
docker run -d \
	--name prod-pg \
    -e POSTGRES_PASSWORD=keychatusr1 \
	-v ${HOME}/dockervol/postgres-data-prod/:/var/lib/postgresql/data \
        -p 5433:5432\
        postgres


cat prod-keychatdb-postgres_dump_09-10-2020_16_17_48.sql | docker exec -i prod-pg psql -U postgres  

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' prod-pg

# Instrucciones Kafka

### Crear contenedor de kafka

Desde la carpeta donde se encuentra el "docker-compose-kafka.yml"

```javascript
docker-compose -f docker-compose-kafka.yml up
```

### Para usar la linea de comandos del contenedor de kafka

```javascript
docker exec -it kafka-server /bin/bash
```
### Para crear un topic

Desde la línea de comandos "kafka-server" creo el topic

```javascript
/opt/bitnami/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic provider-update-info
```
### Para listar los topics

```javascript
opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```

### Para leer messages en un topic:

```javascript
opt/bitnami/kafka/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic provider-update-info --from-beginning
```
### Para correr api-producer.js y api-consumer.js se debe instalar lo siguiente:

```javascript
npm install kafka-node
npm install kafkajs
npm install express
npm install mongodb
```

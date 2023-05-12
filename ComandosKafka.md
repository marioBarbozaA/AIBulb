# Instrucciones Kafka

### Para leer messages en un topic:

```javascript
docker exec -it kafka-server /bin/bash
cd opt/bitnami/kafka
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic my-topic --from-beginning
```
### Para correr api-producer.js y api-consumer.js se debe instalar lo siguiente:

```javascript
npm install kafka-node
npm install kafkajs
npm install express
```

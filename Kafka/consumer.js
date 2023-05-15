const { MongoClient } = require('mongodb');
const { Kafka, logLevel } = require("kafkajs")

const clientId = "provider"
const brokers = ["localhost:9092"]
const topic = "provider-update-info"

const kafka = new Kafka({
	clientId,
	brokers,
})


const consumer = kafka.consumer({
	groupId: clientId,
	// wait for at most 3 seconds before receiving new data
	maxWaitTimeInMs: 3000,
})

const mongoUri = 'mongodb://25.3.224.0:27017';
const dbName = 'disponibles';
const collectionName = 'proveedores';

const consume = async () => {
	await consumer.connect()
	await consumer.subscribe({ topic, fromBeginning: true })
	await consumer.run({
		eachMessage: async ({ message }) => {
			const valueMessage = message.value.toString();
      console.log(`Received message: ${valueMessage}`);
      try {
        const client = new MongoClient(mongoUri, {
			useNewUrlParser: true,
			useUnifiedTopology: true,
		  });
        const collection = client.db(dbName).collection(collectionName);
        const document = JSON.parse(valueMessage);
		console.log(document);
		await collection.updateOne(
			{ _id: document._id, pais: document.pais }, // Proveedor que vamos a actualizar
			{ $set: document }, // the update operation to apply
		);
        //collection.insertOne(document); // Para insertar servicios

		console.log(`Message with value ${valueMessage} updated in MongoDB`);
      } catch (err) {
        console.error(`Error storing message ${message.offset} in MongoDB: ${err.message}`);
      }
		},
	})
}
consume().catch((err) => {
	console.error("error in consumer: ", err)
})
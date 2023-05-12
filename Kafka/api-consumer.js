const { MongoClient } = require('mongodb');
const { Kafka, logLevel } = require("kafkajs")

const clientId = "my-app"
const brokers = ["localhost:9092"]
const topic = "my-topic"

const kafka = new Kafka({
	clientId,
	brokers,
	// logCreator: customLogger,
	//logLevel: logLevel.DEBUG,
})

// the kafka instance and configuration variables are the same as before

// create a new consumer from the kafka client, and set its group ID
// the group ID helps Kafka keep track of the messages that this client
// is yet to receive
const consumer = kafka.consumer({
	groupId: clientId,
	// wait for at most 3 seconds before receiving new data
	maxWaitTimeInMs: 3000,
})

const mongoUri = 'mongodb://mongo:27017';
const dbName = 'disponibles';
const collectionName = 'servicios';

const consume = async () => {
	// first, we wait for the client to connect and subscribe to the given topic
	await consumer.connect()
	await consumer.subscribe({ topic, fromBeginning: true })
	await consumer.run({
		// this function is called every time the consumer gets a new message
		eachMessage: ({ message }) => {
			const value = message.value.toString();
      console.log(`Received message: ${value}`);
      try {
        //const client =  MongoClient.connect(mongoUri);
        //const collection = client.db(dbName).collection(collectionName);
        //const document = JSON.parse(value);
        //collection.insertOne(document);
        console.log(`Message ${message.offset} ${message.value} stored in MongoDB`);
      } catch (err) {
        console.error(`Error storing message ${message.offset} in MongoDB: ${err.message}`);
      }
		},
	})
}
consume().catch((err) => {
	console.error("error in consumer: ", err)
})
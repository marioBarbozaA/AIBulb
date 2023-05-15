// Import the kafkajs library in your Node.js application:
const { Kafka } = require('kafkajs');

// Set up a Kafka client by creating a new Kafka instance and configuring it with the necessary options:
const kafka = new Kafka({
  clientId: 'my-app',
  brokers: ['172.19.0.2:9092'], // Replace with the IP address and port of your Kafka brokers
});

// Create an async function to run your Kafka producer and consumer:
async function run() {
  // Create a Kafka producer to publish messages to Kafka topics:
  const producer = kafka.producer();

  await producer.connect();

  await producer.send({
    topic: 'my-topic',
    messages: [
      { value: 'Hello Kafka!' },
      { value: 'This is a message from Node.js' }
    ],
  });

  await producer.disconnect();

  // Create a Kafka consumer to subscribe to Kafka topics and consume messages:
  const consumer = kafka.consumer({ groupId: 'my-group' });

  await consumer.connect();

  await consumer.subscribe({ topic: 'my-topic', fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log({
        value: message.value.toString(),
      });
    },
  });

  await consumer.disconnect();
}

// Call the run() function to start your Kafka producer and consumer:
run();
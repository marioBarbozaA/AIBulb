const express = require('express');
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'my-app',
  brokers: ['localhost:9092'],
  // Add session timeout configuration
  consumer: {
    sessionTimeout: 30000,
  },
});

const app = express();

function delay(time) {
    return new Promise(resolve => setTimeout(resolve, time));
}

app.get('/messages', async (req, res) => {
  try {
    const consumer = kafka.consumer({ groupId: 'my-group' });
    await consumer.connect();
    await consumer.subscribe({ topic: 'my-topic', fromBeginning: true });

    const messages = [];

    await consumer.run({
        eachMessage
        : async ({ topic, partition, message }) => {
          console.log({
            partition,
            offset: message.offset,
            value: message.value.toString(),
          })
        },
      })

      //await delay(5000);


    await consumer.disconnect();

    res.json(messages);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(3010, () => {
  console.log('Server listening on port 3010');
});
const express = require('express');
const { Kafka } = require('kafkajs');

const app = express();
const kafka = new Kafka({
  clientId: 'my-app',
  brokers: ['localhost:9092'],
});

app.use(express.json());

app.post('/messages', async (req, res) => {
  const { id } = req.body;
  const { message } = req.body;

  const producer = kafka.producer();
  await producer.connect();

  await producer.send({
    topic: 'my-topic',
    messages: [{ key: id, value: message }],
  });

  await producer.disconnect();

  res.sendStatus(200);
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
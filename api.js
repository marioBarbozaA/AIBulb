const express = require('express');
const MongoClient = require('mongodb').MongoClient;

const app = express();
const port = 3000;

// Replace the following with your MongoDB cluster connection string
const uri = 'mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<dbname>?retryWrites=true&w=majority';

// Replace the following with your MongoDB collection and field names
const collectionName = 'myCollection';
const fieldName = 'myField';

app.get('/update/:id/:value', async (req, res) => {
  const id = req.params.id;
  const value = req.params.value;

  const client = new MongoClient(uri);
  try {
    await client.connect();
    const database = client.db('myDatabase');
    const collection = database.collection(collectionName);
    const result = await collection.updateOne({ _id: id }, { $set: { [fieldName]: value } });
    console.log(`${result.modifiedCount} document(s) updated.`);
    res.send(`${result.modifiedCount} document(s) updated.`);
  } catch (err) {
    console.error(err);
    res.status(500).send(err.message);
  } finally {
    await client.close();
  }
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
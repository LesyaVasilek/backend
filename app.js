const express = require('express');
const fs = require('fs');
const app = express();

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ status: 'ok', message: 'Backend is running' });
});

app.get('/data', (req, res) => {
  try {
    const data = fs.readFileSync('data.txt', 'utf8');
    res.json({ data: data });
  } catch (error) {
    res.json({ data: '' });
  }
});

app.post('/submit', (req, res) => {
  try {
    const { text } = req.body;
    
    if (!text) {
      return res.status(400).json({ error: 'No text provided ' });
    }
    
    // Save to data.txt
    fs.appendFileSync('data.txt', text + '\n', 'utf8');
    
    res.json({ message: 'Data saved  succesully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(5000, () => {
  console.log('Backend running on http://localhost:5000');
});

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Webera Node.js container!',
    node_version: process.version,
    environment: process.env.NODE_ENV
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
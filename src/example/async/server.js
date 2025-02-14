const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const port = 3001;

// Middleware to parse JSON bodies
app.use(bodyParser.json());

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on http://localhost:${port}`);
});

// Serve example.js
app.get('/main.js', (req, res) => {
    res.sendFile(path.join(__dirname, '../../../target/js/release/build/example/async/async.js'));
});

// Serve index.html
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
    console.log('GET /');
});



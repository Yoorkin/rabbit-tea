const http = require('http');
const fs = require('fs');
const path = require('path');

const resources = {
    '/main.js': '/target/js/release/build/main/main.js',
    '/index.html': '/index.html',
    '/': '/index.html',
}

var data = {
    notes: [
        {
            "title": "",
            "content": "This is a note. Click on the edit button to start editing."
        },
        {
            "title": "",
            "content": "This is a note."
        },
        {
            "title": "Todo",
            "content": "delete this note"
        }
    ]
}

// Define the request handler
const requestHandler = (req, res) => {
    const relpath = resources[req.url];
    if (relpath && fs.existsSync(path.join(__dirname, relpath))) {
        console.log("request file", req.url);
        const filePath = path.join(__dirname, relpath);
        fs.readFile(filePath, (err, data) => {
            if (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end('Internal Server Error');
                return;
            }
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(data);
        });
    } else if (req.url === '/api/data.json') {
        // Serve the JSON data
        console.log("request api", req.url);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(data));
    } else {
        // Handle 404 Not Found
        console.log("requested resource not found", req.url);
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('Not Found');
    }
};

// Create the server
const server = http.createServer(requestHandler);

// Define the port to listen on
const port = 3000;

// Start the server
server.listen(port, (err) => {
    if (err) {
        return console.log('Something went wrong:', err);
    }
    console.log(`Server is listening on http://localhost:${port}`);
});
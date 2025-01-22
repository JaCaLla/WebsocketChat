const WebSocket = require('ws');
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

const server = app.listen(8080, () => {
  console.log('HTTP Server listening at 8080 port');
});

const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  console.log('Client connected');

  ws.on('message', (message) => {
    console.log(`Message recived: ${message}`);
    
    // Send message to all connected clients
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message.toString());
      }
    });
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });
});

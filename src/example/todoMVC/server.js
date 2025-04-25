import express from 'express';
import bodyParser from 'body-parser';

export default function () {

    const app = express();
    const port = 3000;

    // Middleware to parse JSON bodies
    app.use(bodyParser.json());

    // In-memory storage for cards
    let cards = [
        {
            "title": "",
            "content": "This is a note. Click on the edit button to start editing.",
            "id": 1
        },
        {
            "title": "",
            "content": "This is a note.",
            "id": 2
        },
        {
            "title": "Todo",
            "content": "delete this note",
            "id": 3
        }
    ]

    // GET /api/cards - Retrieve all cards
    app.get('/api/cards', (req, res) => {
        res.json({ cards: cards });
        console.log("GET /api/cards", cards);
    });

    // GET /api/cards/:id - Retrieve all cards
    app.get('/api/cards/:id', (req, res) => {
        const cardId = parseInt(req.params.id, 10);
        const cardIndex = cards.findIndex(card => card.id === cardId);
        res.json(cards[cardIndex]);
        console.log(`GET /api/cards/${cardId}`, cards[cardIndex]);
    });

    // POST /api/cards - Create a new card
    app.post('/api/cards', (req, res) => {
        const newCard = req.body;
        newCard.id = cards.length + 1; // Simple ID assignment
        cards.push(newCard);
        res.status(201).json(newCard);
        console.log("POST /api/cards", newCard);
    });

    // PATCH /api/cards/:id - Update a card
    app.patch('/api/cards/:id', (req, res) => {
        const cardId = parseInt(req.params.id, 10);
        const cardIndex = cards.findIndex(card => card.id === cardId);

        if (cardIndex === -1) {
            return res.status(404).json({ error: 'Card not found' });
        }

        const updatedCard = { ...cards[cardIndex], ...req.body };
        cards[cardIndex] = updatedCard;
        res.json(updatedCard);
        console.log(`PATCH /api/cards/${cardId}`, updatedCard);
    });

    // DELETE /api/cards/:id - Delete a card
    app.delete('/api/cards/:id', (req, res) => {
        const cardId = parseInt(req.params.id, 10);
        const cardIndex = cards.findIndex(card => card.id === cardId);

        if (cardIndex === -1) {
            return res.status(404).json({ error: 'Card not found' });
        }

        cards.splice(cardIndex, 1);
        res.status(204).send();
        console.log(`DELETE /api/cards/${cardId}`);
    });

    // Start the server
    app.listen(port, () => {
        console.log(`Server is listening on http://localhost:${port}`);
    });
}

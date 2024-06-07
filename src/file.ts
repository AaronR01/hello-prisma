import express, { Request, Response } from 'express';

const app = express();
const port = 3000;

app.get('/', (req: Request, res: Response) => {
    res.send('Hello, world!');
});

app.get("/api/CreateUser/:nome",(req: Request, res: Response) => {
    const nome = req.body
    res.send("okayC "+nome).status(200)
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
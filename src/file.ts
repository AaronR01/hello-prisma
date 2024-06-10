import express, { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client'
import { stringify } from 'querystring';

const prisma = new PrismaClient()
const app = express();
const port = 3000;

app.get('/', (req: Request, res: Response) => {
    res.send('Hello, world!');
});

app.get("/api/CreateUser/",(req: Request, res: Response) => {
    res.send("okay").status(200)
});

app.get("/api/CreateUser/:nome",(req: Request, res: Response) => {
    const nome = req.body
    res.send("okay"+nome).status(200)
});

app.get('/publish/', async (req, res) => {
    const post = await prisma.user.create({
            data: {
                name: "nome",
                password: "senha",
                telefone: "123-4123-51223-333",
            }
        })
        console.log(post)
        res.send(post).status(200)
    })

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
import express, { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client'
import * as crypto from "crypto";

const prisma = new PrismaClient()
const app = express();
const port = 3000;

function createSHA256Hash(inputString: string) {
    const hash = crypto.createHash('sha256');
    hash.update(Buffer.from(inputString));
    return hash.digest('hex');
}

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

app.get('/api/login/:user/:password', async (req, res) => {
    const {user} = req.params
    const {password} = req.params
    
    const post = await prisma.user.findMany({

        })
        console.log(post)
        res.send(post).status(200)
    })

    app.get('/api/createUser/:user/:password/:telefone/:email', async (req, res) => {
        const { user } = req.params
        const { email } = req.params
        const { password } = req.params
        const { telefone } = req.params
        const hashpass = createSHA256Hash(password)
        const serverlog = await prisma.user.create({
            data: {
                name: user,
                email: email,
                password: hashpass,
                telefone: telefone,
            }
        })
        console.log(serverlog)
        res.send(serverlog).status(200)
    })

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
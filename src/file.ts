import express, { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client'
import * as crypto from "crypto";

const prisma = new PrismaClient()
const app = express();
const port = 5000;

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

app.get('/api/login/:login/:password', async (req, res) => {
    const {login} = req.params
    const {password} = req.params
    const post = await prisma.user.findUnique({
        where: {
            email: login
        }})
    console.log(post)
    if (post?.password == password){
        res.send(post.id+"").status(200)
    }
    else {
        res.send("Wrong password").status(406)
    }
})

app.get('/api/fazenda/:id', async (req, res) => {
    const {id} = req.params
    const post = await prisma.user.findUnique({
        where: {
            id : parseInt(id)
        }
        
        
        })
    console.log(post)
})

app.post('/api/createUser/:user/:password/:telefone/:email', async (req, res) => {
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
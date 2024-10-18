const bcrypt = require('bcryptjs');
import { Router, Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

const router = Router();


//Rota para registrar um usuário (problema no banco de dados, parece que tem algum problema com o ID do usuário)
router.post('/register', async (req: Request, res: Response) => {
    const { email, nome, senha, telefone} = req.body;

    const hashSenha = await bcrypt.hash(senha, 10);

    try {
        const user = await prisma.user.create({
            data: {
                email,
                nome,
                senha: hashSenha,
                telefone,
                eh_administrador: false
            }
        });

        res.json(user);
    } catch (error) {
        console.error('Erro ao registrar o usuário:', error);
        res.status(400).json({ error: 'Ocorreu um erro!' });
    }
});

export default router;
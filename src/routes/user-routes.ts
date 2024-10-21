const bcrypt = require('bcryptjs');
import { Router, Request, Response } from 'express';
import { prisma } from "../database/prisma";

const router = Router();

// Rota para a criação do adm do sistema
router.post('/registerSysAdmin', async (req: Request, res: Response) => {
    const { email, nome, senha, telefone} = req.body;

    const hashSenha = await bcrypt.hash(senha, 10);

    try {
        const user = await prisma.administrador_sistema.create({
            data: {
                email,
                nome,
                senha: hashSenha,
                telefone,
            }
        });

        res.json(user);
    } catch (error) {
        console.error('Erro ao registrar o usuário:', error);
        res.status(400).json({ error: 'Ocorreu um erro!' });
    }
});

//rota para a criação de um usuário comum que eh administrador de uma fazenda
//implementar futuramente um middleware para verificar se o usuário é um administrador do sistema
router.post('/registerUserAdm/:id', async (req: Request, res: Response) => {
    const { nomeFzd, cidade, estado, proprietario, email, nomeUser, telefone, senha } = req.body;
    const { id } = req.params;

    try {
        const adminExists = await prisma.administrador_sistema.findUnique({
            where: { id }
        });

        if (!adminExists) {
            return res.status(404).json({ error: 'Administrador não encontrado!' });
        }

        const fazenda = await prisma.fazenda.create({
            data: {
                nome: nomeFzd,
                cidade,
                estado,
                proprietario,
                id_adm: {
                    connect: {
                        id: id
                    }
                }
            }
        });

        const hashSenha = await bcrypt.hash(senha, 10);

        const user = await prisma.user.create({
            data: {
                email,
                nome: nomeUser,
                senha: hashSenha,
                telefone,
                eh_administrador: true,
                id_fazenda: {
                    connect: {
                        id: fazenda.id
                    }
                }
            }
        });

        return res.status(201).json({ fazenda, user });

    } catch (error) {
        console.error('Erro ao registrar:', error);
        return res.status(500).json({ error: 'Ocorreu um erro ao registrar a fazenda ou o usuário' });
    }
});

export default router;
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
router.post('/registerUserAdm/:admId', async (req: Request, res: Response) => {
    const { nomeFzd, cidade, estado, proprietario, email, nomeUser, telefone, senha } = req.body;
    const { admId } = req.params;

    try {
        const adminExists = await prisma.administrador_sistema.findUnique({
            where: { id : admId }
        });

        if (!adminExists) {
            return res.status(404).json({ error: 'Administrador não encontrado!' });
        }

        const hashSenha = await bcrypt.hash(senha, 10);

        const user = await prisma.user.create({
            data: {
                email,
                nome: nomeUser,
                senha: hashSenha,
                telefone,
                eh_administrador: true,
                fazenda: {
                    create: {
                        nome: nomeFzd,
                        cidade,
                        estado,
                        proprietario,
                        adm: {
                            connect: {
                                id: admId
                            }   
                    }
                }
            }
        }
        });

        return res.status(201).json({ user });

    } catch (error) {
        console.error('Erro ao registrar:', error);
        return res.status(500).json({ error: 'Ocorreu um erro ao registrar a fazenda ou o usuário' });
    }
});

// Fazer login do usuario adm
router.post('/login', async (req: Request, res: Response) => {
    const { email, senha } = req.body;

    try {
        const user = await prisma.user.findFirst({
            where: { email }
        });

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado!' });
        }

        const senhaValida = await bcrypt.compare(senha, user.senha);

        if (!senhaValida) {
            return res.status(401).json({ error: 'Senha inválida!' });
        }

        return res.json(user);

    } catch (error) {
        console.error('Erro ao fazer login:', error);
        return res.status(500).json({ error: 'Ocorreu um erro ao fazer login' });
    }
});

// Rota para obter informações de um usuário pelo ID
router.get('/user/:id', async (req: Request, res: Response) => {
    const { id } = req.params;

    try {
        const user = await prisma.user.findUnique({
            where: { id },
            include: {
                fazenda: true
            }
        });

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado!' });
        }

        return res.json(user);

    } catch (error) {
        console.error('Erro ao obter informações do usuário:', error);
        return res.status(500).json({ error: 'Ocorreu um erro ao obter informações do usuário' });
    }
});

// Rota para editar o nome, telefone e email do usuário
router.put('/user/:id', async (req: Request, res: Response) => {
    const { id } = req.params;
    const { nome, telefone, email } = req.body;

    try {
        const user = await prisma.user.update({
            where: { id },
            data: {
                nome,
                telefone,
                email
            }
        });

        return res.json(user);

    } catch (error) {
        console.error('Erro ao atualizar informações do usuário:', error);
        return res.status(500).json({ error: 'Ocorreu um erro ao atualizar informações do usuário' });
    }
});

export default router;
import { prisma } from "../database/prisma";
import { Router, Request, Response } from 'express';

const router = Router();

router.post('/create', async (req: Request, res: Response) => {
    const {nome} = req.body;

    try {
        const alimento = await prisma.alimento.create({
            data: {
                nome
            }
        });
        return res.status(201).json(alimento);
    } catch (error) {
        return res.status(400).json({ error: error instanceof Error ? error.message : 'An unknown error occurred' });
    }
})

export default router;
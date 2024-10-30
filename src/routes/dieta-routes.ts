import { prisma } from "../database/prisma";
import { Router, Request, Response } from 'express';

const router = Router();

// Rota para a atualização de uma receita conectando com a dieta
router.post('/update/:loteId', async (req: Request, res: Response) => {
    const { receitas } = req.body;
    const { loteId } = req.params;

    const dietaAtual = await prisma.dieta.findFirst({
        where: {
            id_lote: loteId,
            eh_atual: true,
        },
    });

    if (dietaAtual) {
        await prisma.dieta.update({
            where: {
                id: dietaAtual.id,
            },
            data: {
                eh_atual: false,
            },
        });
    }

    try {
        const dieta = await prisma.dieta.create({
            data: {
                eh_atual: true,
                lote: {
                    connect: {
                       id: loteId
                    }
                }
            }
        });

        const receitasCriadas = await Promise.all(
            receitas.map(async (receita: { quantidade: number, alimentoId: number }) => {
                return await prisma.receita.create({
                    data: {
                        quantidade: receita.quantidade,
                        dieta: {
                            connect: {
                                id: dieta.id,
                            },
                        },
                        alimento: {
                            connect: {
                                id: receita.alimentoId,
                            },
                        },
                    }
                });
            })
        );

        res.json(receitasCriadas);
    } catch (error) {
        console.error('Erro ao registrar as receitas:', error);
        res.status(400).json({ error: 'Ocorreu um erro ao registrar as receitas!' });
    }
})

// Rota para a listagem de receitas de uma dieta
router.get('/listDieta/:loteId', async (req: Request, res: Response) => {
    const { loteId } = req.params;

    const dietaAtual = await prisma.dieta.findFirst({
        where: {
            id_lote: loteId,
            eh_atual: true,
        },
    });

    if (!dietaAtual) {
        return res.status(404).json({ error: 'Dieta não encontrada!' });
    }

    const receitas = await prisma.receita.findMany({
        where: {
            id_dieta: dietaAtual.id,
        },
        include: {
            alimento: true,
        },
    });

    res.json(receitas);
})

export default router;
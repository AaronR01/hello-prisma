import { prisma } from "../database/prisma";
import { Router, Request, Response } from 'express';

const router = Router();


// Procura a dieta atual e cria uma análise para um lote,a imagem eh opcional como tinhamos conversado
router.post('/create/:loteId', async (req: Request, res: Response) => {
    const {loteId} = req.params;
    const {imagem, disposicao, manejo, comportamento, clima, data, resultado} = req.body;

    try {
        const dietaAtual = await prisma.dieta.findFirst({
            where: {
            eh_atual: true,
            id_lote: loteId
            }
        });

        if (!dietaAtual) {
            return res.status(404).json({ error: "Dieta atual não encontrada" });
        }

        const analise = await prisma.analise.create({
            data: {
                disposicao,
                manejo,
                comportamento,
                clima,
                data,
                resultado,
                imagem: imagem || null,
                Dieta: {
                    connect: { id: dietaAtual.id }
                },
                lote: {
                    connect: { id: loteId }
                }
            }
        });

        res.status(201).json(analise);
    } catch (error) {
        res.status(500).json({ error: "Erro ao criar análise" });
    }
})

// Lista todas as análises incluindo as receitas das dietas correspondentes, calha dar um /list para voces verem o formato json que entrega (bem rico)
router.get('/list/:loteId', async (req: Request, res: Response) => {
    const {loteId} = req.params;

    try {
        const analises = await prisma.analise.findMany({
            where: {
                id_lote: loteId
            },
            include: {
                Dieta: {
                    include: {
                        Receita: {
                            include: {
                                alimento: {
                                    select: {
                                        nome: true
                                    }
                                }
                            }
                        }
                    }
                },
                lote: true
            }
        });

        res.status(200).json(analises);
    } catch (error) {
        res.status(500).json({ error: "Erro ao buscar análises" });
    }
})

export default router;
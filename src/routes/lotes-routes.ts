import { prisma } from "../database/prisma";
import { Router, Request, Response } from 'express';


const router = Router();

router.post('/register/:fazendaId', async (req: Request, res: Response) => {
   const { nome, tamanho, quantidade_animais} = req.body;
   const { fazendaId } = req.params;


   try {
       const user = await prisma.lote.create({
            data: {
               nome,
               quantidade_animais,
               tamanho,
               fazenda: {
                connect: {
                    id: fazendaId
                }
            }
            }
       });

       res.json(user);
   } catch (error) {
       console.error('Erro ao registrar o lote:', error);
       res.status(400).json({ error: 'Ocorreu um erro!' });
   }
});


router.get('/listAll/:fazendaId', async (req: Request, res: Response) => {

    const { fazendaId } = req.params;

    try {
        const lotes = await prisma.lote.findMany({
            where: {
                id_fazenda: fazendaId
            }
        });
        res.json(lotes);
    } catch (error) {
        console.error('Erro ao listar os lotes:', error);
        res.status(400).json({ error: 'Ocorreu um erro!' });
    }
});

router.get('/listLote/:loteId', async (req: Request, res: Response) => {
    const { loteId } = req.params;

    try {
        const lote = await prisma.lote.findUnique({
            where: {
                id: loteId
            }
        });

        res.json(lote);
    } catch (error) {
        console.error('Erro ao listar o lote:', error);
        res.status(400).json({ error: 'Ocorreu um erro!' });
    }
});

export default router;
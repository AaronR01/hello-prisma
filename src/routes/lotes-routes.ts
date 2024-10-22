import { prisma } from "../database/prisma";
import { Router, Request, Response } from 'express';


const router = Router();

router.post('/registerLote/:id', async (req: Request, res: Response) => {
   const { quantidade_animais, nome, tamanho} = req.body;


   try {
       const user = await prisma.lote.create({
            data: {
               nome,
               quantidade_animais,
               tamanho,
               id_fazenda: req.params.id
            }
       });

       res.json(user);
   } catch (error) {
       console.error('Erro ao registrar o lote:', error);
       res.status(400).json({ error: 'Ocorreu um erro!' });
   }
});

// Implementação das entidades relacionadas a fazenda

export default router;
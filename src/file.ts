import express from 'express';
import userRoutes from './routes/user-routes';
import dietaRoutes from './routes/dieta-routes';
import lotesRoutes from './routes/lotes-routes';
import alimentoRoutes from './routes/alimento-routes';
import analiseRoutes from './routes/analise-routes';
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

app.use('/analise', analiseRoutes);

app.use('/users', userRoutes);

app.use('/dieta', dietaRoutes);

app.use('/lotes', lotesRoutes);

app.use('/alimento', alimentoRoutes);


const port = 5001;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
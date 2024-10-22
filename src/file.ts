import express from 'express';
import userRoutes from './routes/user-routes';
import fzdRoutes from './routes/fzd-routes';
import lotesRoutes from './routes/lotes-routes';
import dotenv from 'dotenv';


dotenv.config();
const app = express();
app.use(express.json());


app.use('/users', userRoutes);

app.use('/fzd', fzdRoutes);

app.use('/lotes', lotesRoutes);


const port = 5001;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
import express from 'express';
import userRoutes from './routes/user-routes';
import fzdRoutes from './routes/fzd-routes';
import dotenv from 'dotenv';


dotenv.config();
const app = express();
app.use(express.json());


app.use('/users', userRoutes);

app.use('/fzd', fzdRoutes);


const port = 5001;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
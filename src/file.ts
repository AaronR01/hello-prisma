import express from 'express';
import userRoutes from './routes/user-routes';
import dotenv from 'dotenv';


dotenv.config();
const app = express();
app.use(express.json());


app.use('/api', userRoutes);


const port = 5000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
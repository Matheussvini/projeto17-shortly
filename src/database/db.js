import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const { Pool } = pg;

export const connnectionDB = new Pool({
    connnectionString: process.env.DATABASE_URL,
});
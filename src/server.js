import express from "express";
import cors from "cors";
import dotenv from "dotenv";
dotenv.config();

import usersRoutes from "./routes/users.routes.js";
import urlsRoutes from "./routes/urls.routes.js";

const app = express();
app.use(cors());
app.use(express.json());

app.use(usersRoutes);
app.use(urlsRoutes);

const port = process.env.PORT;
app.listen(port, () => console.log(`Server running in port: ${port}`));

import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { connnectionDB } from "../database/db.js";
dotenv.config();

export default async function authValidation(req, res, next) {
  try {
    const { authorization } = req.headers;
    const token = authorization?.replace("Bearer ", "");
    const secretKey = process.env.JWT_SECRET;

    if (!token) {
      return res.status(401).send({
        message:
          'Envie um header na requisição com campo "authorization" com valor "Bearer TokenDoUsuario"!',
      });
    }

    const data = jwt.verify(token, secretKey);

    const { rows } = await connnectionDB.query(
      "SELECT * FROM users WHERE id = $1",
      [data?.user_id]
    );

    const user = rows[0];

    if (!user) {
      return res
        .status(404)
        .send({ message: "Token inválido, faça login novamente." });
    }

    delete user.password;
    res.locals.user = user;
    next();
  } catch (err) {
    res.status(500).send(err.message);
  }
}

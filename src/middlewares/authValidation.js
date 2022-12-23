import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { connnectionDB } from "../database/db";
dotenv.config();

export async function authValidation(req, res, next) {
  const { authorization } = req.headers;
  const token = authorization?.replace("Bearer ", "");
  const secretKey = process.env.JWT_SECRET;

  if (!token) {
    return res.status(401).send({
      message:
        'Envie um header na requisição com campo "authorization" com valor "Bearer TokenDoUsuario"!',
    });
  }

  try {
    const data = jwt.verify(token, secretKey);

    const { rows } = await connnectionDB.query(
      "SELECT * FROM users WHERE id = $1",
      [data?.userId]
    );

    const user = rows[0];

    if (!user) {
      return res
        .status(404)
        .send({ message: "Token inválido, faça login novamente." });
    }

    delete user.password;
    res.locals.user = user;
  } catch (err) {
    res.status(500).send(err.message);
  }
  next();
}

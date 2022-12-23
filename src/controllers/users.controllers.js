import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { connnectionDB } from "../database/db.js";
import dotenv from "dotenv";
dotenv.config();

export async function createUser(req, res) {
  const { name, email, password } = res.locals.user;

  try {
    const passwordHash = bcrypt.hashSync(password, 10);

    await connnectionDB.query(
      "INSERT INTO users (name, email, password) VALUES ($1,$2,$3)",
      [name, email, passwordHash]
    );
    res.sendStatus(201);
  } catch (error) {
    res.status(500).send(err.message);
  }
}

export async function login(req, res) {
  try {
    const { email, password } = res.locals.user;
    const { rows } = await connnectionDB.query(
      "SELECT * FROM users WHERE email = $1",
      [email]
    );

    const user = rows[0];

    if (bcrypt.compareSync(password, user.password)) {
      const data = { user_id: user.id };
      const secretKey = process.env.JWT_SECRET;

      const token = jwt.sign(data, secretKey);

      delete user.password;

      res.status(200).send({ ...user, token });
    } else {
      res.status(401).send({
        message: "Senha incorreta, verifique sua senha e tente novamente.",
      });
    }
  } catch (error) {
    res.status(500).send(err.message);
  }
}

export async function findById(req, res) {
  const { id: idLocal } = req.locals.user;

  try {
    const query1 = await connnectionDB.query(
      `SELECT
                users.id,
                users.name,
                SUM(urls.visits) AS "visitCount"

            FROM users
            JOIN urls
            ON users.id = urls.user_id
            WHERE urls.user_id = $1
            GROUP BY users.id;
            `,
      [idLocal]
    );

    const query2 = await connnectionDB.query(
      `SELECT
            urls.id,
            urls."shortUrl",
            urls.url,
            urls.visits AS "visitCount"
        FROM urls
        JOIN users
        ON urls.user_id = users.id
        WHERE urls.user_id = $1
        GROUP BY urls.id
        `,
      [idLocal]
    );

    const {id, name,visitCount } = query1.rows[0];

    const result = {
        id,
        name,
        visitCount,
        shortenedUrls: query2.rows
    }

    res.status(200).send(result);



  } catch (error) {
    res.status(500).send(err.message);
  }
}

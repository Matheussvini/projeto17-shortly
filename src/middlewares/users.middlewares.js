import { connnectionDB } from "../database/db.js";
import { signInSchema, signUpSchema } from "../models/users.js";

async function emailExists(email) {
  const result = await connnectionDB.query(
    "SELECT * FROM users WHERE email = $1",
    [email]
  );
  return result;
}

export async function validShemaSignUp(req, res, next) {
  const { error } = signUpSchema.validate(req.body);
  if (error) return res.status(422).send(error.message);

  const user = req.body;

  if (user.password !== user.confirmPassword) {
    return res.status(409).send({ message: "Senhas não conferem!" });
  }

  const result = await connnectionDB.query(
    "SELECT * FROM users WHERE email = $1",
    [user.email]
  );
  if (result.rowCount !== 0) {
    return res.status(409).send({
      message:
        "Email já cadastrado, por favor efetue o login ou registre-se com outro email.",
    });
  }
  res.locals.user = user;

  next();
}

export async function validShemaSignIn(req, res, next) {
  const { error } = signInSchema.validate(req.body);
  if (error) return res.status(422).send(error.message);

  const user = req.body;

  const result = await connnectionDB.query(
    "SELECT * FROM users WHERE email = $1",
    [user.email]
  );

  if (result.rowCount === 0) {
    return res.status(409).send({
      message:
        "Email não cadastrado, por favor verifique o email ou cadastre-se.",
    });
  }
  res.locals.user = user;

  next();
}

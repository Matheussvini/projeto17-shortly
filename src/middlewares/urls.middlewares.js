import { shortLinkSchema } from "../models/urls.js";
import { nanoid } from "nanoid";
import { connnectionDB } from "../database/db.js";

export async function validShemaShortLink(req, res, next) {
  const { error } = shortLinkSchema.validate(req.body);
  if (error) return res.status(422).send(error.message);

  const { url } = req.body;
  const { id } = res.locals.user;
  const shortUrl = nanoid(10);

  res.locals.shorten = {
    url,
    shortUrl,
    user_id: id,
  };

  next();
}

export async function validShemaDelete(req, res, next) {
  const { user } = res.locals;
  const url_id = parseInt(req.params.id);

  const { rows } = await connnectionDB.query(
    `
    SELECT * FROM urls
    WHERE id = $1
  `,
    [url_id]
  );

  const data = rows[0];

  if (!data)
    return res.status(404).send({ message: "Não há nenhuma URL com esse ID!" });

  if (data.user_id !== user.id) {
    return res.status(401).send({
      message: `A url encurtada não pertence ao usuário: ${user.name}`,
    });
  }

  res.locals.url = data;

  next();
}

export async function validShortlink(req, res, next){

  const {shortUrl} = req.params;


  const {rows} = await connnectionDB.query(`
    SELECT * FROM urls
    WHERE "shortUrl" = $1
  
  `, [shortUrl]);
  const data = rows[0];
  if(!data) return res.status(404).send({ message: "Não há nenhuma URL com esse ID!" })

  res.locals.url = data;
  next();

}

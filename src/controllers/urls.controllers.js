import { connnectionDB } from "../database/db.js";

export async function createShortLink(req, res) {
  const { url, shortUrl, user_id } = res.locals.shorten;

  try {
    await connnectionDB.query(
      `
            INSERT INTO urls (url, "shortUrl", user_id )
            VALUES ($1, $2, $3)
        `,
      [url, shortUrl, user_id]
    );

    res.status(201).send({ shortUrl });
  } catch (err) {
    res.status(500).send(err.message);
  }
}

export async function deleteShortLink(req, res) {
  const { id } = res.locals.url;

  try {
    await connnectionDB.query(
      `
            DELETE FROM urls WHERE id = $1
        `,
      [id]
    );

    res.status(204).send("Url excluída com sucesso!");
  } catch (err) {
    res.status(500).send(err.message);
  }
}

export async function findById(req, res) {
  const id = parseInt(req.params.id);

  try {
    const { rows } = await connnectionDB.query(
      `
            SELECT id, url, "shortUrl"
            FROM urls
            WHERE id = $1
        `,
      [id]
    );
    const data = rows[0];

    if (!data)
      return res
        .status(404)
        .send({ message: "Não há nenhuma URL com esse ID!" });

    res.status(200).send({
      id: data.id,
      shortUrl: data.shortUrl,
      url: data.url,
    });
  } catch (err) {
    res.status(500).send(err.message);
  }
}

export async function openShortLink(req, res) {
  const { url } = res.locals;

  try {
    await connnectionDB.query(
      `
            UPDATE urls
            SET visits = $1
            WHERE id = $2
        `,
      [url.visits + 1, url.id]
    );

    return res.redirect(200, url.url);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

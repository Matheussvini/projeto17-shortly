import { connnectionDB } from "../database/db.js";

export async function findRanking(req, res) {
  try {
    const { rows } = await connnectionDB.query(`
        SELECT 
        users.id,
        users.name,
        COUNT(urls.id) AS "linksCount",
        COALESCE(SUM(urls.visits), 0) AS "visitCount"
        FROM users
        LEFT JOIN urls
        ON urls.user_id = users.id
        GROUP BY users.id
        ORDER BY "visitCount" DESC
        LIMIT 10                
        `);

    res.status(200).send(rows);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

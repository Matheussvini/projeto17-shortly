CREATE DATABASE shortlydb

\c shortlydb

INSERT INTO urls (url, "shortUrl", user_id)
VALUES ('http:/globo.com', 'hhhhh', 8);

INSERT INTO users (name, email, password)
VALUES ('caio', 'caio2@gmail.com', '123456');

SELECT * FROM urls;
SELECT * FROM users;

DROP TABLE urls;
DROP TABLE users;

CREATE TABLE users(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" varchar(60) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
);

CREATE TABLE urls(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"url" TEXT NOT NULL,
	"shortUrl" TEXT UNIQUE,
	"user_id" integer NOT NULL REFERENCES users(id),
	"visits" integer NOT NULL DEFAULT 0,
	"createdAt" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);


SELECT
	users.id,
	users.name,
	SUM(urls.visits) AS "visitCount"
FROM users
JOIN urls
ON users.id = urls.user_id
WHERE urls.user_id = 3
GROUP BY users.id;
			
			
SELECT
urls.id,
urls."shortUrl",
urls.url,
urls.visits AS "visitCount"
FROM urls
JOIN users
ON urls.user_id = users.id
WHERE urls.user_id = 1
GROUP BY urls.id
ORDER BY urls.id ASC;
			
		
SELECT * FROM users WHERE email = 'aaa@gmail.com';


UPDATE urls
SET visits = visits + 1
WHERE id = 2;

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
LIMIT 10;
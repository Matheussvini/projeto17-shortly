CREATE DATABASE shortlydb



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
	"visits" integer NOT NULL DEFAULT 0
);

INSERT INTO urls (url, "shortUrl", user_id, visits)
VALUES ('http:/globo.com', 'aaaa', 1, 5);

INSERT INTO users (name, email, password)
VALUES ('João', 'joçao@gmail.com', '12345');

SELECT * FROM urls;
SELECT * FROM users;

DROP TABLE urls CASCADE;

CREATE TABLE urls(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"url" TEXT NOT NULL,
	"shortUrl" TEXT UNIQUE,
	"user_id" integer NOT NULL REFERENCES users(id),
	"visits" integer NOT NULL DEFAULT 0
);

CREATE TABLE users(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" varchar(60) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
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
ORDER BY urls.id ASC
			
		
SELECT * FROM users WHERE email = 'aaa@gmail.com';


UPDATE urls
SET visits = visits + 1
WHERE id = 2;
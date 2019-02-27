USE albums_db;
SHOW tables;
DESCRIBE albums;
-- name all of all albums by Pink Floyd
SELECT * FROM albums WHERE artist='Pink Floyd';
-- year that Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name='Sgt. Pepper''s Lonely Hearts Club Band';
-- genre for album Nevermind
SELECT genre FROM albums WHERE name='Nevermind';
-- albums released in the 1990's
SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- albums that had less than 20 million in sales
SELECT * FROM albums WHERE sales<20;
-- all albums with a genre of "Rock" (only returns exact matches)
SELECT * FROM albums WHERE genre='Rock';
-- Use LIKE w/ % for non-exact search
SELECT * FROM albums WHERE genre LIKE '%Rock%';
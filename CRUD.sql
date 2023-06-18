-- System CRUD

-- admins CRUD 
-- ========================================================================================================================================================================================================================================================================================================================================================================================


-- CREATE
-- C.1
INSERT INTO admins (admin_name, admin_last_name,email, password)
VALUES ('Andres','Castro','guevaracastroandres@gmail.com','andres12345678'),
('Roberto','Gomez','roberto1234@gmail.com','roberto12345678'),
('maria','smith','maria1234@gmail.com','maria12345678');

-- READ
-- R1
SELECT email, password, admin_id
FROM admins
WHERE email ='guevaracastroandres@gmail.com' AND password = 'andres12345678';

-- R2 
SELECT admin_name FROM admins WHERE admin_id = 1;

-- UPDATE
-- U1
UPDATE admins
SET password = 'andres12345678'
WHERE email ='guevaracastroandres@gmail.com';

-- DELETE
-- D1
DELETE FROM admins 
WHERE email ='guevaracastroandres@gmail.com';





-- albums CRUD 
-- ===========================================================================================================================================================================================================================================

-- CREATE 
-- C1
INSERT INTO albums 
(
album_name, 
album_year, 
album_cover
)
VALUES
('Paradise Valley ',
'2013',
'https://en.wikipedia.org/wiki/File:Paradise_Valley_cover,_by_John_Mayer.jpg'
),
('Continuum',
'2006',
'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FJohn-Mayer%2Fdp%2FB0014VPFTA&psig=AOvVaw1Q9ukoTQH1eTMlyMYShDV4&ust=1647386539632000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLj32Z7fxvYCFQAAAAAdAAAAABAD'
),
('Sob Rock ',
'2021',
'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FJohn-Mayer%2Fdp%2FB0014VPFTA&psig=AOvVaw1Q9ukoTQH1eTMlyMYShDV4&ust=1647386539632000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLj32Z7fxvYCFQAAAAAdAAAAABAD'
);


-- READ
-- R1
SELECT album_name, album_cover, album_id FROM albums;

-- R2
SELECT album_name, album_id FROM albums;

-- UPDATE 
-- U1
UPDATE albums
SET 
album_name = 'update album name', 
album_year = '2000',
album_cover = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ABlank_square.svg&psig=AOvVaw36ECXsOOUvpdbgSeRJp170&ust=1648178451974000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKDvr6vl3fYCFQAAAAAdAAAAABAI'
WHERE album_id= 2;

-- DELETE
-- D1
DELETE FROM albums
WHERE album_id = 2;




-- streaming_services_ list  CRUD 
-- =========================================================================================================================================================================================================================================================================================================================================


-- CREATE 
-- C1
INSERT INTO streaming_services_list (streaming_service_name) 
VALUES ('Spotify'),
('Deezer'),
('Tidal'),
('Apple Music'),
('Amazon Music');

-- UPDATE 
-- U1
UPDATE streaming_services_list
SET streaming_service_name = 'Deezer'
WHERE streaming_id = 2;

-- READ 
-- R1
SELECT streaming_id, streaming_service_name
FROM streaming_services_list;

-- DELETE  
-- D1
DELETE FROM streaming_services_list
WHERE streaming_id =5;




-- genres CRUD  
-- =========================================================================================================================================================================================================================================================================================================================================


-- CREATE
-- C1
INSERT INTO genres(genre_name)
VALUES ('Pop'),
('rock'),
('jazz'),
('pop rock'),
('blues'),
('Opera'),
('punk'),
('folk'),
('country');

-- UPDATE
-- U1
UPDATE genres
SET genre_name = 'metal'
WHERE genre_id = '5';  

-- READ
-- R1
SELECT genre_id, genre_name
FROM genres;

-- DELETE
-- D1
DELETE FROM genres
WHERE genre_id = 5;



-- song_writers CRUD
-- ===========================================================================================================================================================================================================================================

-- CREATE 
-- C1
INSERT INTO song_writers (sw_name, sw_lastname)
VALUES ('Pino','Palladino'),
('John','Mayer'),
('Steve','jordan'),
('Charlie','Hunter');

-- READ
-- R1
SELECT writer_id, sw_name FROM song_writers;

-- R2
SELECT shsw.writer_id, sw.sw_name, sw.sw_lastname 
FROM songs_has_song_writers shsw
JOIN song_writers sw ON shsw.writer_id = sw.writer_id
WHERE shsw.song_id=1;

-- UPDATE 
-- R1
UPDATE song_writers
SET sw_name = 'andres', sw_lastname = 'castro'
WHERE writer_id = 3;

-- DELETE 
-- D1
DELETE FROM song_writers
WHERE writer_id =3;


-- songs CRUD 
-- ==========================================================================================================================================================================================================================================================================================


-- Create 
-- C1
 START TRANSACTION;

	-- Create song  
	-- c1
	INSERT INTO songs
	(song_title,
	song_length,
	single,
	album_id,
	genre_id)
	VALUES 
	('Who you love','00:04:09',0,1,1),
    ('Gravity','00:04:50',0,2,5);


	-- The program will set a variable for the new Id song created 
	SET @new_song_id = 1;

	-- If colaboration is true
	-- Colaborations C1
	INSERT INTO colaborations (invited_artist_name, invited_artist_last_name, song_id) 
	VALUES('Katy','Perry', @new_song_id);
	 
	 -- Asociate song with writers 
	 -- C1
	INSERT INTO  songs_has_song_writers (song_id,writer_id)
	VALUES(@new_song_id, 
	-- We look for the writer ID 
	(SELECT writer_id FROM song_writers WHERE writer_id =2)
	);
	 
	-- add streaming services 
	-- C1
	INSERT song_has_streaming_services (song_id, streaming_id, steaming_url)
	VALUES (
	@new_song_id, 
	-- We look for the streming service ID 
	(SELECT streaming_id FROM streaming_services_list WHERE streaming_id = 1),
	'https://open.spotify.com/track/7IByJvSqRFltGyiiIiL4wn?si=610130e5eb48467a'
	);

	-- Read Associated services R1
	-- R1
	SELECT sl.streaming_service_name, sss.song_id
	FROM song_has_streaming_services sss
	JOIN streaming_services_list sl
	ON sl.streaming_id = sss.streaming_id;

	-- add Music Video 
	-- C1
	INSERT INTO music_videos (song_id, youtube_url, length)
	VALUES(@new_song_id,
	 'https://youtu.be/nSRCpertZn8',
	 '00:04:11'
	 );
	 
 -- sum time of all the songs to determing album lenght 
	 UPDATE albums
	 SET album_length = SEC_TO_TIME ((SELECT sum(song_length) FROM songs WHERE album_id = 1))  
	 WHERE album_id =1;
     
	 
 -- count the total of songs added into an album
	 UPDATE albums
	 SET album_number_of_songs = (SELECT count(song_id) FROM songs where album_id = 1)
	 WHERE album_id =1;
 
ROLLBACK;
COMMIT; 



-- READ 
-- R1
SELECT song_id, song_title song_lenght FROM songs;

-- R2
SELECT song_id, song_title FROM songs WHERE album_id =2;




-- UPDATE
-- U1

UPDATE songs
SET 
song_title ="vultures",
song_length ="00:04:10",
single =0,
album_id ="2",
genre_id ="1"
WHERE song_id = 4;

-- U2
-- If colaboration is true
UPDATE colaborations 
SET 
invited_artist_name ="katy updated ",
invited_artist_last_name ="Perry updated"
WHERE song_id =1;

-- U3
-- wirters of the song
UPDATE songs_has_song_writers
SET writer_id =4
WHERE song_id =4;
 
-- U4
-- update streaming services 
UPDATE song_has_streaming_services
SET streaming_id =2,
steaming_url ='https://deezer.page.link/fiVyptRuwWoX58Hf7'
Where song_id =1; 

-- U5
-- edit music video 
UPDATE  music_videos
SET youtube_url ="https://www.youtube.com/watch?v=2LVWF3_RSGo"
WHERE song_id =1;


-- DELETE 
-- D1
 START TRANSACTION;
 
DELETE FROM songs
WHERE song_id =1;

DELETE FROM colaborations
WHERE song_id =1;

DELETE FROM songs_has_song_writers
WHERE song_id =1;

DELETE FROM song_has_streaming_services
WHERE song_id =1;

DELETE FROM music_videos
WHERE song_id =1;

ROLLBACK;
COMMIT; 








-- awards CRUD 
-- ============================================================================================================================================================================================

-- CREATE
-- C1
 INSERT INTO awards (award_name,award_year,song_id,album_id)
 VALUES ('Best Male Rock Performance','2009',2,null),
 ('Best Pop Vocal Album','2007',null,2);
 
 -- READ 
 -- R1 
 SELECT award_id, award_name, award_year FROM awards;
 
-- UPDATE 
-- U1
UPDATE awards
SET award_name = 'new album name',
award_year ='1999', 
song_id = '4',
album_id = '2'
WHERE award_id ='1';

-- DELETE 
-- D1
DELETE FROM awards
WHERE award_id ='1';


 
 


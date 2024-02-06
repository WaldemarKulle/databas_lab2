PRAGMA foreign_keys=OFF;
DROP TABLE IF EXISTS theaters;
DROP TABLE IF EXISTS performances;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
PRAGMA foreign_keys=ON;


CREATE TABLE theaters (
    theater_name TEXT PRIMARY KEY,
    capacity INT 
);

CREATE TABLE movies (
    IMDB_key TEXT PRIMARY KEY,
    running_time INT,
    title TEXT,
    production_year INT
);

CREATE TABLE customers (
    username TEXT PRIMARY KEY,
    full_name TEXT,
    user_password TEXT
);


CREATE TABLE performances (
    performance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    performance_date DATE,
    start_time TIME,
    IMDB_KEY TEXT,
    theater_name TEXT,

    FOREIGN KEY (IMDB_key) REFERENCES movies(IMDB_key),
    FOREIGN KEY (theater_name) REFERENCES theaters(theater_name)
);


CREATE TABLE tickets (
    ticket_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    performance_id TEXT,
    username TEXT,
    
    FOREIGN KEY (performance_id) REFERENCES performances(performance_id),
    FOREIGN KEY (username) REFERENCES customers(username)
);


CREATE TRIGGER ticket_check
    BEFORE INSERT ON tickets
BEGIN
    SELECT
        CASE
            WHEN (SELECT count() FROM tickets WHERE tickets.performance_id = NEW.performance_id) = 
            (SELECT capacity FROM theaters WHERE theaters.theater_name = 
            (SELECT theater_name FROM performances WHERE performances.performance_id = NEW.performance_id))
            THEN RAISE (ABORT, 'Sold out')
        END;
END;


INSERT INTO theaters (theater_name, capacity)
VALUES 
    ('Spegeln',100),
    ('Filmstaden',200),
    ('SF Bio',300),
    ('Kino', 50);


INSERT INTO movies (IMDB_key,running_time,title,production_year)
VALUES
    ('tt0280707','137','Gosford Park',2001),
    ('tt0232500','106','The Fast and the Furious',2001),
    ('tt1013752','107','Fast & Furious',2009),
    ('tt5433138','143','F9: The Fast Saga',2021);


INSERT INTO performances (performance_date,start_time,IMDB_key,theater_name)
VALUES
    ('2023-02-01','19:00','tt0280707','Spegeln'), 
    ('2023-02-02','19:30','tt0280707','Spegeln'),
    ('2023-02-03','20:00','tt0280707','Spegeln'),
    ('2023-02-04','20:30','tt0280707','Spegeln'),
    ('2023-02-01','22:00','tt0280707','Spegeln'), 
    ('2023-02-02','22:30','tt0280707','Spegeln'),
    ('2023-02-03','22:00','tt0280707','Spegeln'),
    ('2023-02-04','22:30','tt0280707','Spegeln'),
    ('2023-02-01','19:00','tt0232500','Filmstaden'),
    ('2023-02-01','19:30','tt0232500','Filmstaden'),
    ('2023-02-06','20:00','tt0232500','Filmstaden'),
    ('2023-02-06','20:30','tt0232500','Filmstaden'),
    ('2023-02-03','19:00','tt1013752','SF Bio'),
    ('2023-02-03','19:30','tt1013752','SF Bio'),
    ('2023-02-03','20:00','tt1013752','SF Bio'),
    ('2023-02-03','20:30','tt1013752','SF Bio'),
    ('2024-09-08', '20:00', 'tt5433138', 'Kino'),
    ('2024-10-08', '20:00', 'tt5433138', 'Kino'),
    ('2024-11-08', '20:00', 'tt5433138', 'Kino'),
    ('2024-12-08', '20:00', 'tt5433138', 'Kino');

INSERT INTO customers (username,full_name,user_password)
VALUES
    ("thelegend27","asdf qwertyson","password"),
    ("Mushta","maurits magnusson","h4ck3r"),
    ("Oli","Oliver Ocaranza","1337"),
    ("WalE","Waldemar Kulle","blablabla");

INSERT INTO tickets (performance_id,username)
VALUES
    (1,"thelegend27"),
    (2,"Oli"),
    (3,"Mushta"),
    (4,"Oli"),
    (5,"Mushta"),
    (6,"thelegend27");
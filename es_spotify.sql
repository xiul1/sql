-- Active: 1764925115289@@127.0.0.1@3306@Spotify
-- ========================================
-- DATABASE SPOTIFY - musica.sql
-- ========================================

-- Creazione Database
CREATE DATABASE IF NOT EXISTS Spotify;
USE Spotify;

-- ========================================
-- CREAZIONE TABELLE
-- ========================================

-- Tabella UTENTI
CREATE TABLE Utenti (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL
);

-- Tabella PLAYLIST
CREATE TABLE Playlist (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    IDUtenti INT,
    FOREIGN KEY (IDUtenti) REFERENCES Utenti(ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabella CANZONI
CREATE TABLE Canzoni (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(150) NOT NULL,
    durata INT NOT NULL CHECK (durata > 0),
    genere VARCHAR(50) NOT NULL,
    data_uscita DATE NOT NULL,
    num_ascolti BIGINT DEFAULT 0 CHECK (num_ascolti >= 0)
);

-- Tabella APPARTENERE (relazione N:M)
CREATE TABLE appartenere (
    IDCanzoni INT NOT NULL,
    IDPlaylist INT NOT NULL,
    PRIMARY KEY (IDCanzoni, IDPlaylist),
    FOREIGN KEY (IDCanzoni) REFERENCES Canzoni(ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IDPlaylist) REFERENCES Playlist(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ========================================
-- INSERIMENTO DATI
-- ========================================

-- Inserimento UTENTI
INSERT INTO Utenti (nome, cognome) VALUES
('Marco', 'Rossi'),
('Mara', 'Sattei'),
('Giulia', 'Bianchi'),
('Luca', 'Verdi'),
('Sofia', 'Neri'),
('Alessandro', 'Ferrari'),
('Francesca', 'Colombo'),
('Matteo', 'Ricci'),
('Chiara', 'Marino'),
('Andrea', 'Romano'),
('Valentina', 'Greco'),
('Davide', 'Bruno'),
('Elena', 'Gallo'),
('Simone', 'Costa'),
('Martina', 'Fontana');

-- Inserimento PLAYLIST
INSERT INTO Playlist (nome, IDUtenti) VALUES
('Mattia04', 1),
('Top Hits 2025', 2),
('Chill Vibes', 3),
('Workout Mix', 4),
('Italian Pop', 5),
('Rock Classics', 6),
('Party Time', 7),
('Relax & Study', 8),
('Road Trip', 9),
('Summer Hits', 10),
('Indie Selection', 11),
('Rap Italiano', 12),
('Dance Floor', 13),
('Acoustic Sessions', NULL),
('Retro Vibes', NULL);

-- Inserimento CANZONI
INSERT INTO Canzoni (titolo, durata, genere, data_uscita, num_ascolti) VALUES
('Sorriso grande', 195, 'Pop', '2024-03-15', 8500000),
('Melodrama', 210, 'Pop', '2024-06-20', 6200000),
('Tuta Gold', 180, 'Rap', '2023-11-10', 12000000),
('I P\' Me Tu P\' Te', 205, 'Rap', '2024-02-14', 9500000),
('Sinceramente', 198, 'Pop', '2024-05-08', 7800000),
('Click Boom', 188, 'Pop', '2024-04-22', 5600000),
('Paradiso', 220, 'Pop', '2023-09-30', 4200000),
('Black Nirvana', 203, 'RnB', '2024-01-18', 3900000),
('Vento', 175, 'Pop', '2024-07-05', 4800000),
('Dancing in the Flames', 240, 'RnB', '2022-12-20', 11000000),
('Houdini', 185, 'Dance', '2024-08-12', 6700000),
('What Was I Made For', 210, 'Pop', '2023-07-21', 15000000),
('Vampire Redux', 195, 'Rock', '2022-06-30', 8900000),
('Cruel Summer 2025', 178, 'Pop', '2024-09-15', 5300000),
('Why Why Why', 192, 'Pop', '2024-10-01', 2800000);

-- Inserimento APPARTENERE
INSERT INTO appartenere (IDCanzoni, IDPlaylist) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(1, 2), (2, 2), (5, 2), (6, 2),
(7, 3), (8, 3), (9, 3),
(3, 4), (4, 4), (11, 4),
(1, 5), (5, 5), (6, 5), (9, 5),
(13, 6),
(10, 7), (11, 7), (12, 7), (14, 7),
(7, 8), (8, 8),
(3, 12), (4, 12),
(11, 13),
(12, 10);


SELECT MAX(c.num_ascolti) as MaxAscolti,MIN(c.num_ascolti) as MinAscolti,AVG(c.num_ascolti) as MediaAscolti
FROM Canzoni c;

SELECT COUNT(*) as NumCanzoniPop
FROM Canzoni c
WHERE c.genere LIKE "pop"
AND c.durata >= 180;

SELECT c.titolo,c.durata,c.num_ascolti,c.data_uscita
FROM Canzoni c
WHERE c.data_uscita>= '2022-01-01'


SELECT c.titolo as "mattia04"
FROM Canzoni c, Playlist p, appartenere a
WHERE p.ID=a.IDPlaylist
and c.ID=a.IDCanzoni
and p.nome like :n2;


SELECT c.titolo as "mara Sattei"
FROM Canzoni c, Playlist p, appartenere a, Utenti u
WHERE p.ID=a.IDPlaylist
and c.ID=a.IDCanzoni
and u.nome like :nome
AND u.cognome LIKE :cognome;

SELECT c.titolo,c.data_uscita
from Canzoni c
ORDER BY c.data_uscita DESC,c.titolo;


update Canzoni
set data_uscita=(
    select c.data_uscita
FROM Canzoni c
WHERE c.titolo like "Vampire Redux"
LIMIT 1)
WHERE titolo="Cruel Summer 2025"

SELECT u.nome, u.cognome
FROM Utenti u,Playlist p,Canzoni c, appartenere a
WHERE p.ID=a.IDPlaylist
and c.id=a.IDCanzoni
and u.id=p.IDUtenti
and c.titolo="Sorriso grande";

SELECT u.nome,u.cognome
FROM Utenti u 
LEFT JOIN Playlist p ON u.ID =p.IDUtenti
where p.IDUtenti is NULL;



SELECT c.titolo
FROM  `Canzoni` c
LEFT JOIN appartenere a ON c.`ID`=a.`IDCanzoni`
where a.`IDCanzoni` is NULL;

SELECT p.nome
FROM  `Playlist` p
LEFT JOIN appartenere a ON p.`ID`=a.`IDPlaylist`
where a.`IDPlaylist` is NULL;

--visualizza per ogni genere il numero di canzoni
SELECT c.genere,COUNT(*) as "numero canzoni"
FROM  `Canzoni` c
GROUP BY c.genere

SELECT p.nome, COUNT(*) as "numero canzoni"
FROM  `Playlist` p, canzoni c, appartenere a
WHERE c.`ID`=a.`IDCanzoni`
and p.`ID`=a.`IDPlaylist`
GROUP BY p.`ID`
HAVING COUNT(*)>3;


update `Playlist`
set nome="Mattia04"
WHERE id=5;

SELECT p.nome, COUNT(*) as "numero canzoni",SUM(c.num_ascolti) as "nascolti"
FROM  `Playlist` p, canzoni c, appartenere a
WHERE c.`ID`=a.`IDCanzoni`
and p.`ID`=a.`IDPlaylist`
GROUP BY p.`ID`
HAVING COUNT(*)>3
and  nascolti>4500000;













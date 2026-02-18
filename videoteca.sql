-- Active: 1770925034703@@127.0.0.1@3306@Videoteca
-- --------------------------------------------------------

--
-- Creazione DB Videoteca
--
CREATE DATABASE IF NOT EXISTS Videoteca
character set UTF8 collate utf8_bin;

USE Videoteca;

-- --------------------------------------------------------

--
-- Struttura della tabella `Attore`
--

CREATE TABLE `Attore` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Nome` varchar(255) DEFAULT NULL,
  `Cognome` varchar(255) DEFAULT NULL,
  `IDNazione` int(11)
);

--
-- Dump dei dati per la tabella `Attore`
--

INSERT INTO `Attore` (`ID`, `Nome`, `Cognome`, `IDNazione`) VALUES
(1, 'uma', 'thurman', 1),
(2, 'john', 'travolta', 1),
(3, 'brad', 'pitt', 1),
(4, 'johnny', 'depp', 1),
(5, 'penelope', 'cruz', 2),
(6, 'clint', 'eastwood', 1),
(7, 'leonardo', 'di caprio', 1),
(8, 'sean', 'penn', 1),
(9, 'yorge', 'hirsch', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `Film`
--

CREATE TABLE `Film` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Titolo` varchar(255) DEFAULT NULL,
  `Anno` int(11) DEFAULT '0',
  `Durata` int(11) DEFAULT '0',
  `Costo` decimal(19,4) DEFAULT '0.0000',
  `IDRegista` int(11) DEFAULT '0',
  `IDGenere` int(11) DEFAULT '0'
);

--
-- Dump dei dati per la tabella `Film`
--

INSERT INTO `Film` (`ID`, `Titolo`, `Anno`, `Durata`, `Costo`, `IDRegista`, `IDGenere`) VALUES
(2, 'kill bill 1', 2003, 115, '800000.0000', 1, 1),
(3, 'kill bill 2', 2004, 120, '900000.0000', 1, 1),
(4, 'pulp fiction', 1994, 100, '750000.0000', 1, 1),
(5, 'bastardi senza gloria', 2009, 160, '800000.0000', 1, 1),
(6, 'edward mani di forbice', 1990, 100, '500000.0000', 2, 2),
(7, 'pirati dei caraibi:oltre i confini del mare', 2011, 137, '1000000.0000', 3, 1),
(8, 'million dollar baby', 2004, 120, '800000.0000', 4, 2),
(9, 'inception', 2010, 142, '900000.0000', 5, 1),
(10, 'this must be the place', 2011, 118, '750000.0000', 6, 2),
(11, 'into the wild', 2007, 148, '600000.0000', 7, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `Genere`
--

CREATE TABLE `Genere` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Descrizione` varchar(255) DEFAULT NULL
);

--
-- Dump dei dati per la tabella `Genere`
--

INSERT INTO `Genere` (`ID`, `Descrizione`) VALUES
(1, 'azione'),
(2, 'drammatico'),
(3, 'avventura');

-- --------------------------------------------------------

--
-- Struttura della tabella `Interpreta`
--

CREATE TABLE `Interpreta` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `IDFilm` int(11) DEFAULT '0',
  `IDAttore` int(11) DEFAULT '0'
);
--
-- Dump dei dati per la tabella `Interpreta`
--

INSERT INTO `Interpreta` (`ID`, `IDFilm`, `IDAttore`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 2),
(4, 4, 1),
(5, 5, 3),
(6, 6, 4),
(7, 7, 4),
(8, 7, 5),
(9, 8, 6),
(10, 9, 7),
(11, 10, 8),
(12, 11, 9);

-- --------------------------------------------------------

--
-- Struttura della tabella `Nazione`
--

CREATE TABLE `Nazione` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Nome` varchar(255) DEFAULT NULL
);

--
-- Dump dei dati per la tabella `Nazione`
--

INSERT INTO `Nazione` (`ID`, `Nome`) VALUES
(1, 'stati uniti'),
(2, 'spagna'),
(3, 'italia'),
(4, 'danimarca');

-- --------------------------------------------------------

--
-- Struttura della tabella `Regista`
--

CREATE TABLE `Regista` (
  `ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Nome` varchar(255) DEFAULT NULL,
  `Cognome` varchar(255) DEFAULT NULL
);

--
-- Dump dei dati per la tabella `Regista`
--

INSERT INTO `Regista` (`ID`, `Nome`, `Cognome`) VALUES
(1, 'quentin', 'tarantino'),
(2, 'tim', 'burton'),
(3, 'rob', 'marshall'),
(4, 'clint', 'eastwood'),
(5, 'cristopher', 'nolan'),
(6, 'paolo', 'sorrentino'),
(7, 'sean', 'penn');

--
-- Indici per le tabelle scaricate
--
--1) Quali sono i film appartenenti al genere "azione"?
SELECT F.Titolo
FROM Film F, Genere G
WHERE F.IDGenere = G.ID AND G.Descrizione = 'azione';

--2) Visualizzare tutti i film realizzati dopo il 2009
SELECT Titolo
FROM Film
WHERE Anno > 2009;

--3) elencare tutti i film costati più di 600000 euro
SELECT Titolo,`Costo`
FROM Film
WHERE Costo > 600000;

--4) elencare tutti i film che iniziano con la lettera L
SELECT Titolo
FROM Film
WHERE Titolo LIKE 'l%';

--5) visualizzare tutti gli attori in ordine alfabetico
SELECT Nome, Cognome
FROM Attore
ORDER BY Cognome;

--6) visualizzare tutte le nazioni di provenienza degli attori.Ciascuna nazione deve essere visualizzata una sola volta
SELECT DISTINCT N.Nome
FROM Nazione N, Attore A
WHERE A.IDNazione = N.ID;

--7) quali sono gli attori spagnoli?
SELECT A.Nome, A.Cognome, N.Nome
FROM Attore A, Nazione N
WHERE A.IDNazione = N.ID 
AND N.Nome = 'spagna';

--8)quali sono i film interpretati da particolare attore?
SELECT F.Titolo
FROM Film F, Interpreta I, Attore A
WHERE F.ID = I.IDFilm 
AND I.IDAttore = A.ID 
AND A.Nome = :Nome 
AND A.Cognome = :Cognome;

--9)quati sono i film proddotti da un registra
SELECT COUNT(*)
FROM Film F, Regista R
WHERE F.IDRegista = R.ID
AND R.Nome = :Nome
AND R.Cognome = :Cognome;

--10)quanti sono i film presenti nel DB?
SELECT COUNT(ID) AS "numerifilm"
FROM Film;

--11) durata media dei film di ogni attore
SELECT A.Nome, A.Cognome, AVG(F.Durata) AS "duratamedia"
FROM Attore A, Interpreta I, Film F
WHERE A.ID = I.IDAttore
AND I.IDFilm = F.ID
GROUP BY A.ID;

--12)Per ogni genere cinematografico calcola il numero di film, la durata media e il costo totale. Mostra solo i generi con almeno 2 film.
SELECT G.Descrizione, COUNT(F.ID) AS "numfilm", AVG(F.Durata) AS "duratamedia", SUM(F.Costo) AS "costototale"
FROM Genere G, Film F
WHERE G.ID = F.IDGenere
GROUP BY G.ID
HAVING COUNT(F.ID) >= 2;

INSERT INTO `Regista` (`ID`, `Nome`, `Cognome`) VALUES
(8, 'Guidotti', 'francisco');
--13)Visualizza nome e cognome di tutti i registi con i titoli dei film da loro diretti. I registi senza film nel database devono comparirecomunque (titolo NULL).
SELECT `R`.`Nome`,R.`Cognome`,F.Titolo
FROM `Regista` R LEFT JOIN `Film` F ON F.IDRegista = R.ID;

--14)Per ogni film mostra titolo, anno, nome/cognome del regista e nome/cognome di ogni attore. Ordina per anno decrescente.
SELECT f.`Titolo`,f.`Anno`,r.`Nome`,r.`Cognome`,a.`Nome`,a.`Cognome`
FROM `Film` f, `Regista` r, `Interpreta` i, `Attore` a
WHERE f.IDRegista = r.ID
AND f.ID = i.IDFilm
AND i.IDAttore = a.ID
ORDER BY f.Anno DESC;

--15)Elenca il titolo e la durata dei film la cui durata è superiore alla durata media calcolata su tutti i film del database.
SELECT f.`Titolo`,ROUND(f.`Durata`)
FROM `Film` f
WHERE f.`Durata`>(SELECT AVG(Durata) FROM `Film`);


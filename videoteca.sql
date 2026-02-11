-- Active: 1769426276789@@127.0.0.1@3306@Videoteca
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
--1)
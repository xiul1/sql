-- Active: 1764925115289@@127.0.0.1@3306@PazientiMedici
create DATABASE IF NOT EXISTS PazientiMedici;

USE PazientiMedici;

CREATE TABLE IF NOT exists specialita (
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    Descizione VARCHAR(255) NOT NULL

);

CREATE TABLE IF NOT exists Medico (
    ID INT(5)  PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Cognome VARCHAR(255) NOT NULL,
    IDSpecialita INT(5) NOT NULL,
    Foreign Key (IDspecialita) REFERENCES specialita(ID)
    on update CASCADE
    on delete CASCADE

);

CREATE TABLE IF NOT exists Pazienti (
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Cognome VARCHAR(255) NOT NULL,
    nusi INT(5) NOT NULL
);

CREATE TABLE IF NOT exists Visitare(
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    datavisita DATE NOT NULL,
    Ora  TIME NOT NULL,
    Diagnosi VARCHAR(255),
    IDMedico INT(5) NOT NULL, 
    Foreign Key (IDMedico) REFERENCES Medico(ID)
    on update CASCADE
    on delete CASCADE,

    IDPazienti INT(5) NOT NULL,
    Foreign Key (IDPazienti) REFERENCES Pazienti(ID)
    on update CASCADE
    on delete CASCADE

);
SELECT * FROM specialita;
INSERT INTO specialita (Descizione) VALUES
("Gincologia"),
("Otorinolaringoiatria"),
("Cardiologia");

SELECT * FROM Medico;

INSERT into Medico (Nome,Cognome,IDSpecialita) VALUES
("Rosario","Fiorello",3),
("Manuela","Aureli",1),
("Francesco","Zalone",1),
("Maurizio","Crozza",2);

SELECT * FROM Pazienti;
INSERT into Pazienti (Nome,Cognome,nusi) VALUES
("Orietta","Berti",12),
("Alberto","Camerini",12),
("Loredana","Bertè",8),
("Donatella","Rettore",8);

SELECT * FROM Visitare;
INSERT INTO Visitare (datavisita,Ora,Diagnosi,IDMedico,IDPazienti)VALUES
("2023-01-15","10:00","",1,3),
("2023-01-15","11:00","",1,2),
("2023-02-10","9:00","",2,3),
("2023-03-10","10:00","",4,1);

ALTER TABLE Pazienti
ADD sesso VARCHAR(255);
DESCRIBE Pazienti;

ALTER TABLE Pazienti
MODIFY sesso CHAR(1);
 

-- TASK 5: Inserire valori per il campo sesso
UPDATE Pazienti SET sesso='F' WHERE Nome='Orietta' AND Cognome='Berti';
UPDATE Pazienti SET sesso='M' WHERE Nome='Alberto' AND Cognome='Camerini';
UPDATE Pazienti SET sesso='F' WHERE Nome='Loredana' AND Cognome='Bertè';
UPDATE Pazienti SET sesso='F' WHERE Nome='Donatella' AND Cognome='Rettore';

-- TASK 6: Modificare il nome del medico con ID=3 in 'Checco'
UPDATE Medico
SET Nome='Checco'
WHERE ID=3;

-- TASK 7: Cancellare la paziente Loredana Bertè
DELETE FROM Pazienti
WHERE Nome='Loredana' AND Cognome='Bertè';

-- TASK 8: Creare un indice sulla data della tabella Visitare
CREATE INDEX idx_data_visita ON Visitare(datavisita);

-- TASK 9: Aggiungere un vincolo CHECK su nusi
ALTER TABLE Pazienti
ADD CONSTRAINT chk_nusi CHECK (nusi > 0);

-- TASK 10: Impostare default 'Da definire' su Diagnosi
ALTER TABLE Visitare
MODIFY Diagnosi VARCHAR(255) DEFAULT 'Da definire';

-- TASK 11: Inserire nuova visita per tutti i pazienti con nusi=12
INSERT INTO Visitare (datavisita, Ora, Diagnosi, IDMedico, IDPazienti)
SELECT '2023-06-15', '14:00:00', 'Controllo periodico', 2, ID
FROM Pazienti
WHERE nusi = 12;

-- TASK 12: Aggiornare diagnosi vuote
UPDATE Visitare
SET Diagnosi='Visita completata - diagnosi in elaborazione'
WHERE Diagnosi='' OR Diagnosi IS NULL;

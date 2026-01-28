-- Active: 1764925115289@@127.0.0.1@3306@OperiPittori
create DATABASE IF NOT EXISTS OperiPittori;

USE OperiPittori;

CREATE TABLE if NOT exists pittore  (
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cognome VARCHAR(255) NOT NULL,
    datanascita DATE NOT NULL,
    sesso CHAR(1) ,
    datamorte DATE
);
CREATE TABLE if NOT exists opere  (
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    IDPittore INT(5) NOT NULL,
    Foreign Key (IDPittore) REFERENCES pittore(ID)
    on update CASCADE
    on delete CASCADE,
    titolo VARCHAR(255) NOT NULL,
    tecnica VARCHAR(255) NOT NULL,
    anno DATE NOT NULL,
    prezzo float(5) check (prezzo>0)

);
INSERT INTO pittore (nome,cognome,datanascita,sesso,datamorte)VALUES
("Claude","Monet","1840-03-26","M","1926-03-26"),
("Eduard","Manet","1832-03-26","M","1933-03-26"),
("Pierre Auguste","Renoir","1841-03-26","M","1919-03-26"),
("Paul","Cezanne,","1839-03-26","M",NULL);

 SELECT * FROM pittore;

 INSERT INTO opere (titolo,tecnica,anno,prezzo,IDPittore)VALUES
("Le ninfee","olio su tela","1897-03-26",10000,1),
("Il ponte giapponese","olio su tela","1918-03-26",1000,1),
("Il bevitore di assenzio","acquerello","1859-03-26",500,1),
("Olimpia","olio su tela","1859-03-26",10000,1),
("Colazione sull’erba","acquerello","1862-03-26",5000,2);

 SELECT * FROM opere;

 ALTER TABLE pittore
  ADD Nazionalita VARCHAR(255);

UPDATE pittore SET Nazionalita="Francese";

ALTER Table pittore
DROP COLUMN sesso;

UPDATE opere SET prezzo = prezzo * 1.1;
UPDATE opere SET prezzo = prezzo * 1.2
WHERE tecnica="acquarello";

DELETE FROM opere WHERE anno LIKE "1918%";

INSERT INTO pittore (nome, cognome, datanascita, datamorte, Nazionalita) VALUES
("Camille","Pissaro","1830-03-23","1903-03-26","Italiana");

INSERT INTO opere (titolo, tecnica, anno, prezzo, IDPittore) VALUES
("Strada verso versaillses","olio su tela","1869-03-28",10000,5);

DELETE FROM opere 
WHERE anno LIKE '1918%';



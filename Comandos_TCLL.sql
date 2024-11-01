CREATE DATABASE bd_exportar_1e;

USE bd_exportar_1e;

CREATE TABLE departamento (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    localizacao VARCHAR(50) NOT NULL,
    orcamento DECIMAL(10, 2) NOT NULL
);

INSERT INTO departamento (nome, localizacao, orcamento) 
    VALUES ("NASA", "New York", 90000.00), 
           ("TI", "São Paulo", 90000.00),
           ("Farmácia", "Orlando", 90000.00), 
           ("Museu", "Paris", 90000.00), 
           ("Teatro", "Berlim", 90000.00);

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM departamento
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

DROP TABLE departamento;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
INTO TABLE departamento
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';



start transaction;

update departamento set orcamento = orcamento + 1000.00 where nome = 'TI';

update departamento set orcamento = orcamento + 1000.00 where nome = 'NASA';

rollback;
--------------------------------------------------------------------------------------
start transaction;

update departamento set orcamento = orcamento + 7000.00 where nome = 'Museu';

savepoint ajuste_parcial;

update departamento set orcamento = orcamento + 2000.00 where nome = 'Teatro';

rollback to ajuste_parcial;
-- https://stackoverflow.com/questions/18286532/select-if-exist-else-insert
-- https://www.tutorialspoint.com/mysql/mysql_return_statement.htm#:~:text=The%20RETURN%20statement%20in%20MySQL,use%20LEAVE%20instead%20of%20RETURN.

CREATE DATABASE projetoIndividual;

USE projetoIndividual;

CREATE TABLE grupos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    dataDebut DATE NOT NULL,
    empresa VARCHAR(45) NOT NULL
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    dtNasc DATE NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkGrupoFav INT NOT NULL,
    FOREIGN KEY (fkGrupoFav) REFERENCES grupos (id)
);

INSERT INTO grupos (nome, dataDebut, empresa) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS');
    
    
DELIMITER $
CREATE PROCEDURE select_or_insert()
BEGIN
SET registroEnd = (SELECT * FROM endereco WHERE ocep = cep
								    AND orua = rua
                                    AND obairro = bairro
                                    AND ocidade = cidade
                                    AND oestado = estado
                                    AND onum = num);
                                    
IF (ISNULL(registroEnd)) THEN
	INSERT INTO endereco (cep, rua, bairro, cidade, estado, num) VALUES
		(ocep, orua, obairro, ocidade, oestado, onum);
	RETURN LAST_INSERT_ID();
ELSE
	RETURN registroEnd;
END IF;
END $
DELIMITER ;





/*
CREATE DATABASE projetoIndividual;

USE projetoIndividual;

create table teste (
	id int primary key auto_increment,
    teste int
);

CREATE TABLE endereco (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cep VARCHAR(8) NOT NULL,
    rua VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado CHAR(2) NOT NULL,
    num INT NOT NULL
);

CREATE TABLE grupos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    dataDebut DATE NOT NULL,
    empresa VARCHAR(45) NOT NULL
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    dtNasc DATE NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkGrupoFav INT NOT NULL,
    FOREIGN KEY (fkGrupoFav) REFERENCES grupos (id)
);

INSERT INTO grupos (nome, dataDebut, empresa) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS');
    
DELIMITER $
CREATE FUNCTION select_or_insert(dcep VARCHAR(8), drua VARCHAR(45), dbairro VARCHAR(45), dcidade VARCHAR(45), destado CHAR(2), dnum INT)
RETURNS INT
DETERMINISTIC
BEGIN
SET @registroEnd = (SELECT id FROM endereco WHERE cep = dcep
								    AND rua = drua
                                    AND bairro = dbairro
                                    AND cidade = dcidade
                                    AND estado = destado
                                    AND num = dnum);
                                    
IF (ISNULL(registroEnd)) THEN
	INSERT INTO endereco (cep, rua, bairro, cidade, estado, num) VALUES
		(dcep, drua, dbairro, dcidade, destado, dnum);
	RETURN @teste = (SELECT LAST_INSERT_ID());
ELSE
	RETURN @registroEnd;
END IF;
END $
DELIMITER ;

drop function select_or_insert;

/*
esse if n ta funcionando, n sei como usar
IF (ISNULL(SELECT id FROM endereco WHERE cep = '09570410'
								    AND rua = 'Rua Serafim Carlos'
                                    AND bairro = 'Osvaldo Cruz'
                                    AND cidade = 'São Caetano do Sul'
                                    AND estado = 'SP'
                                    AND num = 43;)) THEN
	INSERT INTO teste (teste) VALUES
		(1);
END IF;

SELECT id FROM endereco WHERE cep = '09570410'
								    AND rua = 'Rua Serafim Carlos'
                                    AND bairro = 'Osvaldo Cruz'
                                    AND cidade = 'São Caetano do Sul'
                                    AND estado = 'SP'
                                    AND num = 43;
*/

-- função tb n ta funcionando. erro: Unknown column 'registroEnd' in 'field list'
SELECT select_or_insert('09570410', 'Rua Serafim Carlos', 'Osvaldo Cruz', 'São Caetano do Sul', 'SP', 43) as idInserido;

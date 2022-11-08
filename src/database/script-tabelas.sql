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
CREATE DATABASE projetoIndividual;

USE projetoIndividual;

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
    FOREIGN KEY (fkGrupoFav) REFERENCES grupos (id),
    fkEndereco INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco (id)
);

INSERT INTO grupos (nome, dataDebut, empresa) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS');

DELIMITER $
CREATE FUNCTION select_or_insert(cepVar VARCHAR(8), ruaVar VARCHAR(45), bairroVar VARCHAR(45), cidadeVar VARCHAR(45), estadoVar CHAR(2), numVar INT)
RETURNS INT
DETERMINISTIC
BEGIN
/*SET @registroEnd := (SELECT id FROM endereco WHERE cep = dcep
								    AND rua = drua
                                    AND bairro = dbairro
                                    AND cidade = dcidade
                                    AND estado = destado
                                    AND num = dnum);
*/
IF (ISNULL((SELECT id FROM endereco WHERE cep = cepVar
								    AND rua = ruaVar
                                    AND bairro = bairroVar
                                    AND cidade = cidadeVar
                                    AND estado = estadoVar
                                    AND num = numVar))) THEN
	INSERT INTO endereco (cep, rua, bairro, cidade, estado, num) VALUES
		(cepVar, ruaVar, bairroVar, cidadeVar, estadoVar, numVar);
	RETURN LAST_INSERT_ID();
ELSE
	RETURN (SELECT id FROM endereco WHERE cep = cepVar
								    AND rua = ruaVar
                                    AND bairro = bairroVar
                                    AND cidade = cidadeVar
                                    AND estado = estadoVar
                                    AND num = numVar);
END IF;
END $
DELIMITER ;

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
-- função tb n tava funcionando qnd usava @registroEnd. erro: Unknown column 'registroEnd' in 'field list'

-- SELECT select_or_insert('09570410', 'Rua Serafim Carlos', 'Osvaldo Cruz', 'São Caetano do Sul', 'SP', 43) as idInserido;
-- drop function select_or_insert;
-- DROP DATABASE projetoIndividual;

CREATE TABLE grupo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    dataDebut DATE,
    empresa VARCHAR(40)
);

CREATE TABLE album (
	id INT PRIMARY KEY AUTO_INCREMENT,
    fkGrupo INT,
    FOREIGN KEY (fkGrupo) REFERENCES grupo (id),
    nome VARCHAR(40),
    dataLanc DATE,
    cover VARCHAR(50)
);

CREATE TABLE tracklist (
	id INT PRIMARY KEY AUTO_INCREMENT,
    fkAlbum INT,
    FOREIGN KEY (fkAlbum) REFERENCES album (id),
    title VARCHAR(40),
    genero VARCHAR(20)
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    fkFavGroup INT,
    FOREIGN KEY (fkFavGroup) REFERENCES grupo (id)
);

INSERT INTO grupo (nome, dataDebut, empresa) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS');
    
INSERT INTO grupo (nome, dataDebut, empresa) VALUES
	('NCT', '2020-01-01', 'SM ENTERTAINMENT');

INSERT INTO album (fkGrupo, nome, dataLanc, cover) VALUES
	(1, 'DARK & WILD', '2014-08-20', 'url(../assets/albums/darknwild.jpg');
    
INSERT INTO tracklist (fkAlbum, title, genero) VALUES
	(1, 'What am I to you', 'Hip Hop'),
    (1, 'Danger', 'Hip Hop');
    
SELECT grupo.nome nomeGrupo,
	album.nome nomeAlbum,
    tracklist.title musica
FROM grupo
JOIN album
	ON grupo.id = album.fkGrupo
JOIN tracklist
	ON album.id = tracklist.fkAlbum
WHERE grupo.id = 1;

SELECT grupo.nome, 
	count(fkFavGroup) as contFav
FROM usuario
JOIN grupo
	ON usuario.fkFavGroup = grupo.id
GROUP BY 1
ORDER BY contFav DESC;
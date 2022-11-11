DROP DATABASE IF EXISTS projetoIndividual;

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
    empresa VARCHAR(45) NOT NULL,
    imagem VARCHAR(100) NOT NULL
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

CREATE TABLE album (
	id INT,
    fkGrupo INT,
    FOREIGN KEY (fkGrupo) REFERENCES grupos (id),
    PRIMARY KEY (id, fkGrupo),
    nome VARCHAR(40),
    dataLanc DATE,
    cover VARCHAR(50)
);

CREATE TABLE tracklist (
	id INT,
    fkAlbum INT,
    FOREIGN KEY (fkAlbum) REFERENCES album (id),
    PRIMARY KEY (id, fkAlbum),
    title VARCHAR(40),
    genero VARCHAR(20)
);

CREATE TABLE votosAlbum (
	id INT AUTO_INCREMENT,
    fkUsuario INT,
    fkAlbum INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id),
    FOREIGN KEY (fkAlbum) REFERENCES album (id),
    PRIMARY KEY (id, fkUsuario, fkAlbum)
);

INSERT INTO grupos (nome, dataDebut, empresa, imagem) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS', 'url("../assets/grupos/btsgrupo.jpg")'),
	('TWICE', '2015-10-20', 'JYP ENTERTAINMENT', 'url("../assets/grupos/twicegrupo.nsei")');
    
/*
	('NCT', '2020-01-01', 'SM ENTERTAINMENT'),
    ('BLACKPINK', '2016-08-08', 'YG ENTERTAINMENT');
*/
INSERT INTO album (id, fkGrupo, nome, dataLanc, cover) VALUES
	(1, 1, 'DARK & WILD', '2014-08-20', 'url(../assets/albums/darknwild.jpg');
    
INSERT INTO tracklist (id, fkAlbum, title, genero) VALUES
	(1, 1, 'What am I to you', 'Hip Hop'),
    (2, 1, 'Danger', 'Hip Hop');

INSERT INTO votosAlbum (fkUsuario, fkAlbum) VALUES
	(1, 1);
    
INSERT INTO usuario (nome, sobrenome, email, dtNasc, senha, fkGrupoFav, fkEndereco) VALUES 
	('teste', '1', 'teste1@gmail.com', '2000-03-14', '123', 1, 1),
	('teste', '2', 'teste2@gmail.com', '2000-03-14', '123', 1, 1),
	('teste', '3', 'teste3@gmail.com', '2000-03-14', '123', 2, 1);

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

    
-- SELECT PARA PEGAR O NOME DO GRUPO, O NOME DO ALBUM E A TRACKLIST DESSE ALBUM DE UM DETERMINADO GRUPO
-- ESSE SELECT VAI SER UTILIZADO DUAS VEZES
-- UMA VEZ UTILIZANDO COMO PARÂMETRO O FKFAVGRUPO DO USUARIO LOGADO
-- OUTRA VEZ UTILIZANDO COMO PARÂMETRO O ID DO GRUPO DO RESULTADO DO SELECT MAIS ABAIXO
SELECT grupos.nome nomeGrupo,
	album.nome nomeAlbum,
    tracklist.title musica,
    album.cover
FROM grupos
JOIN album
	ON grupos.id = album.fkGrupo
JOIN tracklist
	ON album.id = tracklist.fkAlbum
WHERE grupos.id = 1;

-- SELECT PARA ACHAR OS DADOS DO GRUPO MAIS VOTADO
SELECT grupos.id,
	grupos.nome,
	count(fkGrupoFav) as contFav,
    grupos.imagem imagem
FROM usuario
JOIN grupos
	ON usuario.fkGrupoFav = grupos.id
GROUP BY 1
ORDER BY contFav DESC;
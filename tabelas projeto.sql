DROP DATABASE IF EXISTS projetoIndividual;

CREATE DATABASE projetoIndividual;

USE projetoIndividual;

CREATE TABLE endereco (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8) NOT NULL,
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
    email VARCHAR(45) UNIQUE NOT NULL,
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
    nome VARCHAR(40) NOT NULL,
    dataLanc DATE NOT NULL,
    cover VARCHAR(50) NOT NULL
);

CREATE TABLE tracklist (
	id INT,
    fkAlbum INT,
    fkGrupo INT,
    FOREIGN KEY (fkAlbum) REFERENCES album (id),
    FOREIGN KEY (fkGrupo) REFERENCES grupos (id),
    PRIMARY KEY (id, fkAlbum, fkGrupo),
    title VARCHAR(40) NOT NULL,
    duracao VARCHAR(10) NOT NULL,
    genero VARCHAR(20) NOT NULL
);

CREATE TABLE votosAlbum (
	id INT AUTO_INCREMENT,
    fkUsuario INT,
    fkAlbum INT,
    fkGrupo INT,
    dataVoto DATE NOT NULL,
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id),
    FOREIGN KEY (fkAlbum) REFERENCES album (id),
    FOREIGN KEY (fkGrupo) REFERENCES grupos (id),
    PRIMARY KEY (id, fkUsuario, fkAlbum, fkGrupo)
);

INSERT INTO grupos (nome, dataDebut, empresa, imagem) VALUES
	('BTS', '2013-06-13', 'HYBE LABELS', 'assets/grupos/btsgrupo.jpg'),
	('TWICE', '2015-10-20', 'JYP ENTERTAINMENT', 'assets/grupos/twicegrupo.jpg');
    
/*
	('NCT', '2020-01-01', 'SM ENTERTAINMENT'),
    ('BLACKPINK', '2016-08-08', 'YG ENTERTAINMENT');
*/

INSERT INTO album (id, fkGrupo, nome, dataLanc, cover) VALUES
	(1, 1, '2COOL4SKOOL', '2013-06-12', 'assets/albums/2cool4skool.jpg'),
    (2, 1, 'O!RUL8,2?', '2013-09-11', 'assets/albums/orul82.jpg'),
    (3, 1, 'SKOOL LUV AFFAIR', '2014-02-12', 'assets/albums/skoolluvaffair.jpg'),
    (4, 1, 'DARK & WILD', '2014-08-20', 'assets/albums/darknwild.jpg'),
    (5, 1, 'The Most Beautiful Moment in Life, pt.1', '2015-04-29', 'assets/albums/tmbmil1.jpg');
    
INSERT INTO album (id, fkGrupo, nome, dataLanc, cover) VALUES
	(1, 2, 'Page Two', '2016-04-25', 'assets/albums/twicepagetwo.jpg'),
	(2, 2, 'Twicecoaster', '2016-10-24', 'assets/albums/twicetwicecoaster.jfif'),
	(3, 2, "What's Twice", '2017-02-24', 'assets/albums/twicewhatstwice.jfif'),
	(4, 2, "Yes or Yes", '2018-11-05', 'assets/albums/twiceyesoryes.jpg'),
	(5, 2, "More and More", '2020-06-01', 'assets/albums/twicemoreandmore.jpg');


/* TRACKLIST ALBUNS BTS */
INSERT INTO tracklist (id, fkAlbum, fkGrupo, title, duracao, genero) VALUES
	(1, 4, 1, 'What Am I to You', '2:45', 'Hip Hop'),
    (2, 4, 1, 'Danger', '4:05', 'Hip Hop'),
    (3, 4, 1, 'War of Hormone', '4:25', 'Hip Hop'),
    (4, 4, 1, 'Hip Hop Phile', '4:17', 'Hip Hop'),
    (5, 4, 1, 'Let Me Know', '4:14', 'Hip Hop'),
    (6, 4, 1, 'Rain', '4:24', 'Hip Hop'),
    (7, 4, 1, 'BTS Cypher Pt.3: Killer', '4:27', 'Hip Hop'),
    (8, 4, 1, 'Interlude: What Are You Doing Now', '0:41', 'Hip Hop'),
    (9, 4, 1, 'Could You Turn off Your Cell Phone', '3:54', 'Hip Hop'),
    (10, 4, 1, 'Embarrassed', '4:01', 'Hip Hop'),
    (11, 4, 1, '24/7=Heaven', '3:46', 'Hip Hop'),
    (12, 4, 1, 'Look Here', '3:38', 'Hip Hop'),
    (13, 4, 1, 'So 4 more', '3:55', 'Hip Hop'),
    (14, 4, 1, 'Outro: Do You Think It Makes Sense?', '2:52', 'Hip Hop');

/* TRACKLIST ALBUNS TWICE */
INSERT INTO tracklist (id, fkAlbum, fkGrupo, title, duracao, genero) VALUES
	(1, 1, 2, 'CHEER UP', '3:28', 'K-Pop'),
    (2, 1, 2, 'Precious Love', '3:50', 'K-Pop'),
    (3, 1, 2, 'Touchdown', '3:22', 'K-Pop'),
    (4, 1, 2, 'Tuk Tok', '3:16', 'K-Pop'),
    (5, 1, 2, 'Woohoo', '3:20', 'K-Pop'),
    (6, 1, 2, 'My Headphones On', '3:16', 'K-Pop');
 
 
/* SELECT para pegar o nome do artista, o nome da música, o nome do álbum e o link da imagem do álbum */ 
SELECT grupos.nome nomeGrupo,
	tracklist.title,
    album.nome nomeAlbum,
    album.cover
FROM grupos
JOIN album
	ON grupos.id = album.fkGrupo
JOIN tracklist
	ON album.id = tracklist.fkAlbum AND grupos.id = tracklist.fkGrupo
WHERE grupos.id = 1;

/*
INSERT INTO votosAlbum (fkUsuario, fkAlbum, fkGrupo, dataVoto) VALUES
	(1, 1, 1, now());
*/
    
SELECT grupos.id,
	    grupos.nome,
	    count(fkGrupoFav) as contFav,
        grupos.imagem imagem
    FROM usuario
    JOIN grupos
	    ON usuario.fkGrupoFav = grupos.id
    GROUP BY 1
    ORDER BY contFav DESC;
    

/*
INSERT INTO usuario (nome, sobrenome, email, dtNasc, senha, fkGrupoFav, fkEndereco) VALUES 
	('teste', '1', 'teste1@gmail.com', '2000-03-14', '123', 1, 1),
	('teste', '2', 'teste2@gmail.com', '2000-03-14', '123', 1, 1),
	('teste', '3', 'teste3@gmail.com', '2000-03-14', '123', 2, 1);
*/


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

-- SELECT do LOGIN
DESC votosAlbum;
 SELECT usuario.*,
	votosAlbum.id idVoto,
	votosAlbum.fkUsuario,
	votosAlbum.fkAlbum,
	votosAlbum.fkGrupo,
	votosAlbum.dataVoto
FROM usuario
LEFT JOIN votosAlbum
	ON usuario.id = votosAlbum.fkUsuario
WHERE email = 'vd@gmail.com' AND senha = '123';

/*
SELECT *
FROM votosAlbum
JOIN album	
	ON votosAlbum.fkAlbum = album.id
JOIN grupos
	ON grupos.id = album.fkGrupo
	AND grupos.id = votosAlbum.fkGrupo;

UPDATE votosAlbum SET fkGrupo = 2, fkAlbum = 1 WHERE id = 4;

DELETE FROM votosAlbum WHERE id = 4;

INSERT INTO votosAlbum (fkUsuario, fkAlbum, fkGrupo, dataVoto) VALUES
	(1, 1, 1, now());
*/

INSERT INTO votosAlbum (fkUsuario, fkAlbum, fkGrupo, dataVoto) VALUES
	(1, 1, 1, now());

-- SELECT PARA PEGAR TODOS OS ALBUMS DE TODOS OS ARTISTAS
SELECT grupos.id idGrupo,
        grupos.nome nomeGrupo,
        album.id idAlbum,
        album.nome nomeAlbum,
	    album.cover
    FROM album
    JOIN grupos
	    ON grupos.id = album.fkGrupo
    ORDER BY grupos.id;
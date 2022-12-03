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

CREATE TABLE logRecupSenha (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    dataAlteracao DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER tgRecupSenha
    BEFORE UPDATE ON usuario
    FOR EACH ROW 
 INSERT INTO logRecupSenha
 SET action = 'update',
     userID = OLD.id,
     email = OLD.email,
     senha = OLD.senha,
     dataAlteracao = NOW();

SELECT * FROM logRecupSenha;
SELECT * FROM usuario;
-- UPDATE usuario SET senha = '1234' WHERE id = 1;

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
	(1, 1, 1, 'Intro: 2 Cool 4 Skool', '1:03', 'Hip Hop'),
    (2, 1, 1, 'We Are Bulletproof Pt.2', '3:43', 'Hip Hop'),
    (3, 1, 1, 'Skit: Circle Room Talk', '2:11', 'Skit'),
    (4, 1, 1, 'No More Dream', '3:42', 'Hip Hop'),
    (5, 1, 1, 'Interlude', '0:52', 'Hip Hop'),
    (6, 1, 1, 'Like', '3:51', 'Hip Hop'),
    (7, 1, 1, 'Outro: Circle Room Cypher', '5:23', 'Hip Hop');
    
INSERT INTO tracklist (id, fkAlbum, fkGrupo, title, duracao, genero) VALUES
	(1, 2, 1, 'Intro: O!RUL8,2?', '1:10', 'Hip Hop'),
    (2, 2, 1, 'N.O', '3:29', 'Hip Hop'),
    (3, 2, 1, 'We On', '3:50', 'Hip Hop'),
    (4, 2, 1, 'Skit: R U Happy Now?', '2:28', 'Skit'),
    (5, 2, 1, 'If I Ruled the World', '4:07', 'Hip Hop'),
    (6, 2, 1, 'Coffee', '4:20', 'Hip Hop'),
    (7, 2, 1, 'BTS Cypher Pt.1', '2:11', 'Hip Hop'),
    (8, 2, 1, 'Attack On Bangtan', '4:06', 'Hip Hop'),
    (9, 2, 1, 'Paldogangsan', '3:25', 'Hip Hop'),
    (10, 2, 1, 'Outro: Luv in Skool', '1:26', 'Hip Hop');
    
INSERT INTO tracklist (id, fkAlbum, fkGrupo, title, duracao, genero) VALUES
	(1, 3, 1, 'Intro: Skool Luv Affair', '2:58', 'Hip Hop'),
    (2, 3, 1, 'Boy in Luv', '3:50', 'K-Pop'),
    (3, 3, 1, 'Skit: Soulmate', '1:32', 'Skit'),
    (4, 3, 1, 'Where You From', '4:00', 'Hip Hop'),
    (5, 3, 1, 'Just One Day', '3:59', 'K-Pop'),
    (6, 3, 1, 'Tomorrow', '4:21', 'Hip Hop'),
    (7, 3, 1, 'BTS Cypher Pt.2: Triptych', '4:48', 'Hip Hop'),
    (8, 3, 1, 'Spine Breaker', '3:58', 'Hip Hop'),
    (9, 3, 1, 'Jump', '3:56', 'Hip Hop'),
    (10, 3, 1, 'Outro: Propose', '2:02', 'Hip Hop');

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

INSERT INTO tracklist (id, fkAlbum, fkGrupo, title, duracao, genero) VALUES
	(1, 5, 1, 'Intro: The Most Beautiful Moment in Life', '2:03', 'Hip Hop'),
    (2, 5, 1, 'I Need U', '3:30', 'K-Pop'),
    (3, 5, 1, 'Hold Me Tight', '4:34', 'Hip Hop'),
    (4, 5, 1, 'Skit: Expectation!', '2:27', 'Skit'),
    (5, 5, 1, 'Dope', '4:00', 'K-Pop'),
    (6, 5, 1, 'Boyz With Fun', '4:04', 'K-Pop'),
    (7, 5, 1, 'Converse High', '3:29', 'K-Pop'),
    (8, 5, 1, 'Moving On', '4:52', 'K-Pop'),
    (9, 5, 1, 'Outro: Love Is Not Over', '2:23', 'K-pop');

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
WHERE grupos.id = 1 AND album.id = 1;

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

DELIMITER $
CREATE FUNCTION update_password(idVar INT, emailVar VARCHAR(45), senhaVar VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
IF (ISNULL((SELECT id FROM usuario WHERE email = emailVar))) THEN RETURN -1;
ELSE
	IF (ISNULL((SELECT id FROM logRecupSenha WHERE email = emailVar
											   AND senha = senhaVar)))
		THEN UPDATE usuario SET senha = senhaVar WHERE id = idVar;
        RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END IF;
END $
DELIMITER ;

-- SELECT update_password(1, 'vd@gmail.com', '123') as update_status;
-- SELECT * FROM logRecupSenha;



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
	ON usuario.id = votosAlbum.fkUsuario;

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

INSERT INTO votosAlbum (fkUsuario, fkAlbum, fkGrupo, dataVoto) VALUES
	(1, 1, 1, now());
*/

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
    
-- SELECT PARA PEGAR O ABLUM MAIS VOTADO DO ARTISTA FAVORITO
SELECT
	grupos.id idGrupo,
	grupos.nome nomeGrupo,
    album.id idAlbum,
	album.nome nomeAlbum,
    COUNT(*) contagem
FROM grupos
JOIN album
	ON grupos.id = album.fkGrupo
JOIN votosAlbum
	ON grupos.id = votosAlbum.fkGrupo AND album.id = votosAlbum.fkAlbum
GROUP BY 2, 3
HAVING nomeGrupo = 'BTS'
ORDER BY 5 DESC;


/*
esse select pega a contagem distinta das combinacoes album e grupo - ou seja, se tiver fkAlbum 1 e fkGrupo 1 mais de uma vez, ele so conta como uma.alter
não vou usar, só deixei registrado msm
SELECT grupos.nome nomeGrupo,
	album.nome nomeAlbum,
	COUNT(DISTINCT votosAlbum.fkGrupo, votosAlbum.fkAlbum) cont_album_artistax
FROM grupos
JOIN album
	ON grupos.id = album.fkGrupo
JOIN votosAlbum
	ON grupos.id = votosAlbum.fkGrupo AND album.id = votosAlbum.fkAlbum
GROUP BY 2;
*/

SELECT
	COUNT(*) qtdVotos
FROM votosAlbum;
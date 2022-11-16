var usuarioModel = require("../models/usuarioModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioController");
    res.json("ESTAMOS FUNCIONANDO!");
}

function pegarAlbumTracklist(req, res) {
    var grupoId = req.body.grupoIdServer;
    var idAlbum = req.body.albumFavIdServer
    usuarioModel.pegarAlbumTracklist(grupoId, idAlbum).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function albumMaisVotado(req, res) {
    var nomeGrupo = req.body.nomeGrupoFavServer;
    usuarioModel.albumMaisVotado(nomeGrupo).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function grupoMaisVotado(req, res) {
    // console.log("Estou no controller do grupo mais votado")
    usuarioModel.grupoMaisVotado()
        .then(function (resultado) {
            // console.log(`THEN do Controller do grupo mais votado. resultado: ${resultado}`)
            if (resultado.length > 0) {
                res.status(200).json(resultado[0]);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function pegarAlbums(req, res) {
    console.log("Estou no controller do pegarAlbums")
    usuarioModel.pegarAlbums()
        .then(function (resultado) {
            // console.log(`THEN do Controller do grupo mais votado. resultado: ${resultado}`)
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function pegarQtdVotos(req, res) {
    usuarioModel.pegarQtdVotos()
        .then(function (resultado) {
            if (resultado.length == 1) {
                res.status(200).json(resultado[0]);
            } else {
                res.status(204).send("Nenhum voto registrado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function entrar(req, res) {
    var email = req.body.loginServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.entrar(email, senha)
            .then(
                function (resultado) {
                    // console.log(`\nResultados encontrados: ${resultado.length}`);
                    // console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    if (resultado.length == 1) {
                        // console.log(resultado);
                        res.json(resultado[0]);
                    } else if (resultado.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function userFavGroup(req, res) {
    var idFavGroup = req.body.idFavGroupServer;

    if (idFavGroup == undefined) {
        res.status(400).send("Seu ID de grupo favorito está undefined!");
    } else {
        usuarioModel.userFavGroup(idFavGroup)
            .then(
                function (resultado) {
                    console.log(`\nResultados encontrados: ${resultado.length}`);
                    // console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    if (resultado.length > 0) {
                        res.status(200).json(resultado);
                    } else {
                        res.status(204).send("Nenhum grupo com esse ID encontrado!")
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function verEndereco(req, res) {
    var cep = req.body.cepServer
    var rua = req.body.ruaServer
    var bairro = req.body.bairroServer
    var cidade = req.body.cidadeServer
    var estado = req.body.estadoServer
    var num = req.body.numServer

    if (cep == undefined) {
        res.status(400).send("Seu cep está indefinida!");
    } else if (rua == undefined) {
        res.status(400).send("Sua rua está indefinida!");
    } else if (bairro == undefined) {
        res.status(400).send("Seu bairro está indefinido!");
    } else if (cidade == undefined) {
        res.status(400).send("Sua cidade está indefinida!");
    } else if (estado == undefined) {
        res.status(400).send("Seu estado está indefinido!");
    } else if (num == undefined) {
        res.status(400).send("Seu número está indefinido!");
    } else {

        usuarioModel.verEndereco(cep, rua, bairro, cidade, estado, num)
            .then(
                function (resultado) {
                    // console.log(`idEndereco do indice 0 do resultado: ${resultado[0].idEndereco}`);
                    res.json(resultado[0]);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).send("Houve um erro ao realizar o cadastro!");
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer
    var sobrenome = req.body.sobrenomeServer
    var email = req.body.emailServer
    var dtNasc = req.body.dtNascServer
    var senha = req.body.senhaServer
    var favGroup = req.body.favGroupServer
    var idEndereco = req.body.idEnderecoServer

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, sobrenome, email, dtNasc, senha, favGroup, idEndereco)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).send("Houve um erro ao realizar o cadastro!");
                }
            );
    }
}

function registrarVoto(req, res) {
    var instrucao = req.body.instrucaoServer
    // var idUsuario = req.body.idUsuarioServer
    // var idVoto = req.body.idVotoServer
    // var fkGrupo = req.body.fkGrupoServer
    // var fkAlbum = req.body.fkAlbumServer

    // Faça as validações dos valores
    if (instrucao == undefined) {
        res.status(400).send("Sua instrução está undefined!");
    } else {
        usuarioModel.registrarVoto(instrucao)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao registrar o voto! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).send("Houve um erro ao registrar o voto!");
                }
            );
    }
}

module.exports = {
    entrar,
    cadastrar,
    grupoMaisVotado,
    pegarAlbumTracklist,
    pegarQtdVotos,
    registrarVoto,
    albumMaisVotado,
    userFavGroup,
    pegarAlbums,
    testar,
    verEndereco
}
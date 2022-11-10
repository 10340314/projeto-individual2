var usuarioModel = require("../models/usuarioModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioController");
    res.json("ESTAMOS FUNCIONANDO!");
}

function listar(req, res) {
    usuarioModel.listar()
        .then(function (resultado) {
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
                    console.log(`\nResultados encontrados: ${resultado.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    if (resultado.length == 1) {
                        console.log(resultado);
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

module.exports = {
    entrar,
    cadastrar,
    listar,
    testar,
    verEndereco
}
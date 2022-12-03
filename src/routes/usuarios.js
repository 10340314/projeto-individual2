var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.get("/", function (req, res) {
    usuarioController.testar(req, res);
});

router.get("/grupoMaisVotado", function (req, res) {
    usuarioController.grupoMaisVotado(req, res);
});

router.get("/pegarAlbums", function (req, res) {
    usuarioController.pegarAlbums(req, res);
});

router.get("/pegarQtdVotos", function (req, res) {
    usuarioController.pegarQtdVotos(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/registrarVoto", function (req, res) {
    usuarioController.registrarVoto(req, res);
})

router.post("/userFavGroup", function (req, res) {
    usuarioController.userFavGroup(req, res);
}) 

router.post("/endereco", function (req, res) {
    usuarioController.verEndereco(req, res);
})

router.post("/pegarAlbumTracklist", function (req, res) {
    usuarioController.pegarAlbumTracklist(req, res);
});

router.post("/albumMaisVotado", function (req, res) {
    usuarioController.albumMaisVotado(req, res);
});

router.post("/login", function (req, res) {
    usuarioController.entrar(req, res);
});

router.post("/trocar", function (req, res) {
    usuarioController.trocar(req, res);
});

module.exports = router;
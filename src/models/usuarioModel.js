var database = require("../database/config")

function grupoMaisVotado() {
    // console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function grupoMaisVotado()");
    var instrucao = `
    SELECT grupos.id,
	    grupos.nome,
	    count(fkGrupoFav) as contFav,
        grupos.imagem imagem
    FROM usuario
    JOIN grupos
	    ON usuario.fkGrupoFav = grupos.id
    GROUP BY 1
    ORDER BY contFav DESC;
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function pegarAlbums() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function pegarAlbums()");
    var instrucao = `
    SELECT grupos.id idGrupo,
        grupos.nome nomeGrupo,
        album.id idAlbum,
        album.nome nomeAlbum,
	    album.cover
    FROM album
    JOIN grupos
	    ON grupos.id = album.fkGrupo
    ORDER BY grupos.id;
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function pegarAlbumTracklist(grupoId) {
    // console.log("ACESSEI O AVISO  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
    SELECT grupos.nome nomeGrupo,
	    tracklist.title,
        album.nome nomeAlbum,
        album.cover
    FROM grupos
    JOIN album
	    ON grupos.id = album.fkGrupo
    JOIN tracklist
	    ON album.id = tracklist.fkAlbum AND grupos.id = tracklist.fkGrupo
    WHERE grupos.id = ${grupoId};
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function entrar(email, senha) {
    // console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucao = `
    SELECT usuario.*,
	    votosAlbum.id idVoto,
        votosAlbum.fkUsuario,
        votosAlbum.fkAlbum,
        votosAlbum.fkGrupo,
        votosAlbum.dataVoto
    FROM usuario
    LEFT JOIN votosAlbum
	    ON usuario.id = votosAlbum.fkUsuario
    WHERE email = '${email}' AND senha = '${senha}';
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function userFavGroup(idFavGroup) {
    // console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function userFavGroup(): ", idFavGroup)
    var instrucao = `
        SELECT grupos.nome,
            grupos.imagem,
            album.cover
        FROM grupos
        JOIN album
            ON grupos.id = album.fkGrupo
        WHERE grupos.id = ${idFavGroup};
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucao
function cadastrar(nome, sobrenome, email, dtNasc, senha, favGroup, idEndereco) {
    // console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, sobrenome, email, dtNasc, senha, favGroup);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucao = `
        INSERT INTO usuario (nome, sobrenome, email, dtNasc, senha, fkGrupoFav, fkEndereco) VALUES ('${nome}', '${sobrenome}', '${email}', '${dtNasc}', '${senha}', ${favGroup}, ${idEndereco});
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function registrarVoto(instrucao) {
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function verEndereco(cep, rua, bairro, cidade, estado, num) {
    // console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function verEndereco()");
    var instrucao = `
        SELECT select_or_insert('${cep}', '${rua}', '${bairro}', '${cidade}', '${estado}', '${num}') as idEndereco;
    `;
    // console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    entrar,
    cadastrar,
    grupoMaisVotado,
    userFavGroup,
    registrarVoto,
    pegarAlbums,
    pegarAlbumTracklist,
    verEndereco
};
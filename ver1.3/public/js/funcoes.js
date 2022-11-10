// função para verificar se a input tem erro e trocar a borda para vermelho
function verifErro(valIpt, input) {
    if (valIpt == '') {
        erro = true
        input.style.border = 'solid 2px red'
    }
}

// função para limpar a borda das inputs
function limpaBorda(input) {
    if (input == confSenhaInput || input == senhaInput) {
        senhaInput.style.border = 'none'
        confSenhaInput.style.border = 'none'
    } else {
        input.style.border = 'none'
    }
}
function buscaCEP() {
    let divErros = document.getElementById("div_errosEnd")
    let spanErro = document.getElementById("span_erroEnd")
    let cep1 = document.getElementById("ipt_cep")
    let cep = cep1.value.replace(/\D/g, '')
    divErros.style.display = 'none'
    spanErro.innerHTML = ""
    if (cep != '') {
        let url = "https://brasilapi.com.br/api/cep/v1/" + cep

        let req = new XMLHttpRequest();
        req.open("GET", url);
        req.send();

        req.onload = function() {
            if (req.status == 200) {
                let endereco = JSON.parse(req.response)
                document.getElementById("ipt_rua").value = endereco.street
                document.getElementById("ipt_bairro").value = endereco.neighborhood
                document.getElementById("ipt_cidade").value = endereco.city
                document.getElementById("ipt_estado").value = endereco.state
            } else if (req.status == 404) {
                document.getElementById("ipt_rua").value = ""
                document.getElementById("ipt_bairro").value = ""
                document.getElementById("ipt_cidade").value = ""
                document.getElementById("ipt_estado").value = ""
                document.getElementById("ipt_num").value = ""
                cep1.focus()
                divErros.style.display = 'flex'
                spanErro.innerHTML = "O CEP digitado é inválido!"
                return false
            } else {
                alert("Erro ao fazer a requisição")
            }
        }
    }
}

window.onload = function() {
    let iptcep = document.getElementById("ipt_cep")
    iptcep.addEventListener("blur", buscaCEP)
}
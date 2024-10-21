function headerResp(){
    let window_width = window.innerWidth;
    let header_text = document.getElementById("headertext");
    let logo_header = document.getElementById("logo");
    if(window_width<600){
        header_text.textContent = " ";
        logo_header.setAttribute("src","celular.png");
    }
    else if(window_width>=600){
        header_text.textContent = "Proyecto \"40 años sin/con Julio Cortazar\"";
        logo_header.setAttribute("src","pc.png");
    }
}

headerResp();

window.addEventListener("resize",headerResp);
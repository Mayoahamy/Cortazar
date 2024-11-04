function headerResp(){
    let window_width = window.innerWidth;
    let header_text = document.getElementById("headertext");
    if(window_width<600){
        header_text.textContent = "\"40 sin/con J.C.\"";
    }
    else if(window_width>=600){
        header_text.textContent = "Proyecto \"40 años sin/con Julio Cortazar\"";
    }
}

headerResp();

window.addEventListener("resize",headerResp);
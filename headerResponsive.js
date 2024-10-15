function headerResp(){
    let window_width = window.innerWidth;
    let header_text = document.getElementById("headertext");
    if(window_width<600 && window_width >=300){
        header_text.textContent = "\"40 años J.C.\""
    }
    else if(window_width>=600){
        header_text.textContent = "Proyecto \"40 años sin/con Julio Cortazar\""
    }
    else if(window_width<300){
        header_text.textContent = "\"40 J.C.\"";
    }
}

headerResp();

window.addEventListener("resize",headerResp);
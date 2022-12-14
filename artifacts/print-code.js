window.onload=function() {

var codes = document.getElementsByClassName("print-code");
if ( codes != null) {
    for(let i=0; i < codes.length; i++) {
        let d = codes[i];
        let filename = d.attributes['data'].value;
        let lang = d.attributes['lang'].value;
        fetch(filename)
            .then(response => response.text())
            .then(data => {
            let p = document.createElement('pre');
            let c = document.createElement('code');
            c.className = lang;
            let text = document.createTextNode(data);
            p.appendChild(c);
            c.appendChild(text);
            hljs.highlightElement(c);
            addSelectButton(c);
            d.replaceWith(p);
        });
    }
}

hljs.highlightAll();

Array.prototype.forEach.call(document.querySelectorAll('pre > code'), addSelectButton);

function addSelectButton(elmCodeFrame){
    var elmSelectButton = document.createElement('div');
    elmSelectButton.setAttribute('class', '__select-code');

    elmSelectButton.setAttribute('style', "\
        display: inline-block;\
        left: 90%;\
        float: right;\
        font-weight: bold;\
        background-color: transparent;\
        cursor: pointer;")

    elmSelectButton.addEventListener('click', function(){
        select(elmCodeFrame);
    });
    elmSelectButton.insertAdjacentHTML('afterbegin', '<span></span><i class="fa fa-clipboard"/>');
    elmCodeFrame.insertBefore(elmSelectButton, elmCodeFrame.firstChild);
}

function select(elm){
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.selectNodeContents(elm);
    selection.addRange(range);
    document.execCommand('copy');
    selection.removeAllRanges();
    var span = elm.querySelector('.__select-code span');
    span.innerHTML="Copied";
    span.style.transition = 'none';
    setTimeout(function() {
      span.style.opacity = 0;
      span.style.transition = 'opacity 1s';
    }, 500);
    setTimeout(function() {
      span.innerHTML="";
      span.style.opacity =1;
    }, 1000);
}
};

/// <reference path="./highlight.min.ts" />
function addCopyBtn() {
    hljs.highlightAll();
    Array.prototype.forEach.call(document.querySelectorAll('pre > code'), addCopyButton);
}
function addCopyButton(elmCodeFrame) {
    var elmSelectButton = document.createElement('div');
    elmSelectButton.setAttribute('class', '__select-code');
    elmSelectButton.setAttribute('style', "\
        display: inline-block;\
        left: 90%;\
        float: right;\
        font-weight: bold;\
        background-color: transparent;\
        cursor: pointer;");
    elmSelectButton.addEventListener('click', function () {
        select(elmCodeFrame);
    });
    elmSelectButton.insertAdjacentHTML('afterbegin', '<span></span><svg width="16" height="16" class="bi bi-clipboard" role="img" fill="currentColor"><use xlink:href="img/icon.svg#clipboard"/></svg>');
    elmCodeFrame.firstChild.before(elmSelectButton);
}
function select(elm) {
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.selectNodeContents(elm);
    selection.addRange(range);
    document.execCommand('copy');
    selection.removeAllRanges();
    var span = elm.querySelector('.__select-code span');
    span.innerHTML = "Copied";
    span.style.transition = 'none';
    setTimeout(function () {
        span.style.opacity = 0;
        span.style.transition = 'opacity 1s';
    }, 500);
    setTimeout(function () {
        span.innerHTML = "";
        span.style.opacity = 1;
    }, 1000);
}
function print_code() {
    var codes = document.getElementsByClassName("print-code");
    if (codes != null) {
        var _loop_1 = function (i) {
            var d = codes[i];
            var filename = d.attributes['data'].value;
            var lang;
            if (d.attributes['lang'] === undefined) {
                lang = "";
            }
            else {
                lang = d.attributes['lang'].value;
            }
            fetch(filename)
                .then(function (response) { return response.text(); })
                .then(function (data) {
                var p = document.createElement('pre');
                var c = document.createElement('code');
                c.className = lang;
                var text = document.createTextNode(data);
                p.appendChild(c);
                c.appendChild(text);
                hljs.highlightElement(c);
                addCopyButton(c);
                d.replaceWith(p);
            });
        };
        for (var i = 0; i < codes.length; i++) {
            _loop_1(i);
        }
    }
}

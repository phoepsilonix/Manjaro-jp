window.onload=function() {

async function getThumbnail(vid) {
const THUMB_TYPES = [
    /** w1280 */
    'maxresdefault.jpg',
    'maxres1.jpg',
    /** w640 */
    'sddefault.jpg',
    'sd1.jpg',
    /** w480 */
    'hqdefault.jpg',
    /** w320 */
    'mqdefault.jpg',
    /** w120 */
    'default.jpg',
];
const getYtThumbnail = async (vid) => {
    const loadImage = (src) => {
        return new Promise((resolve, reject) => {
            const img = new Image();
            img.onload = (e) => resolve(img);
            img.src = src;
        });
    };
    for (let i = 0; i < THUMB_TYPES.length; i++) {
        const fileName = `https://img.youtube.com/vi/${vid}/${THUMB_TYPES[i]}`;
        const res = await loadImage(fileName);
        if (!THUMB_TYPES[i + 1] || (res).width > 120 ) {
            return fileName;
        }
    }
};
    return await getYtThumbnail(vid);
}
      (async () => {
          var movies = document.getElementsByClassName("ytVideo");
          for (var i = 0; i < movies.length; i++) {
              movies[i].id="ytVideo"+i;
              var vid = movies[i].attributes['data'].value;
              var thumbnail;
              thumbnail = await getThumbnail(vid);
              movies[i].innerHTML = '<div><img class="embed-responsive rounded" id="yt-thumb' + i + '" src="' + thumbnail + '"><div>';
              await embedYoutube(i);
          }
      })();
}
 
async function embedYoutube(num) {
    document.getElementById('yt-thumb' + num).addEventListener('click', function() {
        var movie = document.getElementById("ytVideo"+num);
        if (movie.childNodes.length == 1) {
            var frame = document.createElement('iframe');
            movie.className="embed-responsive embed-responsive-16by9";
            frame.frameborder="0";
            frame.allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
            frame.sandbox="allow-same-origin allow-scripts allow-forms allow-popups allow-popups-to-escape-sandbox allow-storage-access-by-user-activation";
            frame.allowfullscreen="1";
            frame.className="embed-responsive rounded";
　          frame.src="https://www.youtube.com/embed/" + movie.attributes['data'].value;
            frame.src="https://www.youtube.com/embed/" + movie.attributes['data'].value + "?controls=1&amp;autoplay=1&amp;disablekb=1&amp;enablejsapi=1&amp;iv_load_policy=3&amp;playsinline=1&amp;rel=0&amp;autohide=0&amp;origin=https%3A%2F%2Fphoepsilonix.love&amp;widgetid=1";
            frame.addEventListener('load', function(event) {
                let arg=null;
                let action="playVideo";
                this.contentWindow.postMessage('{"event":"command", "func":"'+action+'", "args":'+arg+'}', '*');
            });
            movie.childNodes[0].replaceWith(frame);
        }
    });
}

var scriptUrl = 'https:\/\/www.youtube.com\/s\/player\/e96685ea\/www-widgetapi.vflset\/www-widgetapi.js';window['yt_embedsEnableIframeSrcWithIntent'] =  true ;try{var ttPolicy=window.trustedTypes.createPolicy("youtube-widget-api",{createScriptURL:function(x){return x}});scriptUrl=ttPolicy.createScriptURL(scriptUrl)}catch(e){}var YT;if(!window["YT"])YT={loading:0,loaded:0};var YTConfig;if(!window["YTConfig"])YTConfig={"host":"https://phoepsilonix.love"};
if(!YT.loading){YT.loading=1;(function(){var l=[];YT.ready=function(f){if(YT.loaded)f();else l.push(f)};window.onYTReady=function(){YT.loaded=1;for(var i=0;i<l.length;i++)try{l[i]()}catch(e$0){}};YT.setConfig=function(c){for(var k in c)if(c.hasOwnProperty(k))YTConfig[k]=c[k]};var a=document.createElement("script");a.type="text/javascript";a.id="www-widgetapi-script";a.src=scriptUrl;a.async=true;var c=document.currentScript;if(c){var n=c.nonce||c.getAttribute("nonce");if(n)a.setAttribute("nonce",n)}var b=
document.getElementsByTagName("script")[0];b.parentNode.insertBefore(a,b)})()};


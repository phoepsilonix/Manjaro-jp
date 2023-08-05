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
        if (!THUMB_TYPES[i + 1] ||  res['width'] > 120 ) {
            return fileName;
        }
    }
};
    return await getYtThumbnail(vid);
}
      (async () => {
          var movies = document.getElementsByClassName("ytVideo");
          if (movies != null) {
          for (var i = 0; i < movies.length; i++) {
              movies[i].id="ytVideo"+i;
              var vid = movies[i].attributes['data'].value;
              movies[i]['state']=0;
              var thumbnail;
              thumbnail = await getThumbnail(vid);
              movies[i].innerHTML = '<img class="embed-responsive embed-responsive-16by9" id="yt-thumb' + i + '" src="' + thumbnail + '">';
              await embedYoutube(i);
          }
          }
      })();
 
async function embedYoutube(num) {
    let i = <HTMLCanvasElement>document.getElementById('yt-thumb' + num);
    i.addEventListener('pointerdown', function() {
        var movie = document.getElementById("ytVideo"+num);
        if (movie.childNodes.length == 1) {
            let myhost = "https%3A%2F%2Fphoepsilonix.love";
            let frame = document.createElement('iframe');
            movie.className = "embed-responsive embed-responsive-16by9";
            frame.id = "ytVideoFrame"+num;
            frame.width = i.width.toString();
            frame.height = i.height.toString();
            frame.frameBorder = "0";
            frame.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
//            frame.sandbox = "allow-same-origin allow-scripts allow-forms allow-popups allow-popups-to-escape-sandbox allow-storage-access-by-user-activation";
            frame.allowFullscreen = true;
            frame.className = "embed-responsive rounded";
            frame.src = "https://www.youtube.com/embed/" + movie.attributes['data'].value + "?controls=1&amp;disablekb=1&amp;enablejsapi=1&amp;iv_load_policy=3&amp;playsinline=1&amp;rel=0&amp;autohide=0&amp;origin=" + myhost + "&amp;widgetid=1";
            frame.setAttribute("state", '1');
            frame.addEventListener('load', function (event) {
                let arg = null;
                let action = "playVideo";
                this.contentWindow.postMessage('{"event":"command", "func":"' + action + '", "args":' + arg + '}', '*');
            })
/*
            frame.addEventListener('pointerdown', function(event) {
                onPlayerStateChange(event, num);
            });
            movie.addEventListener('pointerdown', function(event) {
                onPlayerStateChange(event, num);
            });
            */
            movie.childNodes[0].replaceWith(frame);
        }
    });
}
var ytPlaying=-1;
var ytPlay=-1;
var ytStop=-1;
/*
function onPlayerStateChange(event, num) {
        let movie = document.getElementById("ytVideoFrame"+num);
        var thisState = movie.getAttribute('state');
        if( thisState == '1' && ytPlaying == -1) {
            ytPlaying = num;
        } else if(thisState == '1' && ytPlaying != num) {
            ytStop = ytPlaying;
            ytPlay = num;
        } else {
            check(event, num);
        }
    if(ytStop != -1) {
        let arg = null;
        let action = "pauseVideo";
        let stop_movie = document.getElementById("ytVideoFrame"+ytStop);
        stop_movie['contentWindow'].postMessage('{"event":"command", "func":"' + action + '", "args":' + arg + '}', '*');
        ytStop = -1;
        //movie.firstChild.setAttribute('state', '0');
    }
    if(ytPlay != -1) {
        ytPlaying = ytPlay;
        ytPlay = -1;
    }
}
*/
/*
    player.playVideo():Void
    player.pauseVideo():Void
    player.stopVideo():Void
    player.seekTo(seconds:Number, allowSeekAhead:Boolean):Void
    player.clearVideo():Void
*/


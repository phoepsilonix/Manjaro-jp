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
              console.log(thumbnail)
              movies[i].innerHTML = '<img class="embed-responsive rounded" id="yt-thumb' + i + '" src="' + thumbnail + '">';
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
            frame.allowfullscreen;
            frame.className="embed-responsive rounded";
　          frame.src="https://www.youtube.com/embed/" + movie.attributes['data'].value;
            movie.childNodes[0].replaceWith(frame);
        }
    });
}


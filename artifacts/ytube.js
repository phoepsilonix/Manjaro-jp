window.onload=function() {
  var movies = document.getElementsByClassName("ytVideo");
  for (var i = 0; i < movies.length; i++) {
      movies[i].id="ytVideo"+i;
      movies[i].innerHTML = '<img class="embed-responsive rounded" id="yt-thumb' + i + '" src="http://i.ytimg.com/vi/' + movies[i].attributes['data'].value + '/maxresdefault.jpg">';
      embedYoutube(i);
  }
}
 
function embedYoutube(num) {
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


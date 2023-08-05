var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var _this = this;
function getThumbnail(vid) {
    return __awaiter(this, void 0, void 0, function () {
        var THUMB_TYPES, getYtThumbnail;
        var _this = this;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    THUMB_TYPES = [
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
                    getYtThumbnail = function (vid) { return __awaiter(_this, void 0, void 0, function () {
                        var loadImage, i, fileName, res;
                        return __generator(this, function (_a) {
                            switch (_a.label) {
                                case 0:
                                    loadImage = function (src) {
                                        return new Promise(function (resolve, reject) {
                                            var img = new Image();
                                            img.onload = function (e) { return resolve(img); };
                                            img.src = src;
                                        });
                                    };
                                    i = 0;
                                    _a.label = 1;
                                case 1:
                                    if (!(i < THUMB_TYPES.length)) return [3 /*break*/, 4];
                                    fileName = "https://img.youtube.com/vi/".concat(vid, "/").concat(THUMB_TYPES[i]);
                                    return [4 /*yield*/, loadImage(fileName)];
                                case 2:
                                    res = _a.sent();
                                    if (!THUMB_TYPES[i + 1] || res['width'] > 120) {
                                        return [2 /*return*/, fileName];
                                    }
                                    _a.label = 3;
                                case 3:
                                    i++;
                                    return [3 /*break*/, 1];
                                case 4: return [2 /*return*/];
                            }
                        });
                    }); };
                    return [4 /*yield*/, getYtThumbnail(vid)];
                case 1: return [2 /*return*/, _a.sent()];
            }
        });
    });
}
(function () { return __awaiter(_this, void 0, void 0, function () {
    var movies, i, vid, thumbnail;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                movies = document.getElementsByClassName("ytVideo");
                if (!(movies != null)) return [3 /*break*/, 5];
                i = 0;
                _a.label = 1;
            case 1:
                if (!(i < movies.length)) return [3 /*break*/, 5];
                movies[i].id = "ytVideo" + i;
                vid = movies[i].attributes['data'].value;
                movies[i]['state'] = 0;
                return [4 /*yield*/, getThumbnail(vid)];
            case 2:
                thumbnail = _a.sent();
                movies[i].innerHTML = '<img class="embed-responsive embed-responsive-16by9" id="yt-thumb' + i + '" src="' + thumbnail + '">';
                return [4 /*yield*/, embedYoutube(i)];
            case 3:
                _a.sent();
                _a.label = 4;
            case 4:
                i++;
                return [3 /*break*/, 1];
            case 5: return [2 /*return*/];
        }
    });
}); })();
function embedYoutube(num) {
    return __awaiter(this, void 0, void 0, function () {
        var i;
        return __generator(this, function (_a) {
            i = document.getElementById('yt-thumb' + num);
            i.addEventListener('pointerdown', function () {
                var movie = document.getElementById("ytVideo" + num);
                if (movie.childNodes.length == 1) {
                    var myhost = "https%3A%2F%2Fphoepsilonix.love";
                    var frame = document.createElement('iframe');
                    movie.className = "embed-responsive embed-responsive-16by9";
                    frame.id = "ytVideoFrame" + num;
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
                        var arg = null;
                        var action = "playVideo";
                        this.contentWindow.postMessage('{"event":"command", "func":"' + action + '", "args":' + arg + '}', '*');
                    });
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
            return [2 /*return*/];
        });
    });
}
var ytPlaying = -1;
var ytPlay = -1;
var ytStop = -1;
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

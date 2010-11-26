var info = 'Multitouch ver 1.0';


function addLoadEvent(aFunc) {
    var oldOnload = window.onload;
    if (typeof window.onload != 'function') {
        window.onload = aFunc;
    } else {
        window.onload = function () {
            oldOnload();
            aFunc();
        }
    }
};

function write_debug( str ){
    document.getElementById("debug_container").innerHTML = str + '<br />' + document.getElementById("debug_container").innerHTML;
}

function isEventSupported(eventName) {
    var el = document.createElement("div");
    eventName = "on" + eventName;
    var isSupported = eventName in el;
    if (!isSupported) {
        el.setAttribute(eventName, "return;");
        isSupported = typeof el[eventName] == "function";
    }
    el = null;
    return isSupported;
}

var usemouse = !isEventSupported('touchmove'); //(document.body['ontouchmove']) ? false : true;

function getTarget(e){
    var targ;
    if (e.target){
        targ = e.target;
    }else if(e.srcElement){
        targ = e.srcElement;
    }
    if (targ.nodeType == 3) { // defeat Safari bug
        targ = targ.parentNode;
    }
    return targ;
}

var transelements = {};
var touchelements = {};

/* ------------ Touch events ------------ */
//start
function ts(event){
    event.preventDefault;
    try {
        var t = event.targetTouches;
        event.target.style.zIndex = 9999;

        if(t.length >= 2){
            touchelements[ event.target.id + '_trans'] = touchelements[ event.target.id + '_trans'] || {
                width: event.target.clientWidth,
                height: event.target.clientHeight,
                change: {
                    x: 0,
                    y: 0
                },
                rotation: 0,
                scale: 1.0
            };
        }

        for(var i = 0; i <= t.length -1; i++){
            var id = t[i].target.id + '_' + t[i].identifier;
            touchelements[ id ] = (touchelements [ id ] || {
                id: t[i].identifier,
                target: t[i].target,
                pageX: t[i].pageX,
                pageY: t[i].pageY
            });
            write_debug( id + ' ontouchstart: X: ' + t[i].pageX + ', Y: ' + t[i].pageY);
        }

    }catch(e){
        write_debug(e);
    }
}

//move
function tm(event){
    event.preventDefault;
    var curelem;
    var t;
    var collectTrans = (event.targetTouches.length >= 2)?true:false;
    try {
      t = event.targetTouches;
       for(var i = 0; i <= t.length -1; i++){
            var id = t[i].target.id + '_' + t[i].identifier;
            if( touchelements[ id ] ){
                curelem = touchelements[ id ];
                moveElement( t[i] );
                write_debug( id + ' ontouchmove: X: ' + curelem.pageX + ', Y: ' + curelem.pageY);
            }
        }
        if(collectTrans){
            transformElement();
        }

    } catch (e) {
        write_debug(e);
    }

    //move element
    function moveElement( touch ) {
        if(collectTrans){
            var trans = touchelements[ touch.target.id + '_trans'];
            trans.change.x += (touch.pageX - curelem.pageX);
            trans.change.y += (touch.pageY - curelem.pageY);
        }else{
            curelem.target.style.left = (touch.pageX - (curelem.pageX - touch.target.offsetLeft)) + "px";
            curelem.target.style.top = (touch.pageY - (curelem.pageY - touch.target.offsetTop)) + "px";
        }
        curelem.pageX = touch.pageX;
        curelem.pageY = touch.pageY;

    }
}

//end
function te(event){
    event.preventDefault;
    var curelem;
    var targ = getTarget(event);
    try {

        event.target.style.zIndex = 1;
        write_debug('end = ' +  event.target.id);

        return false;

        var t = event.targetTouches;
        for(var i = 0; i <= t.length -1; i++){
            if(touchelements[ targ.id + '_' + i ]){
                curelem = touchelements[ t[i].identifier ];
                write_debug('<hr>' +  curelem.target.id + ' ontouchend: X: ' + curelem.pageX + ', Y: ' + curelem.pageY);
                touchelements[ t[i].identifier ] = null;
            }
        }

        if( touchelements[ event.target.id + '_trans'] ){
            touchelements[ event.target.id + '_trans'] = null;
        }

    } catch (e) {
        write_debug(e);
    }
}


// -------------- on window load -------------- \\
addLoadEvent(function(){
    var elems = [document.getElementById('red'), document.getElementById('blue')];
    for(var i = 0; i <= elems.length - 1; i++){
       addTouchListeners(elems[i]);
       addGestureListeners(elems[i]);
    }

    document.getElementById("info").innerHTML = info + ' | ' + ((getUrlParam('load') === 'trans') ? '<a href="index.html">USE TOUCH</a>' : '<a href="index.html?load=trans">USE TRANSFORMATION</a>');

    function addTouchListeners(elem){
        elem.ontouchmove = tm;
        elem.ontouchend = te;
        elem.ontouchstart = ts;
    }

    function addGestureListeners(elem){
        elem.ongesturestart= ts;
        elem.ongesturechange= tm;
        elem.ongestureend = te;
    }
});


document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("Hello World!");
    var xdebugSession = getCookie("XDEBUG_SESSION");
    if (xdebugSession != "") {
        sendCurrentStateToApp(true);
    } else {
        sendCurrentStateToApp(false);
    }
});

safari.self.addEventListener("message", messageHandler); // Message recieved from Swift code


function messageHandler(event) {
    if (event.name === "toggleXdebug") {
        toggleXDebugButton();
    }
}


function toggleXDebugButton(event) {
    
    var xdebugSession = getCookie("XDEBUG_SESSION");
    if (xdebugSession != "") {
        setCookie("XDEBUG_SESSION","",0);
    } else {
        setCookie("XDEBUG_SESSION","XDEBUG_ECLIPSE",365);
    }
    
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function sendCurrentStateToApp(isActive){
    safari.extension.dispatchMessage("updateToolbarIcon",  { debugOn: isActive });
}

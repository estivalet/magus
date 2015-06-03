

/**
 * @param url Server URL to call.
 * @param f Function to execute after server return.
 */
function callServer(url, f) {
	// Check if browser supports Ajax calls.
    if (document.getElementById) { 
        if (window.XMLHttpRequest) {
            HttpReq = new XMLHttpRequest();
            HttpReq.onreadystatechange = f;
            HttpReq.open("GET", url, true);
            HttpReq.send(null);
        } else if (window.ActiveXObject) {
            HttpReq = new ActiveXObject("Microsoft.XMLHTTP");
            if (HttpReq) {
                HttpReq.onreadystatechange = XMLHttpRequestChange;
                HttpReq.open("GET", url, true);
                HttpReq.send();
            }
        }
    }  
}

function createForm(id, method, action) {
	var form = document.createElement("form");
	form.setAttribute("id", id);
	form.setAttribute("method", method);
	form.setAttribute("action", action);
	
	return form;
}

function createInput(id, type, value) {
	var field = document.createElement("input");
	field.setAttribute("id", id);
	field.setAttribute("name", id);
	field.setAttribute("type", type);
	field.setAttribute("value", value);
	
	return field;
}

function checkNodeUndefined(node) {
	if(node == undefined) {
		return "";
	}
	return node.nodeValue;
}


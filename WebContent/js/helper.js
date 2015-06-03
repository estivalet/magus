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

/**
 * Move selected elements from one combo box to another.
 * 
 * Syntax: selectMoveRows(<source select box>,<destination select box>);
 * Example: selectMoveRows(document.Example.Features,document.Example.FeatureCodes);
 * 
 * http://www.johnwbartlett.com/cf_tipsntricks/index.cfm?topicid=86
 * @param SS1
 * @param SS2
 */
function selectMoveRows(SS1,SS2, remove, sort, sortStartIndex) {
    var SelID='';
    var SelText='';
    var index = 0;
    // Move rows from SS1 to SS2 from bottom to top
    for (i=SS1.options.length - 1; i>=index; i--) {
        if (SS1.options[i].selected == true) {
            SelID=SS1.options[i].value;
            SelText=SS1.options[i].text;
            var newRow = new Option(SelText,SelID);
            SS2.options[SS2.length]=newRow;
            // Check if you want to remove option from source combo.
            if(remove) {
            	SS1.options[i]=null;
            }
        }
    }
    if(sort) {
    	selectSort(SS2,sortStartIndex);
    }
}

/**
 * http://www.johnwbartlett.com/cf_tipsntricks/index.cfm?topicid=86
 * @param SelList
 */
function selectSort(SelList,sortStartIndex) {
	if(!sortStartIndex) {
		sortStartIndex = 0;
	}
    var ID='';
    var Text='';
    for (x=sortStartIndex; x < SelList.length - 1; x++) {
        for (y=x + 1; y < SelList.length; y++) {
            if (SelList[x].text > SelList[y].text) {
                // Swap rows
                ID=SelList[x].value;
                Text=SelList[x].text;
                SelList[x].value=SelList[y].value;
                SelList[x].text=SelList[y].text;
                SelList[y].value=ID;
                SelList[y].text=Text;
            }
        }
    }
}

function emptyCombo(comboId, defaultOption) {
	var select = document.getElementById(comboId);
	select.options.length = 0;
    var newRow = new Option(defaultOption,defaultOption);
    select.options[select.length]=newRow;
}


/**
 * Example: onclick="selectAll('selectbox-id',false)"
 * 
 * http://www.qodo.co.uk/blog/javascript-select-all-options-for-a-select-box/
 * @param selectBox
 * @param selectAll
 */
function selectAll(selectBox,selectAll) { 
    // have we been passed an ID 
    if (typeof selectBox == "string") { 
        selectBox = document.getElementById(selectBox);
    } 
    // is the select box a multiple select box? 
    if (selectBox.type == "select-multiple") { 
        for (var i = 0; i < selectBox.options.length; i++) { 
             selectBox.options[i].selected = selectAll; 
        } 
    }
}

function deleteTableRows(tableId, firstRow) {
	if(firstRow) {
		j = -1;
	} else {
		j = 0;
	}
    var table = document.getElementById(tableId);
    for(var i = table.rows.length - 1; i > j; i--) {
    	table.deleteRow(i);
    }	
}

function createSelectOption(element, value, text, defaultValue) {
    var option = document.createElement("option");
    option.value=value;
    option.innerHTML=text;
    if(defaultValue == value) {
    	option.selected = true;
    }
    element.appendChild(option);
}

function getNodeValue(xml, node) {
	value = xml.getElementsByTagName(node)[0].firstChild;
	if(value == null) {
		return "";
	}
	return value.nodeValue;
}


if ( typeof String.prototype.startsWith != 'function' ) {
    String.prototype.startsWith = function( str ) {
      return str.length > 0 && this.substring( 0, str.length ) === str;
    }
  };

  if ( typeof String.prototype.endsWith != 'function' ) {
    String.prototype.endsWith = function( str ) {
      return str.length > 0 && this.substring( this.length - str.length, this.length ) === str;
    }
  };

  
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

	function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
	}

	function closeModal() {
		document.getElementById('modal').style.display = 'none';
		document.getElementById('fade').style.display = 'none';
	}

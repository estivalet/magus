<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<script src="js/fabric.js" type="text/javascript"></script>
<script type="text/javascript" src="js/helper.js"></script>
<script type="text/javascript" src="js/magus.js"></script>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.leanModal.js" type="text/javascript"></script>


<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/magus.css" rel="stylesheet" type="text/css" />

<script>
$(function () {
var canvas = new fabric.Canvas('c', { selection: false });
var grid = 10;

// create grid

for (var i = 0; i < (600 / grid); i++) {
  canvas.add(new fabric.Line([ i * grid, 0, i * grid, 600], { stroke: '#ccc', selectable: false }));
  canvas.add(new fabric.Line([ 0, i * grid, 600, i * grid], { stroke: '#ccc', selectable: false }))
}

// add objects

canvas.add(new fabric.Rect({ 
  left: 100, 
  top: 100, 
  width: 50, 
  height: 50, 
  fill: '#faa', 
  originX: 'left', 
  originY: 'top',
  centeredRotation: true
}));

canvas.add(new fabric.Circle({ 
  left: 300, 
  top: 300, 
  radius: 50, 
  fill: '#9f9', 
  originX: 'left', 
  originY: 'top',
  centeredRotation: true
}));

// snap to grid

canvas.on('object:moving', function(options) { 
  options.target.set({
    left: Math.round(options.target.left / grid) * grid,
    top: Math.round(options.target.top / grid) * grid
  });
});
  });
</script>
</head>
<body>
<%@include file="../header.jsp" %>
    <div id="content">

        <div class="left-column">
            bla
        </div>

        <div class="center-column">
<style>
#div1 {
    width: 350px;
    height: 70px;
    padding: 10px;
    border: 1px solid #aaaaaa;
}
</style>
<script>
function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("Text", ev.target.id);
}

function drop(ev) {
    var data = ev.dataTransfer.getData("Text");
    ev.target.appendChild(document.getElementById(data));
    ev.preventDefault();
}
</script>
</head>
<body>

<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
<br>
<input type="text" id="drag1" draggable="true" ondragstart="drag(event)">

<input type="text" id="drag2" draggable="true" ondragstart="drag(event)">

        
            <canvas id="c" style="border:1px solid black;" width="600" height="600"></canvas>
        </div>
    </div>
    
    <%@include file="../footer.jsp" %>
            
</body>
</html>
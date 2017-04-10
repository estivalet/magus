<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  <title>Fancytree - Example</title>

  <script src="jquery.js" type="text/javascript"></script>
  <script src="jquery-ui.custom.js" type="text/javascript"></script>

  <link href="ui.fancytree.css" rel="stylesheet" type="text/css">
  <script src="jquery.fancytree.js" type="text/javascript"></script>

  <!-- (Irrelevant source removed.) -->

  <script type="text/javascript">
    $(function(){
      // using default options
      $("#tree").fancytree({

             click: function(event, data) {
                // logEvent(event, data, ", targetType=" + data.targetType);
                 // return false to prevent default behavior (i.e. activation, ...)
                 //return false;
                 $("#tree").fancytree("getTree").activateKey(data.node.key);
                 var node = $("#tree").fancytree("getActiveNode");
                 if (node.children == null) {
                     var childNode = node.addChildren({
                         title: "Programatically addded nodes",
                         tooltip: "This folder and all child nodes were added programmatically.",
                         folder: true
                       });
                 }

                            
               }

          }

              );
    });
  </script>
</head>

<body class="example">

 
 
  <div id="tree">
    <ul id="treeData" style="display: none;">
      <li id="id1">Projects
    </ul>
  </div>
   
  <!-- 
  <div id="tree">
    <ul id="treeData" style="display: none;">
      <li id="id1" title="Look, a tool tip!">item1 with key and tooltip
      <li id="id2">item2
      <li id="id3" class="folder">Folder <em>with some</em> children
        <ul>
          <li id="id3.1">Sub-item 3.1
            <ul>
              <li id="id3.1.1">Sub-item 3.1.1
              <li id="id3.1.2">Sub-item 3.1.2
            </ul>
          <li id="id3.2">Sub-item 3.2
            <ul>
              <li id="id3.2.1">Sub-item 3.2.1
              <li id="id3.2.2">Sub-item 3.2.2
            </ul>
        </ul>
      <li id="id4" class="expanded">Document with some children (expanded on init)
        <ul>
          <li id="id4.1"  class="active focused">Sub-item 4.1 (active and focus on init)
            <ul>
              <li id="id4.1.1">Sub-item 4.1.1
              <li id="id4.1.2">Sub-item 4.1.2
            </ul>
          <li id="id4.2">Sub-item 4.2
            <ul>
              <li id="id4.2.1">Sub-item 4.2.1
              <li id="id4.2.2">Sub-item 4.2.2
            </ul>
        </ul>
    </ul>
  </div>
 -->
 
  <!-- (Irrelevant source removed.) -->
</body>
</html>
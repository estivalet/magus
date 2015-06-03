<link rel="stylesheet" href="css/tree.css" type="text/css" />
<script type="text/javascript" src="js/CollapsibleLists.js"></script>




<ul class="treeView">
        <li>
          Collapsible lists
          <ul id="newList" class="collapsibleList">
            <li>
              Actions
              <ul>
                <li>
                  Creation
                  <ul>
                    <li>apply()</li>
                    <li class="lastChild">applyTo(node)</li>
                  </ul>
                </li>
                <li class="lastChild">
                  Toggling
                  <ul>
                    <li>Expanding/opening</li>
                    <li class="lastChild">Collapsing/closing</li>
                  </ul>
                </li>
              </ul>
            </li>
            <li class="lastChild">
              Uses
              <ul>
                <li>Directory listings</li>
                <li>Tree views</li>
                <li class="lastChild">Outline views</li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
      
      <input type="button" value="add" onclick="add()"/>
      <input type="button" value="test" onclick="create()"/>
      


      <div id="newTree">
      </div>
      
      <script>
      //CollapsibleLists.apply();
      CollapsibleLists.applyTo(document.getElementById('newList'));
      </script>
      
<script>
function add() {
    var newList = document.getElementById("newList");

	var lis = newList.getElementsByTagName('li');
    for (var index = 0; index < lis.length; index ++){
        //lis[index].removeEventListener('mousedown', function e(){}); 
        //lis[index].removeEventListener('click', function e(){});
//        lis[index].onclick = function (e) {};
        lis[index].className = 'collapsibleListClosed';
      //  CollapsibleLists.toggle(lis[index]);
      CollapsibleLists.applyTo(document.getElementById('newList'));
    }
    //CollapsibleLists.applyTo(document.getElementById('newList'));

return;
    
    var li = document.createElement("li");
    li.className='lastChild';
    li.appendChild(document.createTextNode("Connection Name"));

    var ul = document.createElement("ul");
    var li1 = document.createElement("li");
    li1.className='lastChild';
    li1.appendChild(document.createTextNode("Test"));
    ul.appendChild(li1);

    li.appendChild(ul);
    
    newList.appendChild(li);


    CollapsibleLists.applyTo(document.getElementById('newList'));
}

function create() {
    var div = document.getElementById("newTree");

    var ul = document.createElement("ul");
    ul.className = 'treeView';
    var li = document.createElement("li");
    li.appendChild(document.createTextNode("Connection Name"));
    
    var ul1 = document.createElement("ul"); 
    ul1.className = 'collapsibleList';
    ul1.id = 'contents';
    var li1 = document.createElement("li");
    li1.className = "lastChild";
    li1.appendChild(document.createTextNode("Tables"));
    ul1.appendChild(li1);
    li.appendChild(ul1);        

    var ul11 = document.createElement("ul"); 
    var li11 = document.createElement("li");
    li11.className = "lastChild";
    li11.appendChild(document.createTextNode("Table 1"));
    ul11.appendChild(li11);
    li1.appendChild(ul11);        
    
    ul.appendChild(li);    
    div.appendChild(ul);

    CollapsibleLists.applyTo(document.getElementById('contents'));
}
</script>      
</body>      
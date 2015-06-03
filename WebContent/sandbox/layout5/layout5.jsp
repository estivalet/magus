
<style>
body {
 margin: 0px;
}

#header {
    background: url("images/header.png") repeat-x scroll 0 0 #0f508d;
    border-bottom: 1px solid #2a9fec;
    min-height: 100px;
    margin: 0px 0px 10px 0px;
}

#container {
    width:100%;
    text-align:center;
}

#left {
    float:left;
    width:100px;
    height: 20px;
    background: #ff0000;
}

#center {
    display: inline-block;
    margin:0 auto;
    width:100px;
    height: 20px;
    background: #00ff00;
}

#right {
    float:right;
    width:100px;
    height: 20px;
    background: #0000ff;
}


</style>

<link rel="stylesheet" href="css/datagrid/datagrid-silver.css" type="text/css" />
<!--  CHANGE CSS FILE HERE -->
<link rel="stylesheet" href="css/black-shadow.css" type="text/css" />


<div id="header">
    <div id="container">
      <div id="left"></div>
      <div id="center"></div>
      <div id="right"></div>
    </div>
    <div>menu</div>
</div>

<!-- CHANGE CLASS ACCORDING TO CSS FILE CHOSEN ABOVE -->
<div class="black-shadow">
    <h1>
        Sample Form
    </h1>
     <span>Please complete the form below. Mandatory fields marked *</span>
     
     
    <label> 
        <span>Text field :</span>
        <input id="name" type="text" name="name" placeholder="Your Full Name" />
    </label> 
    <label> 
        <span>Email field :</span> 
        <input id="email" type="email" name="email" placeholder="Valid Email Address" />
    </label> 
    <label> 
        <span>Password field :</span>
        <input type="password" id="password" placeholder="Password"/>
    </label> 
    <label>
        <span>Radio field :</span>
        <input type="radio" id="radio"/>radio 1<input type="radio" id="radio"/>radio 2<input type="radio" id="radio"/>radio 3
    </label>
    <label>
        <span>Check field :</span>
        <input type="checkbox" id="checkbox"/>check 1<input type="checkbox" id="checkbox"/>check 2<input type="checkbox" id="checkbox"/>check 3
    </label>
    <label>
        <span>Text area field :</span>
        <textarea id="message" name="message" placeholder="Your Message to Us"></textarea>
    </label>
    <label> 
        <span>Select field :</span>
        <select name="selection">
            <option value="Job Inquiry">Job Inquiry</option>
            <option value="General Question">General Question</option>
        </select>
    </label> 
    <label> 
        <span>&nbsp;</span>
        <input type="button" class="button" value="Send" />
    </label>
</div>

<p>&nbsp;</p>

<div class="black-shadow">
    <h1>
        Sample List
    </h1>

    <div class="datagrid">
        <table>
            <thead>
                <tr>
                    <th>header</th>
                    <th>header</th>
                    <th>header</th>
                    <th>header</th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <td colspan="4"><div id="paging">
                            <ul>
                                <li><a href="#"><span>Previous</span></a></li>
                                <li><a href="#" class="active"><span>1</span></a></li>
                                <li><a href="#"><span>2</span></a></li>
                                <li><a href="#"><span>3</span></a></li>
                                <li><a href="#"><span>4</span></a></li>
                                <li><a href="#"><span>5</span></a></li>
                                <li><a href="#"><span>Next</span></a></li>
                            </ul>
                        </div>
                </tr>
            </tfoot>
            <tbody>
                <tr>
                    <td>data</td>
                    <td>data</td>
                    <td>data</td>
                    <td><img src="images/icon-edit.gif" />edit <img src="images/icon-delete.gif" />delete</td>
                </tr>
                <tr class="alt">
                    <td>data</td>
                    <td>data</td>
                    <td>data</td>
                    <td><img src="images/icon-edit.gif" />edit <img src="images/icon-delete.gif" />delete</td>
                </tr>
                <tr>
                    <td>data</td>
                    <td>data</td>
                    <td>data</td>
                    <td><img src="images/icon-edit.gif" />edit <img src="images/icon-delete.gif" />delete</td>
                </tr>
                <tr class="alt">
                    <td>data</td>
                    <td>data</td>
                    <td>data</td>
                    <td><img src="images/icon-edit.gif" />edit <img src="images/icon-delete.gif" />delete</td>
                </tr>
                <tr>
                    <td>data</td>
                    <td>data</td>
                    <td>data</td>
                    <td><img src="images/icon-edit.gif" />edit <img src="images/icon-delete.gif" />delete</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
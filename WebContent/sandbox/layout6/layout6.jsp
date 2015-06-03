<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="cs" xml:lang="cs" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="content-type">

<link rel="stylesheet" href="css/boxie-blue/boxie-blue.css" type="text/css" />


<style>
#cssmenu,
#cssmenu ul,
#cssmenu li,
#cssmenu a {
  border: none;
  line-height: 1;
  margin: 0;
  padding: 0;
}
#cssmenu {
  height: 37px;
  display: block;
  border: 1px solid;
  border-radius: 5px;
  width: auto;
  border-color: #080808;
  margin: 0;
  padding: 0;
}
#cssmenu > ul {
  list-style: inside none;
  margin: 0;
  padding: 0;
}
#cssmenu > ul > li {
  list-style: inside none;
  float: left;
  display: inline-block;
  position: relative;
  margin: 0;
  padding: 0;
}
#cssmenu.align-center > ul {
  text-align: center;
}
#cssmenu.align-center > ul > li {
  float: none;
  margin-left: -3px;
}
#cssmenu.align-center ul ul {
  text-align: left;
}
#cssmenu.align-center > ul > li:first-child > a {
  border-radius: 0;
}
#cssmenu > ul > li > a {
  outline: none;
  display: block;
  position: relative;
  text-align: center;
  text-decoration: none;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.4);
  font-weight: 700;
  font-size: 13px;
  font-family: Arial, Helvetica, sans-serif;
  border-right: 1px solid #080808;
  color: #ffffff;
  padding: 12px 20px;
}
#cssmenu > ul > li:first-child > a {
  border-radius: 5px 0 0 5px;
}
#cssmenu > ul > li > a:after {
  content: "";
  position: absolute;
  border-right: 1px solid;
  top: -1px;
  bottom: -1px;
  right: -2px;
  z-index: 99;
  border-color: #3c3c3c;
}

#cssmenu ul li.has-sub:hover > a:after {
  top: 0;
  bottom: 0;
}

#cssmenu > ul > li.has-sub > a:before {
  content: "";
  position: absolute;
  top: 18px;
  right: 6px;
  border: 5px solid transparent;
  border-top: 5px solid #ffffff;
}
#cssmenu > ul > li.has-sub:hover > a:before {
  top: 19px;
}
#cssmenu > ul > li.has-sub:hover > a {
  padding-bottom: 14px;
  z-index: 999;
  border-color: #3f3f3f;
}
#cssmenu ul li.has-sub:hover > ul,
#cssmenu ul li.has-sub:hover > div {
  display: block;
}
#cssmenu > ul > li.has-sub > a:hover,
#cssmenu > ul > li.has-sub:hover > a {
  background: #3f3f3f;
  border-color: #3f3f3f;
}
#cssmenu ul li > ul,
#cssmenu ul li > div {
  display: none;
  width: auto;
  position: absolute;
  top: 38px;
  background: #3f3f3f;
  border-radius: 0 0 5px 5px;
  z-index: 999;
  padding: 10px 0;
}
#cssmenu ul li > ul {
  width: 200px;
}
#cssmenu ul ul ul {
  position: absolute;
}
#cssmenu ul ul li:hover > ul {
  left: 100%;
  top: -10px;
  border-radius: 5px;
}
#cssmenu ul li > ul li {
  display: block;
  list-style: inside none;
  position: relative;
  margin: 0;
  padding: 0;
}
#cssmenu ul li > ul li a {
  outline: none;
  display: block;
  position: relative;
  font: 10pt Arial, Helvetica, sans-serif;
  color: #ffffff;
  text-decoration: none;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.5);
  margin: 0;
  padding: 8px 20px;
}
#cssmenu,
#cssmenu ul ul > li:hover > a,
#cssmenu ul ul li a:hover {
  background: #3c3c3c;
  background: -moz-linear-gradient(top, #3c3c3c 0%, #222222 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #3c3c3c), color-stop(100%, #222222));
  background: -webkit-linear-gradient(top, #3c3c3c 0%, #222222 100%);
  background: -o-linear-gradient(top, #3c3c3c 0%, #222222 100%);
  background: -ms-linear-gradient(top, #3c3c3c 0%, #222222 100%);
  background: linear-gradient(top, #3c3c3c 0%, #222222 100%);
}
#cssmenu > ul > li > a:hover {
  background: #080808;
  color: #ffffff;
}
#cssmenu ul ul a:hover {
  color: #ffffff;
}
#cssmenu > ul > li.has-sub > a:hover:before {
  border-top: 5px solid #ffffff;
}
#cssmenu li > a:after { 
content: '>';
} 
#cssmenu li > a:only-child:after { content: ''; }  



</style>                


</head>






















<div id="nav">

            <div class="inner-container clearfix">
                <form action="" method="post"><!-- Search form -->
                    <fieldset>
                        <label class="a-hidden" for="search-q">Search query:</label>
                        <input style="color: rgb(153, 153, 153);" id="search-q" class="text fl" name="search-q" size="20" value="search..." type="text">
                        <input class="hand fr" src="css/boxie-blue/search-button.png" alt="Search" type="image">
                    </fieldset>
                </form>
            </div><!-- .inner-container -->
        </div>
        
        
<div id='cssmenu'>
<ul>
   <li><a href='#'><span>Home</span></a></li>
   <li class='has-sub'><a href='#'><span>Products</span></a>
      <ul>
         <li class='has-sub'><a href='#'><span>Product 1</span></a>
            <ul>
               <li><a href='#'><span>Sub Product</span></a></li>
               <li class='last'><a href='#'><span>Sub Product</span></a></li>
            </ul>
         </li>
         <li class='has-sub'><a href='#'><span>Product 2</span></a>
            <ul>
               <li><a href='#'><span>Sub Product</span></a></li>
               <li class='last'><a href='#'><span>Sub Product</span></a></li>
            </ul>
         </li>
      </ul>
   </li>
   <li><a href='#'><span>About</span></a></li>
   <li class='last'><a href='#'><span>Contact</span></a></li>
</ul>
</div>

<p>&nbsp;</p>        

<div>

<div class="box box-50">
<div class="boxin">

                        <div class="header">
                            <h3>Forms, basic layout</h3>
                        </div>
                        <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                            <div class="inner-form">
                                <!-- error and information messages -->
                                <div class="msg msg-ok"><p>I'm a <strong>success</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-error"><p>I'm an <strong>error</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-warn"><p>I'm a <strong>warning</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-info"><p>I'm an <strong>info</strong> message and I'm proud of it!</p></div>
                                    <dl>
                                        <dt><label for="some1">Input field:</label></dt>
                                        <dd>
                                            <input class="txt" id="some1" name="some1" type="text">
                                            <small>A little description.</small>
                                        </dd>
                                    
                                        <dt><label class="error" for="some3">Input field:</label></dt>
                                        <dd>
                                            <input class="txt error" id="some3" name="some3" value="error" type="text"><!-- class error for wrong filled inputs -->
                                            <small>An error description.</small>
                                        </dd>
                                    
                                        <dt class="ttop"><label for="some2">Textarea:</label></dt><!-- .ttop for vertical-align: top -->
                                        <dd><textarea name="some2" id="some2" cols="20" rows="5"></textarea></dd>
                                    
                                        <dt><label for="some4">File input:</label></dt>
                                        <dd>
                                            <input class="file" id="some4" name="some4" type="file">
                                            <span class="loading">uploading...</span><!-- OR <img src="css/img/upload.gif" alt="" /> --><!-- uploading animation -->
                                        </dd>
                                    
                                        <dt><label for="some10">Select box:</label></dt>
                                        <dd>
                                            <select id="some10" name="some10">
                                                <option value="val1">select ...</option>
                                                <option value="val1">... something</option>
                                            </select>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <label class="check"><input class="check" id="some5" name="some5" value="true" checked="checked" type="checkbox">Checkbox 1</label>
                                            <label class="check"><input class="check" id="some6" name="some6" value="true" type="checkbox">Checkbox 2</label>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <label class="radio"><input class="radio" id="some7" name="some78" value="true" type="radio">Radio 1</label>
                                            <label class="radio"><input class="radio" id="some8" name="some78" value="true" type="radio">Radio 2</label>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <input class="button" value="Submit emphasized" type="submit">
                                            <input class="button altbutton" value="Submit" type="submit">
                                        </dd>
                                    </dl>
                            </div>
                        </form>
                    </div>
</div>




<div class="box box-50  altbox">
                    <div class="boxin">
                        <div class="header">
                            <h3>Forms with fieldsets, plain layout</h3>
                        </div>
                        <form class="fields" action="" method="post" enctype="multipart/form-data"><!-- Forms (plain layout, cleaner) -->
                            <fieldset class="last">
                                <legend><strong>Legend</strong></legend>
                                <div class="msg msg-ok">
                                    <p>I'm a <strong>success</strong> message and I'm proud of it!</p>
                                </div>
                                <label for="some21">Input field:</label>
                                <input class="txt" id="some21" name="some21" size="30" type="text">
                                <small>A little description.</small>
                                    
                                <label class="error" for="some23">Input field:</label>
                                <input class="txt error" id="some23" name="some23" size="30" value="error" type="text">
                                <small>An error description.</small>
                                
                                <label for="some22">Textarea:</label>
                                <textarea name="some22" id="some22" cols="40" rows="5"></textarea>
                                
                                <label for="some24">File input:</label>
                                <input class="file" id="some24" name="some24" type="file"> <span class="loading">uploading...</span><!-- OR <img src="css/img/upload.gif" alt="" /> -->
                                    
                                <label for="some210">Select box:</label>
                                <select id="some210" name="some210">
                                    <option value="val1">select ...</option>
                                    <option value="val1">... something</option>
                                </select>
                                
                                <div class="sep">
                                    <label class="check"><input class="check" id="some25" name="some25" value="true" checked="checked" type="checkbox">Checkbox 1</label>
                                    <label class="check"><input class="check" id="some26" name="some26" value="true" type="checkbox">Checkbox 2</label>
                                </div>
                                
                                <div class="sep">
                                    <label class="radio"><input class="radio" id="some27" name="some278" value="true" type="radio">Radio 1</label>
                                    <label class="radio"><input class="radio" id="some28" name="some278" value="true" type="radio">Radio 2</label>
                                </div>                                  
                                
                                <div class="sep">
                                    <input class="button" value="Submit" type="submit">
                                    <input class="button altbutton" value="Submit emphasized" type="submit">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>








<div id="box1" class="box box-100">

<!-- box full-width -->
                    <div class="boxin">
                        <div class="header">
                            <h3>Tabular data (eg. files) - TABS ARE WORKING</h3>
                            <a class="button" href="#">upload file&nbsp;»</a>
                            <ul>
                                <li><a rel="box1-tabular" href="#" class="active">list view</a></li><!-- insert ID of content related to this tab into the rel attribute of this tab -->
                                <li><a rel="box1-grid" href="#">grid view</a></li><!-- insert ID of content related to this tab into the rel attribute of this tab -->
                            </ul>
                        </div>
                        <div id="box1-tabular" class="content"><!-- content box 1 for tab switching -->
                            <form class="plain" action="" method="post" enctype="multipart/form-data">
                                <fieldset>
                                    <table cellspacing="0">
                                        <thead><!-- universal table heading -->
                                            <tr>
                                                <td class="tc first"><input id="data-1-check-all" name="data-1-check-all" value="true" type="checkbox"></td>
                                                <td class="tc">Type</td>
                                                <th>File</th>
                                                <td>Description</td>
                                                <td class="tc">Pub. date</td>
                                                <td class="tc last">Actions</td>
                                            </tr>
                                        </thead>
                                        <tfoot><!-- table foot - what to do with selected items -->
                                            <tr>
                                                <td class="first last" colspan="6"><!-- do not forget to set appropriate colspan if you will edit this table -->
                                                    <label>
                                                        with selected do:
                                                        <select name="data-1-groupaction">
                                                            <option value="delete">delete</option>
                                                            <option value="edit">edit</option>
                                                        </select>
                                                    </label>
                                                    <input class="button altbutton" value="OK" type="submit">
                                                </td>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <tr class="first"><!-- .first for first row of the table (only if there is thead) -->
                                                <td class="tc first"><input id="data-1-check-1" name="data-1-check-1" value="true" type="checkbox"></td>
                                                <td class="tc"><span class="tag tag-gray">jpeg</span></td>
                                                <th><a href="#">On vacation with my 13.3 honey</a></th>
                                                <td>Lovely picture of me and my MacBook during sunset ...</td>
                                                <td class="tc">715&nbsp;KB</td>
                                                <td class="tc last"><!-- action icons - feel free to add/modify your own - icons are located in "*" -->
                                                    <ul class="actions">
                                                        <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                        <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr class="even">
                                                <td class="tc first"><input id="data-1-check-2" name="data-1-check-2" value="true" type="checkbox"></td>
                                                <td class="tc"><span class="tag tag-gray">jpeg</span></td>
                                                <th><a href="#">On vacation with my 13.3 honey</a></th>
                                                <td>Lovely picture of me and my MacBook during sunset ...</td>
                                                <td class="tc">715&nbsp;KB</td>
                                                <td class="tc last">
                                                    <ul class="actions">
                                                        <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                        <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tc first"><input id="data-1-check-3" name="data-1-check-3" value="true" type="checkbox"></td>
                                                <td class="tc"><span class="tag tag-gray">jpeg</span></td>
                                                <th><a href="#">On vacation with my 13.3 honey</a></th>
                                                <td>Lovely picture of me and my MacBook during sunset ...</td>
                                                <td class="tc">715&nbsp;KB</td>
                                                <td class="tc last">
                                                    <ul class="actions">
                                                        <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                        <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr class="even">
                                                <td class="tc first"><input id="data-1-check-4" name="data-1-check-4" value="true" type="checkbox"></td>
                                                <td class="tc"><span class="tag tag-gray">jpeg</span></td>
                                                <th><a href="#">On vacation with my 13.3 honey</a></th>
                                                <td>Lovely picture of me and my MacBook during sunset ...</td>
                                                <td class="tc">715&nbsp;KB</td>
                                                <td class="tc last">
                                                    <ul class="actions">
                                                        <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                        <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                            </form>
                            <div class="pagination"><!-- pagination underneath the box's content -->
                                <ul>
                                    <li><a href="#">previous</a></li>
                                    <li><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><strong>3</strong></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">5</a></li>
                                    <li><a href="#">next</a></li>
                                </ul>
                            </div>
                        </div><!-- .content#box-1-holder -->
                        <!-- code bellow is only example for switching between tabs, not regular content -->
                        <div style="display: none;" id="box1-grid" class="content"><!-- content box 2 for tabs switching (hidden by default) -->
                            <form class="plain" action="" method="post" enctype="multipart/form-data">
                                <fieldset>
                                    <div class="grid"><!-- grid view -->
                                        <div class="line even firstline">
                                            <div class="item">
                                                <div class="inner">
                                                    <a class="thumb" href="#"></a>
                                                    <div class="data">
                                                        <h4><span class="tag tag-gray">jpeg</span> <a href="#">On vacation with my 13.3 honey</a></h4>
                                                        <p>Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ...</p>
                                                        <p>Lovely picture of me and my MacBook during sunset ...</p>
                                                        <div class="meta">715&nbsp;KB, 1920×1200</div>
                                                        <ul class="actions">
                                                            <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                            <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item">
                                                <div class="inner">
                                                    <a class="thumb" href="#"></a>
                                                    <div class="data">
                                                        <h4><span class="tag tag-gray">jpeg</span> <a href="#">On vacation with my 13.3 honey</a></h4>
                                                        <p>Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset</p>
                                                        <p>Lovely picture of me and my MacBook during sunset ...</p>
                                                        <div class="meta">715&nbsp;KB, 1920×1200</div>
                                                        <ul class="actions">
                                                            <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                            <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="line lastline">
                                            <div class="item">
                                                <div class="inner">
                                                    <a class="thumb" href="#"></a>
                                                    <div class="data">
                                                        <h4><span class="tag tag-gray">jpeg</span> <a href="#">On vacation with my 13.3 honey</a></h4>
                                                        <p>Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ...</p>
                                                        <p>Lovely picture of me and my MacBook during sunset ...</p>
                                                        <div class="meta">715&nbsp;KB, 1920×1200</div>
                                                        <ul class="actions">
                                                            <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                            <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item">
                                                <div class="inner">
                                                    <a class="thumb" href="#"></a>
                                                    <div class="data">
                                                        <h4><span class="tag tag-gray">jpeg</span> <a href="#">On vacation with my 13.3 honey</a></h4>
                                                        <p>Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ... Lovely picture of me and my MacBook during sunset ...</p>
                                                        <p>Lovely picture of me and my MacBook during sunset ...</p>
                                                        <div class="meta">715&nbsp;KB, 1920×1200</div>
                                                        <ul class="actions">
                                                            <li><a class="ico" href="#" title="edit"><img src="css/boxie-blue/pencil.png" alt="edit"></a></li>
                                                            <li><a class="ico" href="#" title="delete"><img src="css/boxie-blue/delete.png" alt="delete"></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>      
                                    </div>
                                </fieldset>
                            </form>
                            <div class="pagination">
                                <ul>
                                    <li><a href="#">previous</a></li>
                                    <li><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><strong>3</strong></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">5</a></li>
                                    <li><a href="#">next</a></li>
                                </ul>
                            </div>
                        </div><!-- .content#box-1-grid -->
                    </div>
                </div>

</div>


                
                

   
</html>    
                

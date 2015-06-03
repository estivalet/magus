<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>


<link rel="stylesheet" href="css/boxie-blue/boxie-blue.css" type="text/css" />
</head>


<body style="cursor: auto;">
<div class="container">

<div class="top_header">
    <div class="header_logo">
      <a href="#"><img src="images/logo.jpg" alt="Logo" class="logo" height="122" width="677"></a>
      <div class="right">
        <ul class="dark">
          <li class="first"><a href="#">My account</a></li>
          <li><a href="#">Settings</a></li>
          <li><a href="#">Contact us</a></li>
        </ul>
        <div class="clr"></div>
        <ul class="light">
          <li class="first"><a href="#"><img src="images/icon_email.gif" alt="picture" class="email" height="10" width="14"></a><a href="#">37</a> incoming messages</li>
          <li><a href="#"><img src="images/icon_logout.gif" alt="picture" class="logout" height="16" width="16"></a><a href="#">logout</a></li>
        </ul>
        <p>Logged in as <a href="#">User Name</a></p>
      </div>
      <div class="clr"></div>
    </div>
    
    <div class="menu">
      <div class="rightblock"><div><div>
        <a href="#dialog1" name="modal"><span><span><img src="images/pimpa_check.gif" alt="picture" height="16" width="16"> Dialog Box</span></span></a>
        <a href="#dialog2" name="modal"><span><span><img src="images/pimpa_plus.gif" alt="picture" height="16" width="16"> Login Box</span></span></a>
      </div></div></div>
      <ul>
        <li class="first"><a href="index.html" class="active"><span><span><span>Home</span></span></span></a></li>
        <li><a href="forms.html"><span><span><span>Admin Dashboard <img src="images/dropdown_arrow.gif" alt="picture" height="7" width="8"></span></span></span></a>
          <ul>
            <li class="active"><a href="#">Navigation Example 1</a>
              <ul>
                <li><a href="#">Everybody lies 1-1</a></li>
                <li><a href="#">Everybody lies 1-2</a></li>
                <li><a href="#">Everybody lies 1-3</a></li>
                <li><a href="#">Everybody lies 1-4</a></li>
              </ul>
            </li>
            <li><a href="#">Navigation Example 2</a></li>
            <li><a href="#">Navigation Example 3</a></li>
            <li class="active"><a href="#">Navigation Example 4</a>
              <ul>
                <li><a href="#">Everybody lies 4-1</a></li>
                <li><a href="#">Everybody lies 4-2</a></li>
                <li><a href="#">Everybody lies 4-3</a></li>
                <li><a href="#">Everybody lies 4-4</a></li>
              </ul>
            </li>
            <li><a href="#">Navigation Example 5</a></li>
            <li><a href="#">Navigation Example 6</a></li>
          </ul>
        </li>
        <li><a href="messages.html"><span><span><span>Layout Dashboard</span></span></span></a></li>
        <li><a href="tables.html"><span><span><span>Components</span></span></span></a></li>
      </ul>
      <div class="clr"></div>
    </div>
  </div>
  

  <div class="content">
    <div class="content_res">
    
    
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
    
    
    <p>&nbsp;</p>
    
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

<p>&nbsp;</p>

<div id="box1" class="box box-100">

<!-- box full-width -->
                    <div class="boxin">
                        <div class="header">
                            <h3>Tabular data (eg. files) - TABS ARE WORKING</h3>
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
                    </div>
                </div>

<p>&nbsp;</p>


</div>
    
    
    </div>

  
  <div class="footer">
    <div class="bgr">
      <img src="images/footer_bg_left.jpg" alt="Logo" class="logo" height="99" width="430"/>
      <div class="f_right">
        <ul>
          <li class="first"><a href="index.html">Home</a></li>
          <li><a href="">Administration</a></li>
          <li><a href="">Settings</a></li>
          <li><a href="">Contact</a></li>
        </ul>
        <div class="clr"></div>
        <p><a href="http://www.dreamtemplate.com"><img src="images/footer_icon.gif" alt="picture" height="23" width="27"></a>Website Administration by <a href="http://www.webappskins.com"><span>WebAppSkins</span></a></p>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  
  
</div>
</body>  
</html>
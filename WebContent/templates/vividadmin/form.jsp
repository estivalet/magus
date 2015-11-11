<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background: #f0f0f0;">
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
<script type="text/javascript" src="js/jquery-1.4.1.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/js.js"></script>
<script type="text/javascript" src="js/clock.js"></script>

<title>Forms</title>

<link href="css/vividadmin/style.css" rel="stylesheet" type="text/css">

<style>
#cssmenu ul,
#cssmenu li,
#cssmenu span,
#cssmenu a {
  margin: 0;
  padding: 0;
  position: relative;
}
#cssmenu {
  line-height: 1;
  border-radius: 5px 5px 0 0;
  -moz-border-radius: 5px 5px 0 0;
  -webkit-border-radius: 5px 5px 0 0;
  background: #141414;
  background: -moz-linear-gradient(top, #333333 0%, #141414 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #333333), color-stop(100%, #141414));
  background: -webkit-linear-gradient(top, #333333 0%, #141414 100%);
  background: -o-linear-gradient(top, #333333 0%, #141414 100%);
  background: -ms-linear-gradient(top, #333333 0%, #141414 100%);
  background: linear-gradient(to bottom, #333333 0%, #141414 100%);
  border-bottom: 2px solid #0fa1e0;
  width: auto;
}
#cssmenu:after,
#cssmenu ul:after {
  content: '';
  display: block;
  clear: both;
}
#cssmenu a {
  background: #141414;
  background: -moz-linear-gradient(top, #333333 0%, #141414 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #333333), color-stop(100%, #141414));
  background: -webkit-linear-gradient(top, #333333 0%, #141414 100%);
  background: -o-linear-gradient(top, #333333 0%, #141414 100%);
  background: -ms-linear-gradient(top, #333333 0%, #141414 100%);
  background: linear-gradient(to bottom, #333333 0%, #141414 100%);
  color: #ffffff;
  display: block;
  font-family: Helvetica, Arial, Verdana, sans-serif;
  padding: 19px 20px;
  text-decoration: none;
}
#cssmenu ul {
  list-style: none;
}
#cssmenu > ul > li {
  display: inline-block;
  float: left;
  margin: 0;
}
#cssmenu.align-center {
  text-align: center;
}
#cssmenu.align-center > ul > li {
  float: none;
}
#cssmenu.align-center ul ul {
  text-align: left;
}
#cssmenu.align-right > ul {
  float: right;
}
#cssmenu.align-right ul ul {
  text-align: right;
}
#cssmenu > ul > li > a {
  color: #ffffff;
  font-size: 12px;
}
#cssmenu > ul > li:hover:after {
  content: '';
  display: block;
  width: 0;
  height: 0;
  position: absolute;
  left: 50%;
  bottom: 0;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 10px solid #0fa1e0;
  margin-left: -10px;
}
#cssmenu > ul > li:first-child > a {
  border-radius: 5px 0 0 0;
  -moz-border-radius: 5px 0 0 0;
  -webkit-border-radius: 5px 0 0 0;
}
#cssmenu.align-right > ul > li:first-child > a,
#cssmenu.align-center > ul > li:first-child > a {
  border-radius: 0;
  -moz-border-radius: 0;
  -webkit-border-radius: 0;
}
#cssmenu.align-right > ul > li:last-child > a {
  border-radius: 0 5px 0 0;
  -moz-border-radius: 0 5px 0 0;
  -webkit-border-radius: 0 5px 0 0;
}
#cssmenu > ul > li.active > a,
#cssmenu > ul > li:hover > a {
  color: #ffffff;
  box-shadow: inset 0 0 3px #000000;
  -moz-box-shadow: inset 0 0 3px #000000;
  -webkit-box-shadow: inset 0 0 3px #000000;
  background: #070707;
  background: -moz-linear-gradient(top, #262626 0%, #070707 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #262626), color-stop(100%, #070707));
  background: -webkit-linear-gradient(top, #262626 0%, #070707 100%);
  background: -o-linear-gradient(top, #262626 0%, #070707 100%);
  background: -ms-linear-gradient(top, #262626 0%, #070707 100%);
  background: linear-gradient(to bottom, #262626 0%, #070707 100%);
}
#cssmenu .has-sub {
  z-index: 1;
}
#cssmenu .has-sub:hover > ul {
  display: block;
}
#cssmenu .has-sub ul {
  display: none;
  position: absolute;
  width: 200px;
  top: 100%;
  left: 0;
}
#cssmenu.align-right .has-sub ul {
  left: auto;
  right: 0;
}
#cssmenu .has-sub ul li {
  *margin-bottom: -1px;
}
#cssmenu .has-sub ul li a {
  background: #0fa1e0;
  border-bottom: 1px dotted #31b7f1;
  font-size: 11px;
  filter: none;
  display: block;
  line-height: 120%;
  padding: 10px;
  color: #ffffff;
}
#cssmenu .has-sub ul li:hover a {
  background: #0c7fb0;
}
#cssmenu ul ul li:hover > a {
  color: #ffffff;
}
#cssmenu .has-sub .has-sub:hover > ul {
  display: block;
}
#cssmenu .has-sub .has-sub ul {
  display: none;
  position: absolute;
  left: 100%;
  top: 0;
}
#cssmenu.align-right .has-sub .has-sub ul,
#cssmenu.align-right ul ul ul {
  left: auto;
  right: 100%;
}
#cssmenu .has-sub .has-sub ul li a {
  background: #0c7fb0;
  border-bottom: 1px dotted #31b7f1;
}
#cssmenu .has-sub .has-sub ul li a:hover {
  background: #0a6d98;
}
#cssmenu ul ul li.last > a,
#cssmenu ul ul li:last-child > a,
#cssmenu ul ul ul li.last > a,
#cssmenu ul ul ul li:last-child > a,
#cssmenu .has-sub ul li:last-child > a,
#cssmenu .has-sub ul li.last > a {
  border-bottom: 0;
}

.top_header { color:#a4c5ee; background:#335c91 url(header_bg_right.jpg) no-repeat top right; min-width:1220px;

  background: #141414;
  background: -moz-linear-gradient(top, #333333 0%, #141414 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #333333), color-stop(100%, #141414));
  background: -webkit-linear-gradient(top, #333333 0%, #141414 100%);
  background: -o-linear-gradient(top, #333333 0%, #141414 100%);
  background: -ms-linear-gradient(top, #333333 0%, #141414 100%);
  background: linear-gradient(to bottom, #333333 0%, #141414 100%);

}
.top_header img.logo { float:left; border:none;}
.top_header .right { padding-right:36px; float:right; width:600px; }
.top_header .right a { color:#fff;}
.top_header .right p { margin-top:17px; padding:8px 16px; float:right;}
.top_header .right .dark { background-color:#295287;}
.top_header .right .light { background-color:#355e93; border:1px solid #43699a;}
.top_header .right ul { margin:16px 0 0 0; padding:8px 4px; float:right; list-style:none;}
.top_header .right ul li { padding:0 12px; float:left; border-left:1px solid #a4c5ee;}
.top_header .right ul li.first { border-left:none;}
.top_header .right img { margin:0 12px 0 0; border:none;}
.top_header .right img.logout { margin-top:-4px; margin-bottom:-4px;}
.top_header .menu {padding-right:36px; margin:0; background:url(menu_bg.gif) repeat-x top;}
.top_header .menu .rightblock { margin:0; padding:0; float:right; width:auto; background:url(menu_balloon.gif) repeat-x top;}
.top_header .menu .rightblock div { background:url(menu_balloon_left.gif) no-repeat top left;}
.top_header .menu .rightblock div div { padding:18px 6px 18px 6px; background:url(menu_balloon_right.gif) no-repeat top right; text-align:right;}
.top_header .menu .rightblock a { margin:0 2px; padding:5px 0; font-weight:bold; color:#335c91; text-decoration:none; background:url(button_white.gif) repeat-x top;}
.top_header .menu .rightblock a img { margin:-4px 4px -4px 0; padding:0; border:none;}
.top_header .menu .rightblock a span { padding:5px 0 5px 12px; background:url(button_white_left.gif) no-repeat top left;}
.top_header .menu .rightblock a span span { padding:5px 12px 5px 0; background:url(button_white_right.gif) no-repeat top right;}
.top_header .menu ul { margin:0 0 0 24px; padding:0; float:left; list-style:none;}
.top_header .menu ul li { margin:0; padding:0 0 0 2px; float:left; background:url(menu_split.gif) no-repeat right top;}
.top_header .menu ul li a { display:block; padding:0 12px; color:#fff; text-decoration:none;}
.top_header .menu ul li a img { margin:0 0 0 8px; border:none;}
.top_header .menu ul li a span { display:block;}
.top_header .menu ul li a span span { padding:0 0 0 16px;}
.top_header .menu ul li a span span span { padding:19px 16px 19px 0;}
.top_header .menu ul li a:hover span { background:url(menu_balloon.gif) repeat-x top; }
.top_header .menu ul li a:hover span span { background:url(menu_balloon_left.gif) no-repeat top left;}
.top_header .menu ul li a:hover span span span { background:url(menu_balloon_right.gif) no-repeat top right;}
.top_header .menu ul ul, .top_header .menu ul ul ul { margin:0; padding:0; list-style:none;}
.top_header .menu ul ul, .top_header .menu ul li:hover ul ul { display:none; position:absolute;}
.top_header .menu ul ul { margin:0 0 0 -4px; padding:0; width:178px; background-color:#2f5586;}
.top_header .menu ul ul ul { left:178px; margin:-30px 0 0 0; z-index:2;}
.top_header .menu ul li:hover ul, .top_header .menu ul li:hover li:hover ul { display:block;}
.top_header .menu ul ul li  { margin:1px 0 0 0; padding:0; float:none; background-color:#335c91; background-image:none; border-top:1px solid #416798; border-left:1px solid #416798; border-right:1px solid #305687; border-bottom:1px solid #305687;}
.top_header .menu ul ul li a { display:block; padding:8px 18px; color:#fff; background:url(li_square_white.gif) no-repeat 10px 16px;}
.top_header .menu ul ul li.active { background:#335c91 url(dropleft_arrow.gif) no-repeat 160px 13px; }

.footer { 

position:absolute;width:100%; background:#335c91 url(footer_bg.jpg) repeat-x top; 
position:absolute;
        
  background: #141414;
  background: -moz-linear-gradient(top, #333333 0%, #141414 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #333333), color-stop(100%, #141414));
  background: -webkit-linear-gradient(top, #333333 0%, #141414 100%);
  background: -o-linear-gradient(top, #333333 0%, #141414 100%);
  background: -ms-linear-gradient(top, #333333 0%, #141414 100%);
  background: linear-gradient(to bottom, #333333 0%, #141414 100%);
    
}
.footer .bgr { padding-right:24px; background:url(footer_bg_right.jpg) no-repeat top right;
  background: #141414;
  background: -moz-linear-gradient(top, #333333 0%, #141414 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #333333), color-stop(100%, #141414));
  background: -webkit-linear-gradient(top, #333333 0%, #141414 100%);
  background: -o-linear-gradient(top, #333333 0%, #141414 100%);
  background: -ms-linear-gradient(top, #333333 0%, #141414 100%);
  background: linear-gradient(to bottom, #333333 0%, #141414 100%);

}
.footer img.logo { float:left; border:none;}
.footer div.f_right { float:right; width:400px}
.footer a { color:#b8ddf9;}
.footer a span { font-weight:bold; color:#fff;}
.footer ul { margin:0; padding:20px 0 0 0; float:right; list-style:none;}
.footer ul li { float:left; border-left:1px solid #b7d1f1;}
.footer ul li.first { border-left:none;}
.footer ul li a { padding:0 12px;}
.footer p { margin:0; padding:32px 0 0 0; color:#b7d1f1; text-align:right;}
.footer p img { margin:-6px 8px; border:none;}


</style>


</head>
<body>
    <div class="container">

<div class="top_header">
    <div class="header_logo">
      <img src="images/logo3.png" alt="Logo" class="logo" height="122" style="padding:5px">
      <a href="#"><img src="images/logo2.jpg" alt="Logo" class="logo" height="122" width="300" style="padding:5px"></a>
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

<div id='cssmenu'>
<ul>
   <li><a href='#'><span>Home</span></a></li>
   <li class='active has-sub'><a href='#'><span>Products</span></a>
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



</div>





        <!--CONTENT -->
        <div class="content">
            <div class="content_res">
                <div class="content_block">

                    <div class="rightblock vertsortable ui-sortable">

                        <!--gadget right 2 -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/vividadmin/images/spacer.gif" height="35" width="19"></a>
                                <h3>Form Example 2</h3>
                            </div>
                            <div class="gadget_content">
                                <form action="" method="post" id="form_example" class="form_example">
                                    <ol>
                                        <li><label for="name"><strong>Name</strong> (Small input form example)</label> <input id="name" name="name"
                                            class="text medium"></li>
                                        <li><label for="address"><strong>Address</strong> (Large input form example)</label> <input id="address"
                                            name="address" class="text large"></li>
                                        <li><label for="descr"><strong>Description</strong> (Large input form example)</label> <textarea id="descr"
                                                name="descr" rows="6" cols="50"></textarea></li>
                                        <li><label for="multiply"><strong>Multiply</strong> (small input form example)</label> <input id="multiply"
                                            name="multiply" value="" type="hidden"> <input id="multiply1" name="multiply1" class="text small"> <input
                                            id="multiply2" name="multiply2" class="text small"> <input id="multiply3" name="multiply3"
                                            class="text small">
                                            <div class="clr"></div> <label for="multiply1" class="small">example</label> <label for="multiply2" class="small">example</label>
                                            <label for="multiply3" class="small">example</label>
                                            <div class="clr"></div></li>
                                        <li><label for="dropdown"><strong>Drop down box</strong></label> <select id="dropdown" name="dropdown">
                                                <option selected="selected" value="Standart Results">Example 1</option>
                                                <option value="Example 2">Example 2</option>
                                                <option value="Example 3">Example 3</option>
                                                <option value="Example 4">Example 4</option>
                                                <option value="Example 5">Example 5</option>
                                                <option value="Example 6">Example 6</option>
                                        </select></li>
                                        <li><label for="date"><strong>Date</strong></label> <input id="date" name="date" value="" type="hidden"> <input
                                            id="dateyear" name="dateyear" maxlength="4" class="text year"> / <input id="datemonth" name="datemonth"
                                            maxlength="2" class="text date"> / <input id="dateday" name="dateday" maxlength="2" class="text date">
                                            <div class="clr"></div> <label for="dateyear" class="year">YYYY</label> <label for="datemonth" class="date">MM</label>
                                            <label for="dateday" class="date">DD</label>
                                            <div class="clr"></div></li>
                                        <li><label for="check"><strong>Checkbox</strong></label> <input name="check" class="checkbox" type="checkbox">Lorem
                                            Ipsum is simply dummy text of the printing and typesetting industry.</li>
                                    </ol>
                                </form>
                                <p>
                                    <a href="#">Learn more »</a>
                                </p>
                            </div>
                        </div>

                        <!--gadget right 3 -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/vividadmin/images/spacer.gif" height="35" width="19"></a>
                                <h3>Administration Options</h3>
                            </div>
                            <div class="gadget_content">
                                <form action="" method="post" id="form_userstable">
                                    <table class="glines" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <th class="taleft" width="40"><input name="utc1" id="utc1" type="checkbox"></th>
                                                <th width="100">Name</th>
                                                <th width="100">Username</th>
                                                <th width="90">Date</th>
                                                <th width="120">Location</th>
                                                <th>E-mail</th>
                                                <th colspan="2">Actions</th>
                                            </tr>
                                            <tr>
                                                <td><input name="utc2" id="utc2" type="checkbox"></td>
                                                <td>John Smith</td>
                                                <td>jonnysmi</td>
                                                <td>12.24.1980</td>
                                                <td>San Francisco, CA</td>
                                                <td><a href="mailto:mwwweefail@yahoo.com">mwwweefail@yahoo.com</a></td>
                                                <td width="28"><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture"
                                                        class="tabpimpa" height="13" width="13"></a></td>
                                                <td width="28"><a href="#"><img src="css/vividadmin/images/pimpa_no.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                            </tr>
                                            <tr>
                                                <td><input name="utc3" id="utc3" type="checkbox"></td>
                                                <td>John Smith</td>
                                                <td>jonnysmi</td>
                                                <td>12.24.1980</td>
                                                <td>San Francisco, CA</td>
                                                <td><a href="mailto:mail@yahoo.com">mail@yahoo.com</a></td>
                                                <td><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                                <td><a href="#"><img src="css/vividadmin/images/pimpa_no.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                            </tr>
                                            <tr class="last">
                                                <td><input name="utc4" id="utc4" type="checkbox"></td>
                                                <td>John Smith</td>
                                                <td>jonnysmi</td>
                                                <td>12.24.1980</td>
                                                <td>San Francisco, CA</td>
                                                <td><a href="mailto:m13dail@yahoo.com">m13dail@yahoo.com</a></td>
                                                <td><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                                <td><a href="#"><img src="css/vividadmin/images/pimpa_no.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>

                            </div>
                        </div>

                    </div>
                    <div class="clr"></div>
                </div>
            </div>
        </div>


  <div class="footer">
      <div class="bgr">
      <img src="images/logo3.png" alt="Logo" class="logo" height="50" style="padding:10px"/>
      <div class="f_right">
        <ul>
          <li class="first"><a href="index.html">Home</a></li>
          <li><a href="">Administration</a></li>
          <li><a href="">Settings</a></li>
          <li><a href="">Contact</a></li>
        </ul>
        <div class="clr"></div>
        
      </div>
      <div class="clr"></div>
    </div>
  
  </div>

    </div>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>

<script type="text/javascript" src="js/jquery-1.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.js"></script>
<script type="text/javascript" src="js/clock.js"></script>
<script type="text/javascript" src="js/js.js"></script>

<style>

@charset "utf-8";
/* CSS Document */

/* main */
body, html { margin:0; padding:0; background-color:#fff;}
.clr { clear:both; padding:0; margin:0; width:100%; height:0; line-height:0px; font-size:0px; overflow:hidden;}
.container { margin:0; padding:0; width:100%; font:normal 12px/1.5em Arial, Helvetica, sans-serif; color:#3c3c3c;}
p { margin:0 0 16px 0; padding:0;}
a { color:#3c3c3c; text-decoration:underline;}
h2 { margin:0; padding:0; font:normal 30px/1.5em Arial, Helvetica, sans-serif;}
p.light { color:#999;}
p.nobottom { margin-bottom:0;}
p.bot8px { margin-bottom:8px;}
p.p_center { text-align:center;}
p.p_right { text-align:right;}
p.bigprice { margin:0 0 4px 0; font:normal 30px/1.2em Arial, Helvetica, sans-serif;}
p.timeclock { margin:0 0 4px 0; font:normal 30px/1.2em Arial, Helvetica, sans-serif; text-align:center;}
p.timeclock img { margin:-3px 4px -3px 0; border:none;}
.linehr { margin-bottom:16px; background:#d7d7d7 url(images/linehr.gif) repeat-x top; height:2px; line-height:0px; font-size:0px;}

/* header */
.header { color:#a4c5ee; background:#335c91 url(images/header_bg_right.jpg) no-repeat top right; min-width:1220px;}
.header img.logo { float:left; border:none;}
.header .right { padding-right:36px; float:right; width:500px; }
.header .right a { color:#fff;}
.header .right p { margin-top:17px; padding:8px 16px; float:right;}
.header .right .dark { background-color:#295287;}
.header .right .light { background-color:#355e93; border:1px solid #43699a;}
.header .right ul { margin:16px 0 0 0; padding:8px 4px; float:right; list-style:none;}
.header .right ul li { padding:0 12px; float:left; border-left:1px solid #a4c5ee;}
.header .right ul li.first { border-left:none;}
.header .right img { margin:0 12px 0 0; border:none;}
.header .right img.logout { margin-top:-4px; margin-bottom:-4px;}
.header .menu { padding-right:36px; margin:0; background:url(images/menu_bg.gif) repeat-x top;}
.header .menu .rightblock { margin:0; padding:0; float:right; width:auto; background:url(images/menu_balloon.gif) repeat-x top;}
.header .menu .rightblock div { background:url(images/menu_balloon_left.gif) no-repeat top left;}
.header .menu .rightblock div div { padding:18px 6px 18px 6px; background:url(images/menu_balloon_right.gif) no-repeat top right; text-align:right;}
.header .menu .rightblock a { margin:0 2px; padding:5px 0; font-weight:bold; color:#335c91; text-decoration:none; background:url(images/button_white.gif) repeat-x top;}
.header .menu .rightblock a img { margin:-4px 4px -4px 0; padding:0; border:none;}
.header .menu .rightblock a span { padding:5px 0 5px 12px; background:url(images/button_white_left.gif) no-repeat top left;}
.header .menu .rightblock a span span { padding:5px 12px 5px 0; background:url(images/button_white_right.gif) no-repeat top right;}
.header .menu ul { margin:0 0 0 24px; padding:0; float:left; list-style:none;}
.header .menu ul li { margin:0; padding:0 0 0 2px; float:left; background:url(images/menu_split.gif) no-repeat right top;}
.header .menu ul li a { display:block; padding:0 12px; color:#fff; text-decoration:none;}
.header .menu ul li a img { margin:0 0 0 8px; border:none;}
.header .menu ul li a span { display:block;}
.header .menu ul li a span span { padding:0 0 0 16px;}
.header .menu ul li a span span span { padding:19px 16px 19px 0;}
.header .menu ul li a:hover span { background:url(images/menu_balloon.gif) repeat-x top; }
.header .menu ul li a:hover span span { background:url(images/menu_balloon_left.gif) no-repeat top left;}
.header .menu ul li a:hover span span span { background:url(images/menu_balloon_right.gif) no-repeat top right;}
.header .menu ul ul, .header .menu ul ul ul { margin:0; padding:0; list-style:none;}
.header .menu ul ul, .header .menu ul li:hover ul ul { display:none; position:absolute;}
.header .menu ul ul { margin:0 0 0 -4px; padding:0; width:178px; background-color:#2f5586;}
.header .menu ul ul ul { left:178px; margin:-30px 0 0 0; z-index:2;}
.header .menu ul li:hover ul, .header .menu ul li:hover li:hover ul { display:block;}
.header .menu ul ul li  { margin:1px 0 0 0; padding:0; float:none; background-color:#335c91; background-image:none; border-top:1px solid #416798; border-left:1px solid #416798; border-right:1px solid #305687; border-bottom:1px solid #305687;}
.header .menu ul ul li a { display:block; padding:8px 18px; color:#fff; background:url(images/li_square_white.gif) no-repeat 10px 16px;}
.header .menu ul ul li.active { background:#335c91 url(images/dropleft_arrow.gif) no-repeat 160px 13px; }

/* footer */
.footer { position:absolute;width:100%;background:#335c91 url(images/footer_bg.jpg) repeat-x top; }
.footer .bgr { padding-right:24px; background:url(images/footer_bg_right.jpg) no-repeat top right;}
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

/* content */
.content { background:#fff url(images/content_bg.gif) repeat-x top;}
.content_res { margin:0 auto; padding:32px 0; width:1016px;}
.gadget { margin-bottom:12px;}
.leftblock { margin-right:10px; float:left; width:757px;}
.rightblock { width:249px; float:left;}
.gadget h3 { margin:8px 0 0 0; padding:8px 0; font:bold 12px/1.5em Arial, Helvetica, sans-serif;}
.gadget h3 img.calendar { margin:-6px 4px -6px 0; border:none;}
.gadget .titlebar { margin-bottom:2px; border:1px solid #cfcfcf;}
.gadget .titlebar h3 { margin:0; padding:8px 32px 7px 16px; font:bold 12px/1.5em Arial, Helvetica, sans-serif; background:#aaa url(images/dropdown_bg.gif) repeat-x top; border:1px solid #fff;}
.gadget .titlebar a { margin:1px 1px 0 0; float:right;}
.gadget .titlebar a img, .gadget .error a img { border:none;}
.gadget .titlebar a.hidegadget { background:#335c91 url(images/button_dropup_bl.gif) no-repeat center center;}
.gadget .titlebar a.closegadget { background:#335c91 url(images/button_close_bl.gif) no-repeat center center;}
.gadget .error_tit { margin-bottom:2px; padding:0;}
.gadget .error_tit h3 { margin:0 60px 0 0; padding:9px 0 10px 16px; font:bold 12px/1.5em Arial, Helvetica, sans-serif; color:#fff;}
.gadget .error_tit a.hideerr { margin:2px 2px 0 0; float:right;}
.gadget .error_tit a.closeerr { margin:2px 4px 0 0; float:right;}
.gadget .error_tit img { border:none;}
.gadget .error_msg { padding:16px; background-color:#fffbe0; border:1px solid #ff5e3b;}
.gadget .error_msg p { margin:0; padding:0; color:#3c3c3c;}
.gadget .error_msg a { font-weight:bold;}
.err_or .error_tit { background-color:#ff5e3b;}
.err_bl .error_tit { background-color:#335c91;}
.err_gr .error_tit { background-color:#9d9d9d;}
.err_or .error_tit a.hideerr { background:#df5132 url(images/button_dropup_or.gif) no-repeat center center;}
.err_bl .error_tit a.hideerr { background:#33507b url(images/button_dropup_bl.gif) no-repeat center center;}
.err_gr .error_tit a.hideerr { background:#7e7e7e url(images/button_dropup_gr.gif) no-repeat center center;}
.err_or .error_tit a.closeerr { background:#df5132 url(images/button_close_or.gif) no-repeat center center;}
.err_bl .error_tit a.closeerr { background:#33507b url(images/button_close_bl.gif) no-repeat center center;}
.err_gr .error_tit a.closeerr { background:#7e7e7e url(images/button_close_gr.gif) no-repeat center center;}
.err_or .error_msg a { color:#ff5e3b;}
.err_bl .error_msg a { color:#335c91;}
.err_gr .error_msg a { color:#3c3c3c;}
.gadget .gadgetblock { padding:12px 16px; background-color:#f4f4f4; border:1px solid #cfcfcf;}
.gadgets3par { margin-left:-4px; margin-right:-4px;}
.gadget3inline { margin-left:4px; margin-right:4px; float:left; width:247px;}
.gadget ul.grayarrow { margin:0; padding:0; list-style:none;}
.gadget ul.grayarrow li { background:url(images/li_arrow.gif) no-repeat 0px 10px;}
.gadget ul.grayarrow li a { display:block; margin:0; padding:6px 0 6px 16px; color:#335c91;}
.gadget ul.withlines li { border-top:1px solid #fff; border-bottom:1px solid #d7d7d7;}             /** "ul.withlines" use only with ul.grayarrow or other defined "ul" */
.gadget ul.withlines li.first { border-top:none;}
.gadget ul.withlines li.last { border-bottom:none;}
.gadget a.colourbutton { padding:6px 0 8px 10px; color:#fff; text-decoration:none;}
.gadget a.colourbutton span { padding:6px 10px 8px 0;}
.gadget a.colourbutton span span { padding:6px 12px 8px 6px;}   /* must have two alikes padding */
.gadget a.button_orange { background:url(images/button_orange_left.gif) no-repeat top left;}
.gadget a.button_orange span { background:url(images/button_orange_right.gif) no-repeat top right;}
.gadget a.button_orange span span { background:#ff5e3b url(images/button_orange.gif) repeat-x top;}
.gadget a.button_blue { background:url(images/button_blue_left.gif) no-repeat top left;}
.gadget a.button_blue span { background:url(images/button_blue_right.gif) no-repeat top right;}
.gadget a.button_blue span span { background:#ff5e3b url(images/button_blue.gif) repeat-x top;}
.gadget .shadowpar { margin:0 0 -12px 0; padding-left:6px;}
.gadget .pixshadow { margin:4px 5px 12px 5px; padding:4px; float:left; background-color:#ececec;}
.gadget .pixshadow img { margin-top:-8px; margin-left:-8px; padding:2px; background-color:#fff; border:1px solid #d7d7d7;}
.gadget table.gwlines { margin:0; padding:0;}
.gadget table.gwlines th { padding:6px; font-weight:bold; text-align:left; background-color:#fff; border-bottom:1px solid #d7d7d7;}
.gadget table.gwlines td { padding:6px; text-align:left; border-top:1px solid #fff; border-bottom:1px solid #d7d7d7;}
.gadget table.gwlines tr.last td { border-bottom:none;}
.gadget table.arborder { margin-bottom:8px; border:1px solid #d7d7d7;}
.gadget table .lrborder { border-left:1px solid #d7d7d7; border-right:1px solid #d7d7d7;}
.gadget table th.calign { text-align:center;}
.gadget table td.ralign { text-align:right; padding-right:12px;}
.gadget img.tabpimpa { border:none;}
.gadget .blockshadow { margin:4px 0 8px 4px; padding:4px; background-color:#ececec;}
.gadget .blockshadow div.bs_content { margin-top:-8px; margin-left:-8px; padding:10px 12px; background-color:#fff; border:1px solid #d7d7d7;}
.gadget .blockshadow div.bs_content img.context { margin-right:8px; float:left; border:none;}
.gadget .blockshadow div.bs_content div.context { float:left; width:126px;}
.gadget .blockshadow div.bs_content div.context h4 { margin:0 0 6px 0; padding:0 0 6px 0; font: bold 16px/1.2em Arial, Helvetica, sans-serif; border-bottom:1px solid #d7d7d7;}
.gadget .iconblockpar { margin:0 0 -16px 0; padding:8px 6px 0 6px;}
.gadget .iconblockshade { margin:0 12px 12px 12px; float:left; width:118px;}
.gadget .blockshadow div.iconblock { padding:6px 24px 0px 24px;}
.gadget .blockshadow div.iconblock img { border:none;}
.gadget .blockshadow div.iconblock p { text-align:center;}
.gadget .blockshadow div.iconblock a { color:#999;}
.gadget .whiteblock { padding:12px 20px; background-color:#fff; border:1px solid #d7d7d7;}
.gadget .whiteblock img { border:none;}
.gadget .whiteblock img.cardpay { float:left;}
.gadget .whiteblock img.cardlogo { margin:-6px 0 -8px 0;}
.gadget .whiteblock .priceblock { padding:8px 20px; float:left;}
.gadget .whiteblock .cardsblock { padding:0 0 0 20px; float:right; border-left:1px solid #d7d7d7;}
.gadget .whiteblock .pimpabtn { margin:-2px 0;}
.gadget .whiteblock .specpad { padding-top:12px;}
.gadget .clocktime { width:110px; float:left;}
.gadget .clockdate { padding-left:4px; float:left;}
.gadget .vertsortable_head { cursor:move;}
.gadget .horizsortable_head { cursor:move;}

/* contact */
form { margin:0; padding:0; }
form ol { margin:0; padding:0; list-style:none;}
form ol li { display:block; margin:0; padding:0 0 8px 0;}
form label, form input.text, form textarea, form select { font:normal 12px/1.5em Arial, Helvetica, sans-serif; color:#3c3c3c;}
form label { display:block; margin:0; padding:0;}
form input.text, form textarea, form select { margin:4px 0; padding:4px; background:#fff; border:1px solid #999;}
form input.text { height:15px;}
form textarea { height:82px;}
form select { padding:2px; height:25px;}
form a.pnbtn { padding:4px 8px; text-decoration:none; background-color:#fff; border:1px solid #d7d7d7;}
.form_quickcontact input.text { width:140px;}
.form_quickcontact textarea { width:204px;}
.form_login { margin-bottom:8px;}
.form_login input.text { width:140px;}
form input.text { width:140px;}
.form_example textarea { width:450px;}
.form_example input.mini { width:64px; text-align:center;}
.form_example input.small { width:120px;}
.form_example input.medium { width:180px;}
.form_example input.large { width:450px;}
.form_example input.date { width:16px;}
.form_example input.year { width:32px;}
.form_example select { width:450px;}
.form_example select.cntresults { float:right; width:100px;}
.form_example label.small { float:left; width:132px;}
.form_example label.date { float:left; width:35px;}
.form_example label.year { float:left; width:50px;}

/* DATEPICKER */
/* ========================================================== begin ====================================================================== */
/* Interaction states */
.ui-state-default, .ui-widget-content .ui-state-default { border:1px solid #f3f3f3; text-align:center;}    /* days (border must have) */
.ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited { }
.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus { border:1px dotted #d7d7d7;}    /* hovered day */
.ui-state-active, .ui-widget-content .ui-state-active { border:1px solid #d7d7d7;}    /* selected day */
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited { }

/* Interaction Cues */
.ui-state-highlight, .ui-widget-content .ui-state-highlight {border:1px solid #d7d7d7; background:#fff; text-align:center;}     /* today */

/* Datepicker */
.ui-datepicker { margin-top:8px; margin-bottom:16px;}  /* container for datepicker */
.ui-datepicker .ui-datepicker-header { position:relative; padding:4px 0; border:1px solid #d7d7d7; background:#fff;}          /* container for datepicker's head */
.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next { position:absolute; padding-top:3px; top:2px; width:36px; height:23px; text-decoration:none;}
.ui-datepicker .ui-datepicker-prev-hover, .ui-datepicker .ui-datepicker-next-hover { border:none;}
.ui-datepicker .ui-datepicker-prev { left:8px; background:url(images/arrow_prev.gif) no-repeat 2px 8px; text-align:right;}
.ui-datepicker .ui-datepicker-next { left:56px; background:url(images/arrow_next.gif) no-repeat 28px 8px;}
.ui-datepicker .ui-datepicker-prev span, .ui-datepicker .ui-datepicker-next span { display:block;}
.ui-datepicker .ui-datepicker-title { margin:0; padding-right:12px; line-height:1.8em; text-align:right;}
.ui-datepicker table { width:100%; border-collapse:collapse;}
.ui-datepicker th { padding:6px 4px; text-align:center; font-weight:bold; background:url(images/linehr.gif) repeat-x bottom;}
.ui-datepicker td { padding:0;}
.ui-datepicker td span, .ui-datepicker td a { display:block; padding:4px; text-decoration:none; }
/* ========================================================== end ====================================================================== */

/* dialogs */
#mask { position:absolute; left:0; top:0; z-index:9000; background-color:#000; display:none;}
#dialogboxes .window { position:absolute; display:none; padding:2px; left:0; top:0; width:382px; z-index:9999; background-color:#335c91;}
#dialogboxes .window .gadget { margin-bottom:0px;}
#dialogboxes .window .gadget .gadget { margin-bottom:12px;}




</style>

<body style="cursor: auto;">
<div class="container">

<div class="header">
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
        <div style="display: none;" class="gadget err_or">
          <div class="error_tit">
            <a href="#" class="hideerr" rel="hide_err"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <a href="#" class="closeerr" rel="close_err"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Critical Important message</h3>
          </div>
          <div class="error_msg"><p><strong>Lorem Ipsum is simply dummy text</strong> of the printing and typesetting industry. <a href="#">Lorem Ipsum has been the industry</a>'s standard dummy text ever since the 1500s</p></div>
        </div>
      <div class="leftblock vertsortable ui-sortable">
        <!--gadget left 1 -->
        <div class="gadget">
          <div class="titlebar vertsortable_head">
            <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Important message</h3>
          </div>
          <div class="gadgetblock">
            <p>Lorem Ipsum is simply dummy text of the printing and 
typesetting industry. Lorem Ipsum has been the industry's standard dummy
 text ever since the 1500s</p>
            <div class="whiteblock">
              <a href="#"><img src="images/cards.jpg" alt="CardPay" class="cardpay" height="72" width="83"></a>
              <div class="priceblock">
                <p class="bigprice">$457.00</p>
                <p class="light p_center nobottom">Monthly payment</p>
              </div>
              <div class="cardsblock">
                <p class="p_right">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                <p class="p_right bot8px specpad">
                <a href="#"><img src="images/card_mastercard.gif" alt="MasterCard" class="cardlogo" height="31" width="44"></a>
                <a href="#"><img src="images/card_visa.gif" alt="Visa" class="cardlogo" height="31" width="44"></a>
                <a href="#"><img src="images/card_cirrus.gif" alt="Cirrus" class="cardlogo" height="31" width="44"></a>&nbsp;&nbsp;&nbsp;
                <a href="#" class="colourbutton button_orange"><span><span><img src="images/pimpa_orangecheck.gif" alt="picture" class="pimpabtn" height="14" width="13"> &nbsp;
                <strong>Take Action</strong></span></span></a>
                </p>
              </div>
              <div class="clr"></div>
            </div>
          </div>
        </div>
        
        <!--gadget left 2 -->
        <div style="opacity: 1;" class="gadget">
          <div class="titlebar vertsortable_head">
            <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Administration Options</h3>
          </div>
          <div class="gadgetblock">
            <div class="iconblockpar">
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_1.jpg" alt="Admin Box" height="64" width="64"></a><br><a href="#">Admin Box</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_2.jpg" alt="Web Box" height="64" width="64"></a><br><a href="#">Web Box</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_3.jpg" alt="Art Box" height="64" width="64"></a><br><a href="#">Art Box</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_4.jpg" alt="Art Line" height="64" width="64"></a><br><a href="#">Art Line</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_5.jpg" alt="Web Box" height="64" width="64"></a><br><a href="#">Web Box</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_6.jpg" alt="Webmail" height="64" width="64"></a><br><a href="#">Webmail</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_7.jpg" alt="Contact Us" height="64" width="64"></a><br><a href="#">Contact Us</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_8.jpg" alt="Web Box" height="64" width="64"></a><br><a href="#">Web Box</a></p></div>
              </div></div>
              <div class="iconblockshade"><div class="blockshadow">
                <div class="bs_content iconblock"><p><a href="#"><img src="images/img_9.jpg" alt="Web Box" height="64" width="64"></a><br><a href="#">Web Box</a></p></div>
              </div></div>
              <div class="clr"></div>
            </div>
          </div>
        </div>
        <!--gadget left 3 -->
        <div class="gadget">
          <div class="titlebar vertsortable_head">
            <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Administration Options</h3>
          </div>
          <div class="gadgetblock">
            <h2>Welcome Administrator</h2>
            <p class="light">Lorem Ipsum is simply dummy text of the printing and typesetting industry</p>
            <div class="linehr"></div>
            <p>Lorem Ipsum is simply dummy text of the printing and 
typesetting industry. Lorem Ipsum has been the industry's standard dummy
 text ever since the 1500s, when an unknown printer took a galley of 
type and scrambled it to make a type specimen book. It has survived not 
only five centuries, but also the leap into el software like Aldus 
PageMaker including versions of Lorem Ipsum</p>
            <p><a href="#" class="colourbutton button_orange"><span><span>Lorem Ipsum is simply</span></span></a>&nbsp;<a href="#" class="colourbutton button_blue"><span><span>Lorem Ipsum is simply</span></span></a></p>
            <ul class="grayarrow">
              <li><a href="#">Lorem Ipsum is simply dummy text of the printing and typesetting industry</a></li>
            </ul>
          </div>
        </div>
        
        <!--more gadgets in line -->
        <div class="gadgets3par horizsortable ui-sortable">
          <!--gadget left 4a -->
          <div class="gadget gadget3inline">
            <div class="titlebar horizsortable_head">
              <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
              <h3>Administration Options</h3>
            </div>
            <div class="gadgetblock">
              <div class="blockshadow">
                <div class="bs_content">
                  <a href="#"><img src="images/img_mob_1.jpg" alt="picture" class="context" height="48" width="48"></a>
                  <div class="context">
                    <h4>Lorem Ipsum is</h4>
                    <p class="nobottom"><a href="#">Simply dummy text of the printing and typesetting industry.</a></p>
                  </div>
                  <div class="clr"></div>
                </div>
              </div>
              <p class="light nobottom">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's</p>
            </div>
          </div>
          <!--gadget left 4b -->
          <div class="gadget gadget3inline">
            <div class="titlebar horizsortable_head">
              <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
              <h3>Administration Options</h3>
            </div>
            <div class="gadgetblock">
              <div class="blockshadow">
                <div class="bs_content">
                  <a href="#"><img src="images/img_mob_2.jpg" alt="picture" class="context" height="48" width="48"></a>
                  <div class="context">
                    <h4>Lorem Ipsum is</h4>
                    <p class="nobottom"><a href="#">Simply dummy text of the printing and typesetting industry.</a></p>
                  </div>
                  <div class="clr"></div>
                </div>
              </div>
              <p class="light nobottom">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's</p>
            </div>
          </div>
          <!--gadget left 4c -->
          <div class="gadget gadget3inline">
            <div class="titlebar horizsortable_head">
              <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
              <h3>Administration Options</h3>
            </div>
            <div class="gadgetblock">
              <div class="blockshadow">
                <div class="bs_content">
                  <a href="#"><img src="images/img_mob_3.jpg" alt="picture" class="context" height="48" width="48"></a>
                  <div class="context">
                    <h4>Lorem Ipsum is</h4>
                    <p class="nobottom"><a href="#">Simply dummy text of the printing and typesetting industry.</a></p>
                  </div>
                  <div class="clr"></div>
                </div>
              </div>
              <p class="light nobottom">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's</p>
            </div>
          </div>
          <div class="clr"></div>
        </div>
        <!--gadget left 5 -->
        <div style="opacity: 1;" class="gadget">
          <div class="titlebar vertsortable_head">
            <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Administration Options</h3>
          </div>
          <div class="gadgetblock">
            <form action="" method="post" id="form_userstable">
              <table class="gwlines" cellpadding="0" cellspacing="0" border="0" width="100%">
                <tbody><tr>
                  <th width="40"><input name="utc1" id="utc1" type="checkbox"></th>
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
                  <td width="28"><a href="#"><img src="images/pimpa_yes.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                  <td width="28"><a href="#"><img src="images/pimpa_no.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                </tr>
                <tr>
                  <td><input name="utc3" id="utc3" type="checkbox"></td>
                  <td>John Smith</td>
                  <td>jonnysmi</td>
                  <td>12.24.1980</td>
                  <td>San Francisco, CA</td>
                  <td><a href="mailto:mail@yahoo.com">mail@yahoo.com</a></td>
                  <td><a href="#"><img src="images/pimpa_yes.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                  <td><a href="#"><img src="images/pimpa_no.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                </tr>
                <tr class="last">
                  <td><input name="utc4" id="utc4" type="checkbox"></td>
                  <td>John Smith</td>
                  <td>jonnysmi</td>
                  <td>12.24.1980</td>
                  <td>San Francisco, CA</td>
                  <td><a href="mailto:m13dail@yahoo.com">m13dail@yahoo.com</a></td>
                  <td><a href="#"><img src="images/pimpa_yes.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                  <td><a href="#"><img src="images/pimpa_no.gif" alt="picture" class="tabpimpa" height="20" width="20"></a></td>
                </tr>
              </tbody></table>
            </form>
          </div>
        </div>
        
      </div>
      <div class="rightblock vertsortable ui-sortable">
        <!--gadget right 1 -->
        <div style="opacity: 1;" class="gadget">
          <div class="titlebar vertsortable_head">
            <a style="background-image: url("images/button_dropup_bl.gif");" href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Date &amp; Time</h3>
          </div>
          <div style="display: block;" class="gadgetblock">
            <div class="whiteblock">
              <p class="timeclock"><img src="images/icon_clock.gif" alt="picture" height="26" width="26"> <span id="tm">09:42</span></p>
              <p class="light nobottom p_center">20th June, 2009, Friday</p>
            </div>
            <!--Datepicker -->
            <h3><img src="images/icon_calendar.gif" alt="picture" class="calendar" height="21" width="21">Calendar</h3>
            <div class="hasDatepicker" id="datepicker"><div class="ui-datepicker-inline ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"><div class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all"><a class="ui-datepicker-prev ui-corner-all" onclick="DP_jQuery.datepicker._adjustDate('#datepicker', -1, 'M');" title="Prev"><span class="ui-icon ui-icon-circle-triangle-w">Prev</span></a><a class="ui-datepicker-next ui-corner-all" onclick="DP_jQuery.datepicker._adjustDate('#datepicker', +1, 'M');" title="Next"><span class="ui-icon ui-icon-circle-triangle-e">Next</span></a><div class="ui-datepicker-title"><span class="ui-datepicker-month">September</span> <span class="ui-datepicker-year">2014</span></div></div><table class="ui-datepicker-calendar"><thead><tr><th class="ui-datepicker-week-end"><span title="Sunday">Su</span></th><th><span title="Monday">Mo</span></th><th><span title="Tuesday">Tu</span></th><th><span title="Wednesday">We</span></th><th><span title="Thursday">Th</span></th><th><span title="Friday">Fr</span></th><th class="ui-datepicker-week-end"><span title="Saturday">Sa</span></th></tr></thead><tbody><tr><td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">1</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">2</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">3</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">4</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">5</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">6</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">7</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">8</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">9</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">10</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">11</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">12</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">13</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">14</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">15</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">16</a></td><td class=" ui-datepicker-days-cell-over  ui-datepicker-current-day ui-datepicker-today" onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default ui-state-highlight ui-state-active" href="#">17</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">18</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">19</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">20</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">21</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">22</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">23</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">24</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">25</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">26</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">27</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">28</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">29</a></td><td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',8,2014, this);return false;"><a class="ui-state-default" href="#">30</a></td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td></tr></tbody></table></div></div>
            <div class="clr"></div>
            <p class="bot8px"><a href="#" class="colourbutton button_orange"><span><span>+  Add Event</span></span></a>&nbsp;<a href="#" class="colourbutton button_blue"><span><span>List Events</span></span></a></p>
          </div>
        </div>
        <!--gadget right 2 -->
        <div class="gadget">
          <div class="titlebar vertsortable_head">
            <a style="background-image: url("images/button_dropup_bl.gif");" href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Dashboard</h3>
          </div>
          <div style="display: block;" class="gadgetblock">
            <ul class="grayarrow withlines">
              <li class="first"><a href="#">Admin area example</a></li>
              <li><a href="#">Forms and fields area example</a></li>
              <li class="last"><a href="#">Tables area example</a></li>
            </ul>
          </div>
        </div>
        <!--gadget right 3 -->
        <div style="opacity: 1;" class="gadget">
          <div class="titlebar vertsortable_head">
            <a style="background-image: url("images/button_dropup_bl.gif");" href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Quick links</h3>
          </div>
          <div style="display: block;" class="gadgetblock">
            <div class="shadowpar">
              <div class="pixshadow"><a href="#"><img src="images/icon_1.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_2.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_3.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_4.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_5.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_6.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_7.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="pixshadow"><a href="#"><img src="images/icon_8.jpg" alt="picture" height="36" width="36"></a></div>
              <div class="clr"></div>
            </div>
          </div>
        </div><div style="opacity: 1;" class="gadget">
          <div class="titlebar vertsortable_head">
            <a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" alt="picture" height="33" width="19"></a>
            <h3>Quick contact form</h3>
          </div>
          <div class="gadgetblock">
            <form action="" method="post" id="form_quickcontact" class="form_quickcontact">
            <ol><li>
              <label for="name">Your name:</label>
              <input id="name" name="name" class="text">
              <div class="clr"></div>
            </li><li>
              <label for="email">Your contact email:</label>
              <input id="email" name="email" class="text">
              <div class="clr"></div>
            </li><li>
              <label for="message">Your questons &amp; comments:</label>
              <textarea id="message" name="message" rows="6" cols="50"></textarea>
              <div class="clr"></div>
            </li><li>
              <a href="#" class="colourbutton button_blue"><span><span>Contact us now</span></span></a>
              <!--<input type="image" name="imageField" id="imageField" src="images/button_send.gif" class="send" /> -->
              <div class="clr"></div>
            </li></ol>
            </form>
          </div>
        </div>
        <!--gadget right 4 -->
        
      </div>
      <div class="clr"></div>
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
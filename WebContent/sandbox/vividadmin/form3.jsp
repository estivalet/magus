<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

<script type="text/javascript" src="js/jquery-1.4.1.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/js.js"></script>

<link href="css/vividadmin/style.css" rel="stylesheet" type="text/css" />
<link href="css/vividadmin/menu.css" rel="stylesheet" type="text/css" />

</head>

<body>
    <div id="header">

        <div class="top_header">
            <div class="header_logo">
                <img src="images/logo3.png" alt="Logo" class="logo" height="122" style="padding: 5px" /> <a href="#"><img src="images/logo2.jpg" alt="Logo"
                    class="logo" height="122" width="300" style="padding: 5px" /></a>
                <div class="right">
                    <ul class="dark">
                        <li class="first"><a href="#">My account</a></li>
                        <li><a href="#">Settings</a></li>
                        <li><a href="#">Contact us</a></li>
                    </ul>
                    <div class="clr"></div>
                    <ul class="light">
                        <li class="first"><a href="#"><img src="images/icon_email.gif" alt="picture" class="email" height="10" width="14"></a><a
                            href="#">37</a> incoming messages</li>
                        <li><a href="#"><img src="images/icon_logout.gif" alt="picture" class="logout" height="16" width="16"></a><a href="#">logout</a></li>
                    </ul>
                    <p>
                        Logged in as <a href="#">User Name</a>
                    </p>
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
                                </ul></li>
                            <li class='has-sub'><a href='#'><span>Product 2</span></a>
                                <ul>
                                    <li><a href='#'><span>Sub Product</span></a></li>
                                    <li class='last'><a href='#'><span>Sub Product</span></a></li>
                                </ul></li>
                        </ul></li>
                    <li><a href='#'><span>About</span></a></li>
                    <li class='last'><a href='#'><span>Contact</span></a></li>
                </ul>
            </div>


        </div>




    </div>
    <div id="content">



        <!--CONTENT >
        <div class="xcontent">
            <div class="xcontent_res"-->
        <div class="content_block" style="padding: 20px;">

            <div class="rightblock vertsortable ui-sortable">

                <!--gadget right 2 -->
                <div class="gadget jsi_gv" style="width: 500px">
                    <div class="gadget_title vertsortable_head">
                        <a href="#" class="hidegadget" rel="hide_block"><img src="css/vividadmin/images/spacer.gif" height="35" width="19"></a>
                        <h3>Form Example 2</h3>
                    </div>
                    <div class="gadget_content">

                        <p class="err_mes jsi_mes_green">
                            <img class="pimpa" width="13" height="13" src="css/vividadmin/images/pimpa_green.gif"> success message <a class="close_mess" href="#"> <img
                                    width="24" height="38" src="css/vividadmin/images/spacer.gif"></a>
                        </p>
                        <p class="err_mes jsi_mes_red">
                            <img class="pimpa" width="13" height="13" src="css/vividadmin/images/pimpa_red.gif"> critical message <a class="close_mess" href="#"> <img
                                    width="24" height="38" src="css/vividadmin/images/spacer.gif"></a>
                        </p>



                        <form action="" method="post" id="form_example" class="form_example">
                            <ol>
                                <li><label for="name"><strong>Name</strong> (Small input form example)</label> <input id="name" name="name"
                                    class="text medium"></li>
                                <li><label for="address"><strong>Address</strong> (Large input form example)</label> <input id="address" name="address"
                                    class="text large"></li>
                                <li><label for="descr"><strong>Description</strong> (Large input form example)</label> <textarea id="descr" name="descr"
                                        rows="6" cols="50"></textarea></li>
                                <li><label for="multiply"><strong>Multiply</strong> (small input form example)</label> <input id="multiply" name="multiply"
                                    value="" type="hidden"> <input id="multiply1" name="multiply1" class="text small"> <input id="multiply2"
                                            name="multiply2" class="text small"> <input id="multiply3" name="multiply3" class="text small">
                                                    <div class="clr"></div> <label for="multiply1" class="small">example</label> <label for="multiply2"
                                                    class="small">example</label> <label for="multiply3" class="small">example</label>
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
                                        <td width="28"><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture" class="tabpimpa"
                                                height="13" width="13"></a></td>
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
                                        <td><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture" class="tabpimpa" height="13"
                                                width="13"></a></td>
                                        <td><a href="#"><img src="css/vividadmin/images/pimpa_no.gif" alt="picture" class="tabpimpa" height="13"
                                                width="13"></a></td>
                                    </tr>
                                    <tr class="last">
                                        <td><input name="utc4" id="utc4" type="checkbox"></td>
                                        <td>John Smith</td>
                                        <td>jonnysmi</td>
                                        <td>12.24.1980</td>
                                        <td>San Francisco, CA</td>
                                        <td><a href="mailto:m13dail@yahoo.com">m13dail@yahoo.com</a></td>
                                        <td><a href="#"><img src="css/vividadmin/images/pimpa_yes.gif" alt="picture" class="tabpimpa" height="13"
                                                width="13"></a></td>
                                        <td><a href="#"><img src="css/vividadmin/images/pimpa_no.gif" alt="picture" class="tabpimpa" height="13"
                                                width="13"></a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>

                    </div>
                </div>

            </div>
            <div class="clr"></div>
        </div>
        <!-- 
            </div>
        </div> -->






    </div>
    <div id="footer"></div>
</body>
</html>
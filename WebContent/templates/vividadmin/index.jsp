<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
<script type="text/javascript" src="js/jquery-1.4.1.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/js.js"></script>
<script type="text/javascript" src="js/clock.js"></script>

<title>Forms</title>

<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="container">
        <!--HEADER -->
        <div class="header">
            <div class="header_res">
                <a href="http://www.templateaccess.com/demos/adminskins/vividadmin/index.html"><img src="css/images/logo.jpg" alt="Logo"
                    class="logo" height="124" width="260"></a>
                <div class="rbuts">
                    <a href="#dialog1" name="modal" id="jsi_login"><img src="css/images/button_login.jpg" alt="Log In" height="40" width="120"></a>
                    <a href="#dialog2" name="modal" id="jsi_faq"><img src="css/images/button_faq.jpg" alt="F.A.Q." height="40" width="107"></a>
                    <div class="clr"></div>
                </div>
                <div class="clr"></div>
                <ul class="menu">
                    <li><a href="http://www.templateaccess.com/demos/adminskins/vividadmin/index.html" class="m1">Home</a>
                        <ul class="m1">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Office</a></li>
                            <li><a href="#">Bar</a></li>
                            <li><a href="#">Home</a></li>
                        </ul></li>
                    <li><a href="http://www.templateaccess.com/demos/adminskins/vividadmin/tables.html" class="m2">Services</a>
                        <ul class="m2">
                            <li><a href="#">Service 1</a></li>
                            <li><a href="#">Service 2</a></li>
                            <li><a href="#">Service 3</a></li>
                            <li><a href="#">Service 4</a></li>
                            <li><a href="#">Service 5</a></li>
                        </ul></li>
                    <li><a href="http://www.templateaccess.com/demos/adminskins/vividadmin/messages.html" class="m3">Style Example</a>
                        <ul class="m3">
                            <li><a href="#">Style 1</a></li>
                            <li><a href="#">Style 2</a></li>
                            <li><a href="#">Style 3</a></li>
                        </ul></li>
                    <li class="active"><a href="http://www.templateaccess.com/demos/adminskins/vividadmin/forms.html" class="m4">Forms</a></li>
                    <li><a href="#" class="m5">Contact us</a></li>
                </ul>
                <p class="personalinfo">
                    <a href="#"><strong>37</strong></a> incoming messages &nbsp;&nbsp; <a href="#"><img src="css/images/button_logout.jpg"
                        class="logout" height="17" width="17"></a><a href="#" id="jsi_logout">logout</a>
                </p>
                <div class="clr"></div>
            </div>
        </div>
        <!--CONTENT -->
        <div class="content">
            <div class="content_res">
                <div class="content_block">
                    <div class="leftblock vertsortable ui-sortable">

                        <!--gadget clock -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                                <h3>Date &amp; Mail</h3>
                            </div>
                            <div class="gadget_content">
                                <p class="timeclock">
                                    <img src="css/images/icon_clock2.gif" height="26" width="26"><span id="tm">11 08</span>
                                </p>
                            </div>
                        </div>
                        <!--gadget calendar -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                                <h3>Calendar</h3>
                            </div>
                            <div class="gadget_content">
                                <div class="hasDatepicker" id="datepicker">
                                    <div class="ui-datepicker-inline ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
                                        <div class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">
                                            <a class="ui-datepicker-prev ui-corner-all" onclick="DP_jQuery.datepicker._adjustDate('#datepicker', -1, 'M');"
                                                title="Prev"><span class="ui-icon ui-icon-circle-triangle-w">Prev</span></a><a
                                                class="ui-datepicker-next ui-corner-all" onclick="DP_jQuery.datepicker._adjustDate('#datepicker', +1, 'M');"
                                                title="Next"><span class="ui-icon ui-icon-circle-triangle-e">Next</span></a>
                                            <div class="ui-datepicker-title">
                                                <span class="ui-datepicker-month">November</span> <span class="ui-datepicker-year">2014</span>
                                            </div>
                                        </div>
                                        <table class="ui-datepicker-calendar">
                                            <thead>
                                                <tr>
                                                    <th class="ui-datepicker-week-end"><span title="Sunday">Su</span></th>
                                                    <th><span title="Monday">Mo</span></th>
                                                    <th><span title="Tuesday">Tu</span></th>
                                                    <th><span title="Wednesday">We</span></th>
                                                    <th><span title="Thursday">Th</span></th>
                                                    <th><span title="Friday">Fr</span></th>
                                                    <th class="ui-datepicker-week-end"><span title="Saturday">Sa</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">1</a></td>
                                                </tr>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">2</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">3</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">4</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">5</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">6</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">7</a></td>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">8</a></td>
                                                </tr>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">9</a></td>
                                                    <td class=" ui-datepicker-days-cell-over  ui-datepicker-current-day ui-datepicker-today"
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default ui-state-highlight ui-state-active" href="#">10</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">11</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">12</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">13</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">14</a></td>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">15</a></td>
                                                </tr>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">16</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">17</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">18</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">19</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">20</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">21</a></td>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">22</a></td>
                                                </tr>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">23</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">24</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">25</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">26</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">27</a></td>
                                                    <td class=" " onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">28</a></td>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">29</a></td>
                                                </tr>
                                                <tr>
                                                    <td class=" ui-datepicker-week-end "
                                                        onclick="DP_jQuery.datepicker._selectDay('#datepicker',10,2014, this);return false;"><a
                                                        class="ui-state-default" href="#">30</a></td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                    <td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clr"></div>
                                <p class="acenter bot24px">
                                    <a href="#" class="blackbutton">+ Add Event</a> &nbsp;&nbsp; <a href="#" class="blackbutton">List Events</a>
                                </p>
                            </div>
                        </div>
                        <!--gadget dashboard -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                                <h3>Dashboard</h3>
                            </div>
                            <div class="gadget_content">
                                <ul class="grayarrow withlines">
                                    <li class="first"><a href="#">Admin area example</a></li>
                                    <li><a href="#">Forms and fields area example</a></li>
                                    <li class="last"><a href="#">Tables area example</a></li>
                                </ul>
                            </div>
                        </div>
                        <!--gadget to_do -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                                <h3>To do</h3>
                            </div>
                            <div class="gadget_content">
                                <form action="#" method="post" id="form_todo" class="form_todo">
                                    <ul class="chklist withdotted">
                                        <li><input name="chk1" id="chk1" value="false" class="checkbox" type="checkbox"><a href="#">Lorem Ipsum
                                                is simply</a>
                                        <p>by: Usernam Name</p></li>
                                        <li><input name="chk2" id="chk2" value="false" class="checkbox" type="checkbox"><a href="#">It is a
                                                long established fact</a>
                                        <p>by: Usernam Name</p></li>
                                        <li><input name="chk3" id="chk3" value="false" class="checkbox" type="checkbox"><a href="#">Contrary to
                                                popular belief, Lore</a>
                                        <p>by: Usernam Name</p></li>
                                        <li><input name="chk4" id="chk4" value="false" class="checkbox" type="checkbox"><a href="#">Lorem Ipsum
                                                is simply</a>
                                        <p>by: Usernam Name</p></li>
                                    </ul>
                                </form>
                                <p class="bot24px">
                                    <a href="#" class="blackbutton">View All</a>
                                </p>
                            </div>
                        </div>

                    </div>
                    <div class="rightblock vertsortable ui-sortable">
                        <!--gadget right 1 -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
                                <h3>Form Example 1</h3>
                            </div>
                            <div class="gadget_content">
                                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard
                                    dummy text ever since the 1500s</p>
                                <p>
                                    <a href="#">Learn more »</a>
                                </p>
                            </div>
                        </div>

                        <!--gadget right 2 -->
                        <div class="gadget jsi_gv">
                            <div class="gadget_title vertsortable_head">
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
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
                                <a href="#" class="hidegadget" rel="hide_block"><img src="css/images/spacer.gif" height="35" width="19"></a>
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
                                                <td width="28"><a href="#"><img src="css/images/pimpa_yes.gif" alt="picture"
                                                        class="tabpimpa" height="13" width="13"></a></td>
                                                <td width="28"><a href="#"><img src="css/images/pimpa_no.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                            </tr>
                                            <tr>
                                                <td><input name="utc3" id="utc3" type="checkbox"></td>
                                                <td>John Smith</td>
                                                <td>jonnysmi</td>
                                                <td>12.24.1980</td>
                                                <td>San Francisco, CA</td>
                                                <td><a href="mailto:mail@yahoo.com">mail@yahoo.com</a></td>
                                                <td><a href="#"><img src="css/images/pimpa_yes.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                                <td><a href="#"><img src="css/images/pimpa_no.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                            </tr>
                                            <tr class="last">
                                                <td><input name="utc4" id="utc4" type="checkbox"></td>
                                                <td>John Smith</td>
                                                <td>jonnysmi</td>
                                                <td>12.24.1980</td>
                                                <td>San Francisco, CA</td>
                                                <td><a href="mailto:m13dail@yahoo.com">m13dail@yahoo.com</a></td>
                                                <td><a href="#"><img src="css/images/pimpa_yes.gif" alt="picture" class="tabpimpa"
                                                        height="13" width="13"></a></td>
                                                <td><a href="#"><img src="css/images/pimpa_no.gif" alt="picture" class="tabpimpa"
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

        <!--FOOTER -->
        <div class="footer">
            <div class="footer_res">
                <a href="#"><img src="css/images/logo_f.jpg" alt="logo" class="logo" height="114" width="260"></a>
                <div class="right_footer">
                    <ul>
                        <li><a href="http://www.templateaccess.com/demos/adminskins/vividadmin/index.html">Home</a></li>
                        <li><a href="#">Services</a></li>
                        <li><a href="#">Style Example</a></li>
                        <li><a href="#">Forms</a></li>
                        <li><a href="#">Contact Us</a></li>
                    </ul>
                    <div class="clr"></div>
                    <p>
                        <a href="http://www.dreamtemplate.com/"><img src="css/images/icon_site.jpg" alt="picture" height="22" width="27"></a>Website
                        Administration by <a href="http://www.webappskins.com/"><strong>WebAppSkins</strong></a>
                    </p>
                </div>
                <div class="clr"></div>
            </div>
        </div>
        <!--DIALOGS -->
        <div id="dialogboxes">
            <!--dialog 1 -->
            <div id="dialog1" class="window">
                <div class="gadget jsi_gd">
                    <div class="gadget_title">
                        <a href="#" class="close closegadget"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>Thank you for</h3>
                    </div>
                    <div class="gadget_content">
                        <p>
                            Lorem Ipsum is simply dummy text of the printing and typesetting industry. <strong>Lorem Ipsum has been the industry's
                                standard dummy text</strong> ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make.
                        </p>
                        <div class="linehr"></div>
                        <p class="bot24px">
                            <a href="#" class="blackbutton">Start Demo - Login Now</a>
                        </p>
                    </div>
                </div>
            </div>
            <!--dialog 2 -->
            <div id="dialog2" class="window">
                <div class="gadget jsi_gd">
                    <div class="gadget_title">
                        <a href="#" class="close closegadget"><img src="css/images/spacer.gif" height="35" width="19"></a>
                        <h3>Welcome to Admin Area</h3>
                    </div>
                    <div class="gadget_content">
                        <p>
                            Lorem Ipsum is simply dummy text of the printing and typesetting industry. <strong>Lorem Ipsum has been the industry's
                                standard dummy text</strong> ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make.
                        </p>
                        <p class="err_mes jsi_mes_green">
                            <img src="css/images/pimpa_green.gif" class="pimpa" height="13" width="13"> success message <a href="#"
                                class="close_mess"><img src="css/images/spacer.gif" height="38" width="24"></a>
                        </p>
                        <p class="err_mes jsi_mes_red">
                            <img src="css/images/pimpa_red.gif" class="pimpa" height="13" width="13"> critical message <a href="#"
                                class="close_mess"><img src="css/images/spacer.gif" height="38" width="24"></a>
                        </p>
                        <form action="" method="post" id="loginform" class="form_login">
                            <ol>
                                <li><label for="login">Your Login:</label> <input id="login" name="login" class="text">
                                    <div class="clr"></div></li>
                                <li><label for="pwd">Your Password:</label> <input id="pwd" name="pwd" class="text" type="password">
                                    <div class="clr"></div></li>
                            </ol>
                        </form>
                        <p class="bot24px">
                            <a href="#" class="blackbutton">Start Demo - Login Now</a>
                        </p>
                    </div>
                </div>
            </div>
            <!--Mask to cover the whole screen -->
            <div id="mask"></div>
        </div>
    </div>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="cs" xml:lang="cs" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="content-type">

<link rel="stylesheet" href="css/boxie-blue/boxie-blue.css" type="text/css" />
</head>

 <div id="login">
        <div class="box box-50 altbox">
            <div class="boxin">
                <div class="header">
                    <h3><img src="css/boxie-blue/logo-login.png" alt="Boxie Admin"></h3>
                    <ul>
                        <li><a href="#" class="active">login</a></li><!-- .active for active tab -->
                        <li><a href="#">lost password</a></li>
                    </ul>
                </div>
                <form class="table" action="blue.html" method="post"><!-- Default forms (table layout) -->
                    <div class="inner-form">
                        <div class="msg msg-info">
                            <p>Just click <strong>Log in</strong>.</p>
                        </div>
                        <table cellspacing="0">
                            <tbody><tr>
                                <th><label for="some1">Name:</label></th>
                                <td><input class="txt" id="some1" name="some1" type="text"></td>
                            </tr>
                            <tr>
                                <th><label for="some3">Password:</label></th>
                                <td><input class="txt pwd" id="some3" name="some3" type="password"></td><!-- class error for wrong filled inputs -->
                            </tr>
                            <tr>
                                <th></th>
                                <td class="tr proceed">
                                    <input class="button" value="Log in" type="submit">
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                </form>
            </div>
        </div>
    </div>
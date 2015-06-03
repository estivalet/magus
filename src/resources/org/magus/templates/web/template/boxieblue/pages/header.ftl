<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="content-type" content="text/html; charset=windows-1252"/>
    <link rel="stylesheet" href="css/boxie-blue/boxie-blue.css" type="text/css" />
    <link rel="stylesheet" href="css/app.css" type="text/css" />
	<script type="text/javascript" src="js/helper.js"></script>

    <script>
    function submit(formAction, command, action, pageNum) {
        var form = createForm("myform","post",formAction);
        var input1 = createInput("command","hidden",command);
        var input2 = createInput("action","hidden",action);
        var input3 = createInput("pageNum","hidden",pageNum);
        form.appendChild(input1);
        form.appendChild(input2);
        form.appendChild(input3);
        document.body.appendChild(form);
        form.submit();
    }
    </script>
    
</head>

<body>

<header>
<div class="top_header">
    <div class="header_logo">
        <img src="images/logo3.png" alt="Logo" class="logo" height="122" style="padding: 5px"> <a href="#"><img src="images/logo2.jpg" alt="Logo"
                class="logo" height="122" width="300" style="padding: 5px"></a>
            <div class="right">
                <ul class="light">
                    <li class="first"><a href="#"><img src="images/icon_email.gif" alt="picture" class="email" height="10" width="14"></a><a href="#">37</a>
                        incoming messages</li>
                    <li><a href="#"><img src="images/icon_logout.gif" alt="picture" class="logout" height="16" width="16"></a><a href="#">logout</a></li>
                </ul>
                <p>
                    Logged in as <a href="#">User Name</a>
                </p>
                <ul class="dark">
                    <li class="first"><a href="#">My account</a></li>
                    <li><a href="#">Settings</a></li>
                    <li><a href="#">Contact us</a></li>
                </ul>
                <div class="clr"></div>
            </div>
            <div class="clr"></div>
    </div>
<div id='cssmenu'>
    <ul>
        <li><a href='#'><span>Home</span></a></li>
        <li class='active has-sub'><a href='#'><span>Products</span></a>
            <ul>
            <#list servlets as servlet><#t>
                <li><a href="#" onclick="submit('${appShortName}','${servlet.name}Action','index','1')">${servlet.name}</a></li>
            </#list>
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
</header>

    <div id="content">


        
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>${appShortName}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/pure.css" media="screen">
<link rel="stylesheet" type="text/css" href="css/datepickr.css" media="screen">
<link rel="stylesheet" type="text/css" href="css/alertify.min.css" />
<link rel="stylesheet" type="text/css" href="css/alertify/default.min.css" />

<script type="text/javascript" src="js/helper.js"></script>
<script type="text/javascript" src="js/datepickr.js"></script>
<script type="text/javascript" src="js/alertify.min.js"></script>
<script type="text/javascript" src="js/input-mask.js"></script>

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


<header>
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
</header>


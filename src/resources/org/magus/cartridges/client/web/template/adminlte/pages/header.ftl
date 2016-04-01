<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>${app.shortName}</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="css/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="css/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="adminlte/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="adminlte/css/skins/_all-skins.min.css">

    <link rel="stylesheet" type="text/css" href="css/pure.css" media="screen">
    <link rel="stylesheet" type="text/css" href="css/datepickr.css" media="screen">
    <link rel="stylesheet" type="text/css" href="css/alertify.min.css" />
    <link rel="stylesheet" type="text/css" href="css/alertify/default.min.css" />
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="js/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="js/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script type="text/javascript" src="js/helper.js"></script>
    <script type="text/javascript" src="js/datepickr.js"></script>
    <script type="text/javascript" src="js/alertify.min.js"></script>
    <script type="text/javascript" src="js/input-mask.js"></script>
    <script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>
   
</head>





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
            <#list app.tables as servlet><#t>
                <li><a href="#" onclick="submit('','${servlet.getCamelCaseName(true)}Action','index','1')">${servlet.getCamelCaseName(true)}</a></li>
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

  <body class="hold-transition skin-blue sidebar-mini">
  <div id="content">
  
        <!-- Main content -->
        <section class="content">
          <div class="row">
            <!-- left column -->
            <div class="col-md-6">
              <!-- general form elements -->
              <div class="box box-primary">


<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <meta charset="UTF-8" />
    <title>BCORE Admin Dashboard Template | Advance Forms</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <![endif]-->

    <!-- GLOBAL STYLES -->
    <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/theme.css" />
    <link rel="stylesheet" href="assets/css/MoneAdmin.css" />
    <link rel="stylesheet" href="assets/plugins/Font-Awesome/css/font-awesome.css" />
    <!--END GLOBAL STYLES --> 

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    
</head>
<!-- END HEAD -->


<style>
body {
    padding-top: 50px;
    overflow: hidden;
}
#wrapper {
    min-height: 100%;
    height: 100%;
    width: 100%;
    position: absolute;
    top: 0px;
    left: 0;
    display: inline-block;
}
#main-wrapper {
    height: 100%;
    overflow-y: auto;
    padding: 50px 0 70px 0;
}
#main {
    position: relative;
    height: 100%;
    overflow-y: auto;
    padding: 0 15px;
}

.list-group-item {
        border-radius: 0;
        border-left: 0;
        border-right: 0;
        border-top: 0;
}
@media (max-width: 992px) {
    body {
        padding-top: 0px;
    }
}
@media (min-width: 992px) {
    #main-wrapper {
        float:right;
    }
}
@media (max-width: 992px) {
    #main-wrapper {
        padding-top: 0px;
    }
}

.footer {
    background-color:#ffffff;
    bottom:0;
    position:fixed;
    padding:10px;
}
</style>

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

<!-- HEADER SECTION -->
<div id="top">
    <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
        <a data-original-title="Show/Hide Menu" data-placement="bottom" data-tooltip="tooltip" class="accordion-toggle btn btn-primary btn-sm visible-xs" data-toggle="collapse" href="#menu" id="menu-toggle">
            <i class="icon-align-justify"></i>
        </a>
        <!-- LOGO SECTION -->
        <header class="navbar-header">
            <a href="index.html" class="navbar-brand">
            <img src="assets/img/logo.png" alt="" /></a>
        </header>
        <!-- END LOGO SECTION -->
        <ul class="nav navbar-top-links navbar-right">
            <!-- MESSAGES SECTION -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="label label-success">2</span>    <i class="icon-envelope-alt"></i>&nbsp; <i class="icon-chevron-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                    <li>
                        <a href="#">
                            <div>
                               <strong>John Smith</strong>
                                <span class="pull-right text-muted">
                                    <em>Today</em>
                                </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                <br />
                                <span class="label label-primary">Important</span> 
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <strong>Raphel Jonson</strong>
                                <span class="pull-right text-muted">
                                    <em>Yesterday</em>
                                </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                 <br />
                                <span class="label label-success"> Moderate </span> 
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <strong>Chi Ley Suk</strong>
                                <span class="pull-right text-muted">
                                    <em>26 Jan 2014</em>
                                </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                 <br />
                                <span class="label label-danger"> Low </span> 
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>Read All Messages</strong>
                            <i class="icon-angle-right"></i>
                        </a>
                    </li>
                </ul>

            </li>
            <!--END MESSAGES SECTION -->

            <!--TASK SECTION -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="label label-danger">5</span>   <i class="icon-tasks"></i>&nbsp; <i class="icon-chevron-down"></i>
                </a>

                <ul class="dropdown-menu dropdown-tasks">
                    <li>
                        <a href="#">
                            <div>
                                <p>
                                    <strong> Profile </strong>
                                    <span class="pull-right text-muted">40% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                        <span class="sr-only">40% Complete (success)</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <p>
                                    <strong> Pending Tasks </strong>
                                    <span class="pull-right text-muted">20% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                        <span class="sr-only">20% Complete</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <p>
                                    <strong> Work Completed </strong>
                                    <span class="pull-right text-muted">60% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                        <span class="sr-only">60% Complete (warning)</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <p>
                                    <strong> Summary </strong>
                                    <span class="pull-right text-muted">80% Complete</span>
                                </p>
                                <div class="progress progress-striped active">
                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>See All Tasks</strong>
                            <i class="icon-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </li>
            <!--END TASK SECTION -->

            <!--ALERTS SECTION -->
            <li class="chat-panel dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="label label-info">8</span>   <i class="icon-comments"></i>&nbsp; <i class="icon-chevron-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-alerts">
                    <li>
                        <a href="#">
                            <div>
                                <i class="icon-comment" ></i> New Comment
                            <span class="pull-right text-muted small"> 4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="icon-twitter info"></i> 3 New Follower
                            <span class="pull-right text-muted small"> 9 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="icon-envelope"></i> Message Sent
                            <span class="pull-right text-muted small" > 20 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="icon-tasks"></i> New Task
                            <span class="pull-right text-muted small"> 1 Hour ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="icon-upload"></i> Server Rebooted
                            <span class="pull-right text-muted small"> 2 Hour ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>See All Alerts</strong>
                            <i class="icon-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </li>
            <!-- END ALERTS SECTION -->

            <!--ADMIN SETTINGS SECTIONS -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-user "></i>&nbsp; <i class="icon-chevron-down "></i>
                </a>

                <ul class="dropdown-menu dropdown-user">
                    <li><a href="#"><i class="icon-user"></i> User Profile </a>
                    </li>
                    <li><a href="#"><i class="icon-gear"></i> Settings </a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="login.html"><i class="icon-signout"></i> Logout </a>
                    </li>
                </ul>
            </li>
            <!--END ADMIN SETTINGS -->
        </ul>
        
        <ul class="nav navbar-top-links navbar-left">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                            <#list servlets as servlet><#t>
                                <li><a href="#" onclick="submit('${appShortName}','${servlet.name}Action','index','1')">${servlet.name}</a></li>
                            </#list>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </ul>
    </nav>
</div>
<!-- END HEADER SECTION -->

<!-- WRAPPER -->
<div id="wrapper">
    <!-- MAIN-WRAPPER -->
    <div id="main-wrapper" class="col-md-12 pull-right">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>MAGUS - My App Generator Utility System</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="dist/css/skins/_all-skins.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
  <!-- Morris chart 
  <link rel="stylesheet" href="plugins/morris/morris.css">
  -->
  <!-- jvectormap -->
  <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  
  <style>
  .total {
    float:right;
    background-color:#101010;
    padding:2px;
    margin-right:10px;
    color:white;
    font-weight:bold;
    }
  </style>
</head>
<body class="hold-transition skin-blue sidebar-mini fixed">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Admin</b>LTE</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">

	  
        <div class="collapse navbar-collapse pull-left" id="navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="#">Link <span class="sr-only">(current)</span></a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
                <li class="divider"></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-form navbar-left" role="search">
            <div class="form-group">
              <input type="text" class="form-control" id="navbar-search-input" placeholder="Search">
            </div>
          </form>
        </div>

	  
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">


     
        </ul>
      </div>
      
      
      
      
      
    </nav>
    
    
    
  </header>
  
  <aside class="main-sidebar">
    <section class="sidebar">
      <ul class="sidebar-menu">
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">[All Games]</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Amstrad CPC</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Apple II</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Apple Macintosh</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Arcade (MAME)</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="?command=Collector&system=atari2600"><span style="color:white">Atari 2600</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari 8-Bit</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari 5200</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari 7800</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari Jaguar</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari Lynx</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Atari ST</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Bandai Wonderswan</span> <span class="total">52200</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Bandai Wonderswan Color</span> <span  class="total">50</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Commodore 64</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Commodore Amiga</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Coleco Colecovision</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Dragon Data Dragon</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Game & Watch</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">GCE Vectrex</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Infocom Z-Machine</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Laserdisc (Daphne)</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Magnavox Odyssey 2</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Mattel Intellivision</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">MGT Sam Coupe</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Microsoft DOS</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Microsoft MSX</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Microsoft MSX2</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Microsoft MSX2+</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">NEC PC Engine</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">NEC PC Engine-CD</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">NEC SuperGrafx</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">NEC TurboGrafx-16</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">NEC TurboGrafx-CD</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo 64</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo DS</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Famicom</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Famicom Disk System</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Game Boy Advance</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Game Boy Color</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Game Cube</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Game Boy</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo NES</span> <span  class="total">12500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo SNES</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo Virtual Boy</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Nintendo WII</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Panasonic 3DO</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">SCUMMVM</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega 32X</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega CD</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega Dreamcast</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega Game Gear</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega Master System</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega Genesis</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega Megadrive Japan</span> <span  class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sega SG-1000</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sinclair ZX Spectrum</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">SNK Neo Geo AES</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">SNK Neo Geo MVS</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">SNK Neo Geo Pocket</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">SNK Neo Geo Pocket Color</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sony Playstation</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sony Playstation 2</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Sony PSP</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Tandy Color Computer</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Tandy TRS-80</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Tangerine Oric</span> <span class="total">500</span></a></li>
        <li style="border-bottom:1px solid #404040"><a href="documentation/index.html"><span style="color:white">Texas Intruments TI-99/4A</span> <span class="total">500</span></a></li>
      </ul>
    </section>
  </aside>

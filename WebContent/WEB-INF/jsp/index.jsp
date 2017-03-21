<%@include file="header.jsp"%>

<script type="text/javascript" src="js/helper.js"></script>
<script type="text/javascript" src="js/magus.js"></script>
<!-- script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.leanModal.js" type="text/javascript"></script-->


<!-- link href="css/style.css" rel="stylesheet" type="text/css" /-->
<!-- link href="css/menu.css" rel="stylesheet" type="text/css" /-->
<link href="css/magus.css" rel="stylesheet" type="text/css" />

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Blank page <small>it all starts here</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Examples</a></li>
            <li class="active">Blank page</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Quick Example</h3>
                    </div>
                    <!-- /.box-header -->
                    <!-- form start -->
                    <div class="box-body">

                        <div class="row">
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label for="project">Application:</label> <select id="project" class="form-control">
                                        <option value="">Select...</option>
                                        <c:forEach var="app" items="${apps}">
                                            <option value="<c:out value='${app.id}'/>"><c:out value='${app.name}' /></option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>




                        <div class="tabGroup">
                            <input type="radio" name="tabGroup1" id="rad1" class="tab1" checked="checked" /> <label for="rad1">Application</label> <input
                                type="radio" name="tabGroup1" id="rad2" class="tab2" /> <label for="rad2">Data Source</label> <input type="radio"
                                name="tabGroup1" id="rad3" class="tab3" /> <label for="rad3">Table Selection</label> <input type="radio" name="tabGroup1"
                                id="rad4" class="tab4" /> <label for="rad4">Column Mapping</label>

                            <div class="tab1">
                                <form role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Name</label> <input type="text" id="projectName" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Short Name</label> <input type="text" id="projectShortName" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Path</label> <input type="text" id="projectPath" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="project">Architecture</label> <select id="architecture" class="form-control">
                                            <option value="JSP_Servlet" selected="selected">JSP & Servlet</option>
                                            <option value="REST">REST</option>
                                            <option value="JSF">JSF</option>

                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="project">Template</label> <select id="template" class="form-control">
                                            <option value="pure" selected="selected">pure</option>
                                            <option value="black">Black</option>
                                            <option value="boxieblue">Boxie Blue</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea class="form-control" rows="3" id="projectDescription"></textarea>
                                    </div>


                                </form>

                            </div>


                            <div class="tab2">
                                <div class="form-group">
                                    <label for="project">Template</label> <select id="database" class="form-control">
                                        <c:forEach var="db" items="${magus_config.databases}">
                                            <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}' /></option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>URL</label> <input type="text" id="dbURL" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>User</label> <input type="text" id="dbUser" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Pass</label> <input type="text" id="dbPass" class="form-control">
                                </div>

                            </div>


                            <div class="tab3">
                                <form action="" method="post" id="form_example" class="form_example">
                                    <ol>
                                        <li><label for="schema"><strong>Schema</strong></label> <select id="schema" name="schema"
                                            onchange="listTables(this.value)">
                                        </select></li>
                                        <li>
                                            <table border="0">
                                                <tr>
                                                    <td><label for="tables">Available Tables</label></td>
                                                    <td>&nbsp;</td>
                                                    <td><label for="tables">Selected Tables</label></td>
                                                </tr>
                                                <tr>
                                                    <td><select id="tables" name="tables" multiple="multiple" style="height: 100px"></select></td>
                                                    <td align="center"><input type="button" value=">" onclick="moveSelectedTables()" /><br /> <input
                                                        type="button" value=">>" onclick="moveAllTables()" /><br /> <input type="button" value="<" onclick=" removeSelectedTables()"/><br />
                                                        <input type="button" value="<<" onclick=" removeAllTables()"/></td>
                                                    <td><select id="selectedTables" name="selectedTables" multiple="multiple" style="height: 100px"></select></td>
                                                </tr>
                                            </table>
                                        </li>
                                    </ol>

                                </form>
                            </div>


                            <div class="tab4">
                                <form action="" method="post" id="form_example" class="form_example">
                                    <ol>
                                        <li><label for="table"><strong>Table</strong></label> <select id="table" name="table"
                                            onchange="listTableColumns(this.value)">
                                        </select></li>
                                        <li>
                                            <table id="columnTbl" name="columnTbl" border="0">
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>Column</td>
                                                    <td>Label</td>
                                                    <td>Type</td>
                                                    <td>Order</td>
                                                    <td>&nbsp;</td>
                                                    <td>Mask</td>
                                                    <td>Visible</td>
                                                    <td>Filter</td>
                                                    <td>Comment</td>
                                                </tr>
                                            </table>
                                        </li>
                                    </ol>
                                    <input type="button" value="Save" onclick="saveColumnMapping()" />
                                </form>
                            </div>
                        </div>





                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.box -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@include file="footer.jsp"%>
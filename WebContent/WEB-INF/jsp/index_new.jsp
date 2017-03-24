<%@include file="header.jsp"%>

<style>
/* Add borders to bootstrap navtabs. */
.nav-tabs {
	padding-left: 15px;
	margin-bottom: 0;
	border: none;
}
/* Add borders to bootstrap navtabs. */
.tab-content {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 15px;
}


</style>

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
                                    <label for="project">Application:</label> <select id="project" class="form-control" onchange="loadProject(this.value)">
                                        <option value="">Select...</option>
                                        <c:forEach var="app" items="${apps}">
                                            <option value="<c:out value='${app.id}'/>"><c:out value='${app.name}' /></option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-6" style="margin-top:25px;">
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary" onclick="generateCode()">Generate</button>
                                </div>
                            </div>
                        </div>

                        <input type="hidden" id="id" name="id" value="0" />

                        <div class="form-group">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#app">Application</a></li>
                                <li><a data-toggle="tab" href="#ds">Data Source</a></li>
                                <li><a data-toggle="tab" href="#table_sel">Table Selection</a></li>
                                <li><a data-toggle="tab" href="#column">Column Mapping</a></li>
                            </ul>

                            <div class="tab-content">
                                <div id="app" class="tab-pane fade in active">
                                    <form role="form">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>Name</label> <input type="text" id="projectName" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-xs-2">
                                                <div class="form-group">
                                                    <label>Short Name</label> <input type="text" id="projectShortName" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label for="project">Architecture</label> <select id="architecture" class="form-control">
                                                        <option value="JSP_Servlet" selected="selected">JSP &amp; Servlet</option>
                                                        <option value="JSPv2" selected="selected">JSPv2</option>
                                                        <option value="REST">REST</option>
                                                        <option value="JSF">JSF</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-10">

                                                <div class="form-group">
                                                    <label>Path</label> <input type="text" id="projectPath" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-xs-2">
                                                <div class="form-group">
                                                    <label for="project">Template</label> <select id="template" class="form-control">
                                                        <option value="pure" selected="selected">pure</option>
                                                        <option value="black">Black</option>
                                                        <option value="boxieblue">Boxie Blue</option>
                                                        <option value="adminLTE">AdminLTE</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Description</label>
                                            <textarea class="form-control" rows="3" id="projectDescription"></textarea>
                                        </div>


                                    </form>
                                    <button type="submit" class="btn btn-primary" onclick="newProject()">Save</button>
                                </div>
                                <div id="ds" class="tab-pane fade">
                                    <div class="form-group">
                                        <label for="project">Database</label> <select id="database" class="form-control">
                                            <c:forEach var="db" items="${magus_config.databases}">
                                                <option value="<c:out value='${db.type}'/>"><c:out value='${db.type}' /></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-8">
                                            <div class="form-group">
                                                <label>URL</label> <input type="text" id="dbURL" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-xs-2">
                                            <div class="form-group">
                                                <label>User</label> <input type="text" id="dbUser" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-xs-2">

                                            <div class="form-group">
                                                <label>Pass</label> <input type="text" id="dbPass" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary" onclick="saveProject()">Save</button>

                                </div>
                                <div id="table_sel" class="tab-pane fade">
                                    <div class="form-group">
                                        <label for="schema">Schema</label> <select id="schema" class="form-control" onchange="listTables(this.value)">
                                        </select>
                                    </div>


                                    <div class="row">
                                        <div class="col-xs-5">
                                            <div class="form-group">
                                                <label>Available Tables</label> <select multiple size="7" id="tables" class="form-control"></select>
                                            </div>
                                        </div>
                                        <div class="col-xs-1">
                                            <div class="form-group">
                                                <div class="btn-group-vertical" style="margin-top: 30px; margin-left: 10px">
                                                    <input type="button" class="btn btn-primary" value=">" onclick="moveSelectedTables()" /><input
                                                        type="button" class="btn btn-primary" value=">>" onclick="moveAllTables()" /><input type="button"
                                                        class="btn btn-primary" value="<" onclick=" removeSelectedTables()"/> <input type="button"
                                                        class="btn btn-primary" value="<<" onclick=" removeAllTables()"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label>Selected Tables</label><select multiple size="7" id="selectedTables" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>




                                </div>
                                <div id="column" class="tab-pane fade">
                                    <div class="form-group">
                                        <label for="schema">Table</label> <select id="table" class="form-control" name="table"
                                            onchange="listTableColumns(this.value)">
                                        </select>
                                    </div>


                                    <form id="columns" class="form-inline">
                                        <!-- 
  <div class="checkbox">
    <label><input type="checkbox"> Column</label>
  </div>
  <div class="form-group">
    <input type="text" class="form-control" id="email" placeholder="Label...">
  </div>
  <div class="form-group">
    <select id="type" class="form-control"></select>
    </div>
  <div class="form-group">
    <input type="text" class="form-control" id="email" placeholder="Order..">
  </div>
  <div class="form-group">
    <input type="text" class="form-control" id="email" placeholder="Mask...">
  </div>
  <div class="form-group">
    <select id="type" class="form-control"></select>
    </div>
  <div class="form-group">
    <select id="type" class="form-control" placeholder="Filter.."></select>
    </div>
  <div class="form-group">
    <input type="text" class="form-control" id="email" placeholder="Comment...">
  </div>
 -->
                                    </form>
                                    <button type="submit" class="btn btn-primary" onclick="saveColumnMapping()">Save</button>




                                </div>
                            </div>
                        </div>




                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
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
<script>
var loading = $.loading();
</script>

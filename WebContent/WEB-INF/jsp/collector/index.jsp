<%@include file="header.jsp"%>

<style>
#alfabet-bar {
    text-align: center;
    padding: 4px 0px;
    background: #f6f6f6;
    border-top: 1px solid #aaa;
    border-bottom: 1px solid #aaa;
}

.toolbar-button {
    /*background: #f0f0f0;*/
    padding: 8px;
}

.shadow {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
        rgba(0, 0, 0, 0.19);
}

.center {
    display:table-cell;
    vertical-align:middle;
    float:none;
}
</style>




<div class="content-wrapper">
    <section class="content-header"></section>
        <section class="content">
            <div class="row">
                <i class="fa fa-th-list fa-lg"></i> <i class="fa fa-th fa-lg"></i> <i class="fa fa-bars fa-lg"></i>
                <!-- 
                <i class="fa fa-folder-open fa-lg"></i>
                <i class="fa fa-caret-down"></i>
                <i class="fa fa-archive fa-lg"></i>
                <i class="fa fa-caret-down"></i>
                <i class="fa fa-check-square-o fa-lg"></i>
                <i class="fa fa-caret-down"></i>
                <i class="fa fa-list-alt fa-lg"></i>
                <i class="fa fa-caret-down"></i>
                <i class="fa fa-archive fa-lg fa-fw"></i>
                <i class="fa fa-check-square-o fa-lg fa-fw"></i>
                <i class="fa fa-list-alt fa-lg fa-fw"></i>
                <i class="fa fa-caret-down"></i>
                <i class="fa fa-plus fa-lg"></i>
                <i class="fa fa-lg fa-check-square-o"></i>
                <i class="fa fa-sort-amount-asc fa-lg"></i>
                <i class="fa fa-caret-down"></i>
                 -->
            </div>
            <div class="row">
                <div id="alfabet-bar">
                    <a href="?letter=none" class="toolbar-button available active">ALL</a> <a href="?letter=1" class="toolbar-button unavailable ">#</a> <a
                        href="?letter=A" class="toolbar-button unavailable ">A</a> <a href="?letter=B" class="toolbar-button unavailable ">B</a> <a href="?letter=C"
                        class="toolbar-button unavailable ">C</a> <a href="?letter=D" class="toolbar-button available ">D</a> <a href="?letter=E"
                        class="toolbar-button unavailable ">E</a> <a href="?letter=F" class="toolbar-button unavailable ">F</a> <a href="?letter=G"
                        class="toolbar-button unavailable ">G</a> <a href="?letter=H" class="toolbar-button unavailable ">H</a> <a href="?letter=I"
                        class="toolbar-button unavailable ">I</a> <a href="?letter=J" class="toolbar-button unavailable ">J</a> <a href="?letter=K"
                        class="toolbar-button unavailable ">K</a> <a href="?letter=L" class="toolbar-button unavailable ">L</a> <a href="?letter=M"
                        class="toolbar-button unavailable ">M</a> <a href="?letter=N" class="toolbar-button unavailable ">N</a> <a href="?letter=O"
                        class="toolbar-button unavailable ">O</a> <a href="?letter=P" class="toolbar-button available ">P</a> <a href="?letter=Q"
                        class="toolbar-button unavailable ">Q</a> <a href="?letter=R" class="toolbar-button unavailable ">R</a> <a href="?letter=S"
                        class="toolbar-button unavailable ">S</a> <a href="?letter=T" class="toolbar-button unavailable ">T</a> <a href="?letter=U"
                        class="toolbar-button unavailable ">U</a> <a href="?letter=V" class="toolbar-button unavailable ">V</a> <a href="?letter=W"
                        class="toolbar-button unavailable ">W</a> <a href="?letter=X" class="toolbar-button unavailable ">X</a> <a href="?letter=Y"
                        class="toolbar-button unavailable ">Y</a> <a href="?letter=Z" class="toolbar-button unavailable ">Z</a>
                </div>
            </div>
            <div class="row">
                <div>&nbsp;</div>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box shadow">
                        <div style="background: url(images/database.png) no-repeat center center; width: 96px; height: 96px; float: left;"></div>
    
                        <div class="info-box-content">
                            <span class="info-box-number">${gameInfo.name} (${system})</span> 
                            <span class="info-box-more"><strong>Genre:</strong> ${gameInfo.genre}</span>
                            <span class="info-box-more"><strong>Developer:</strong> ${gameInfo.developer}</span> 
                            <span class="info-box-more"><strong>Release Date:</strong> ${gameInfo.releasedate}</span> 
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box shadow">
                        <div style="background: url(images/database.png) no-repeat center center; width: 96px; height: 96px; float: left;"></div>
    
                        <div class="info-box-content">
                            <span class="info-box-number">${gameInfo.name} (${system})</span> 
                            <span class="info-box-more"><strong>Genre:</strong> ${gameInfo.genre}</span>
                            <span class="info-box-more"><strong>Developer:</strong> ${gameInfo.developer}</span> 
                            <span class="info-box-more"><strong>Release Date:</strong> ${gameInfo.releasedate}</span> 
                        </div>
                    </div>
                </div>
                <div class="clearfix visible-sm-block"></div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box shadow">
                        <div style="background: url(images/database.png) no-repeat center center; width: 96px; height: 96px; float: left;"></div>
    
                        <div class="info-box-content">
                            <span class="info-box-number">${gameInfo.name} (${system})</span> 
                            <span class="info-box-more"><strong>Genre:</strong> ${gameInfo.genre}</span>
                            <span class="info-box-more"><strong>Developer:</strong> ${gameInfo.developer}</span> 
                            <span class="info-box-more"><strong>Release Date:</strong> ${gameInfo.releasedate}</span> 
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box shadow">
                        <div style="background: url(images/database.png) no-repeat center center; width: 96px; height: 96px; float: left;"></div>
    
                        <div class="info-box-content">
                            <span class="info-box-number">${gameInfo.name} (${system})</span> 
                            <span class="info-box-more"><strong>Genre:</strong> ${gameInfo.genre}</span>
                            <span class="info-box-more"><strong>Developer:</strong> ${gameInfo.developer}</span> 
                            <span class="info-box-more"><strong>Release Date:</strong> ${gameInfo.releasedate}</span> 
                        </div>
                    </div>
                </div>
            </div>

        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary shadow">
                    <div class="box-header with-border">
                      <h3 class="box-title">${gameInfo.name} (${system})</h3>
                    </div>
                    <div class="box-body">
                        <div class="row">              
                            <div class="col-md-4">
                                <img class="img-responsive center-block center" src="images/database.png">
                            </div>
                            <div class="col-md-4">
                                <span class="info-box-number">${gameInfo.name} (${system})</span> 
                                <span class="info-box-more"><strong>Genre:</strong> ${gameInfo.genre}</span>
                                <span class="info-box-more"><strong>Developer:</strong> ${gameInfo.developer}</span> 
                                <span class="info-box-more"><strong>Release Date:</strong> ${gameInfo.releasedate}</span> 
                            </div>
                            <div class="col-md-4">                        
                                <span class="info-box-more"><strong>Publisher:</strong> ${gameInfo.publisher}</span>
                                <span class="info-box-more"><strong>Players:</strong> ${gameInfo.players}</span>
                                <span class="info-box-more"><strong>Rating:</strong> ${gameInfo.rating}</span> 
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        ${gameInfo.desc}
                    </div>
                </div>
            </div>
        </div>
    </section>
    
</div>


<%@include file="footer.jsp"%>

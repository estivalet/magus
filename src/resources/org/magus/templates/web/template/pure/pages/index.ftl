<%@include file="header.jsp" %>

<div id="content">



<style>


</style>

<div class="container">
    <div class="header">
        <h3>Header</h3>
    </div>
    <div class="mainbody">
        <div class="field">
            <label>Simple label</label> <input type="text" /> <small>tip</small>
        </div>
        <div class="field">
            <label>Label with more text</label> <input type="text" />
        </div>
        <div class="field">
            <label>Short</label> <input type="text" />
        </div>
        <div class="field">
            <label>Radio</label> <input type="radio" id="r1" name="r1"/>Radio 1<br/><input type="radio"  name="r1" id="r1"/>Radio 2<br/><input  id="r1" type="radio" name="r1"/>Radio 3
        </div>
        <div class="field">
            <label>Check</label> <input type="checkbox" id="r1" name="r1"/>Radio 1<input type="checkbox"  name="r1" id="r1"/>Radio 2<input  id="r1" type="checkbox" name="r1"/>Radio 3
        </div>
        <div class="field">
            <label>Combo</label> 
            <select>
            <option>opt 1</option>
            <option>opt 2</option>
            <option>opt 3</option>
            </select>
        </div>
         <div class="buttons">
            <input type="button" value="submit"/>
        </div>
        
        <div class="table-container">
    <div class="table-header">
        <div class="table-header-text">Header&nbsp;<img style="vertical-align:text-top" src="css/plus.png"/></div>
    </div>
                    <div class="table">
                        <table>
                            <thead>
                                <tr>
                                    <th class="left">Title</th>
                                    <th>Price</th>
                                    <th>Added</th>
                                    <th>Category</th>
                                    <th class="selected last"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">24" LED Monitor</td>
                                    <td class="price">$110.00</td>
                                    <td id="dp1432751156234" class="date">April 25th, 2010 at 4:15 PM</td>
                                    <td class="category">Monitors</td>
                                    <td class="selected last"><img src="css/pimpa_yes.gif">&nbsp;<img src="css/pimpa_no.gif"></td>
                                </tr>
                                <tr>
                                    <td class="title">27" LCD Flat Panel</td>
                                    <td class="price">$150.00</td>
                                    <td id="dp1432751156235" class="date">April 25th, 2010 at 4:15 PM</td>
                                    <td class="category">Monitors</td>
                                    <td class="selected last"><img src="css/pimpa_yes.gif">&nbsp;<img src="css/pimpa_no.gif"></td>
                                </tr>
                                <tr>
                                    <td class="title">6GB 240-Pin DDR3 SDRAM DDR3 1600</td>
                                    <td class="price">$80.00</td>
                                    <td id="dp1432751156236" class="date">April 25th, 2010 at 4:15 PM</td>
                                    <td class="category">Memory</td>
                                    <td class="selected last"><img src="css/pimpa_yes.gif">&nbsp;<img src="css/pimpa_no.gif"></td>
                                </tr>
                                <tr>
                                    <td class="title">500GB 7200 RPM 16MB Cache SATA 3.0Gb/s 3.5</td>
                                    <td class="price">$92.00</td>
                                    <td id="dp1432751156237" class="date">April 25th, 2010 at 4:15 PM</td>
                                    <td class="category">Hard Drives</td>
                                    <td class="selected last"><img src="css/pimpa_yes.gif">&nbsp;<img src="css/pimpa_no.gif"></td>
                                </tr>
                                <tr>
                                    <td class="title">2GB 240-Pin DDR3 SDRAM DDR3 1600</td>
                                    <td class="price">$52.00</td>
                                    <td id="dp1432751156238" class="date">April 25th, 2010 at 4:15 PM</td>
                                    <td class="category">Memory</td>
                                    <td class="selected last"><img src="css/pimpa_yes.gif">&nbsp;<img src="css/pimpa_no.gif"></td>
                                </tr>
                            </tbody>
                        </table>
                                                <!-- pagination -->
                        <div class="pagination pagination-left">
                            <div class="results">
                                <span>showing results 1-10 of 207</span>
                            </div>
                            <ul class="pager">
                                <li class="disabled">prev</li>
                                <li class="current">1</li>
                                <li><a href="">2</a></li>
                                <li><a href="">3</a></li>
                                <li><a href="">4</a></li>
                                <li><a href="">5</a></li>
                                <li class="separator">...</li>
                                <li><a href="">20</a></li>
                                <li><a href="">21</a></li>
                                <li><a href="">next</a></li>
                            </ul>
                        </div>
                        <!-- end pagination -->

                    </div>
                    </div>
        
        <div class="alert-box error">
            <span>error: </span>Write your error message here.
        </div>
        <div class="alert-box success">
            <span>success: </span>Write your success message here.
        </div>
        <div class="alert-box warning">
            <span>warning: </span>Write your warning message here.
        </div>
        <div class="alert-box notice">
            <span>notice: </span>Write your notice message here.
        </div>

        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
        <p>Body</p>
    </div>
    <div class="footer">Footer</div>
</div>




</div>

<#include "footer.ftl">



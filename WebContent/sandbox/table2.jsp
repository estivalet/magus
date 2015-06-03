<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>Pure CSS Fixed Header Variable Width Table</title>
    <!-- JavaScript is only used to sort of the last table in the demo. -->
    <script type="text/javascript" src="../js/jquery-1.5.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery.tablesorter.js"></script>
    <script type="text/javascript">
    $(function() {      
        $("#tablesorter-demo").tablesorter({sortList:[[0,0],[2,1]], widgets: ['zebra']});
        $("#options").tablesorter({sortList: [[0,0]], headers: { 3:{sorter: false}, 4:{sorter: false}}});
    }); 
    </script>
    <style type="text/css">
    
    body {
      padding: 20px;
      background-color: #FFF7DC;
      color: black;
      min-width: 530px;
    }
    h2, h3 {
      width: 100%;
      text-align: center;
      margin: 1.5em 0 .5em 0;
    }
    p {
      width: 50%;
      margin: 10px auto;
    }
    
    a {
      color: black;
      text-decoration: underline;
    }
    a:hover {
      text-decoration: none;
      background-color: #D5ECFF;
    }
    td {
      border-bottom: 1px solid #ccc;
      padding: 5px;
      text-align: left; /* IE */
    }
    td + td {
      border-left: 1px solid #ccc;
    }
    th {
      padding: 0 5px;
      text-align: left; /* IE */
    }
    .header-background {
      border-bottom: 1px solid black;
    }
    
    /* above this is decorative, not part of the test */
    
    .fixed-table-container {
      width: 50%;
      height: 200px;
      border: 1px solid black;
      margin: 10px auto;
      background-color: white;
      /* above is decorative or flexible */
      position: relative; /* could be absolute or relative */
      padding-top: 30px; /* height of header */
      overflow: hidden; /* for nonbreaking junk try adding to rest of tables*/
    }

    .fixed-table-container-inner {
      overflow: auto;
      height: 100%;
    }
     
    .header-background {
      background-color: #D5ECFF;
      height: 30px; /* height of header */
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
    }
    
    table {
      background-color: white;
      width: 100%;
      overflow-x: hidden;
      overflow-y: auto;
    }
    .fixed-table-container.regular {
      padding-top: 0;
    }
    .regular table {
      overflow: auto;
    }
    .regular thead {
      background-color: #D5ECFF;
      min-height: 30px;
      border-bottom: 1px solid black;
    }
    .regular th {
      border-bottom: 1px solid black;
      padding: 5px;
    }
    .regular td {
      overflow: hidden;
    }

    .th-inner {
      position: absolute;
      top: 0;
      line-height: 30px; /* height of header */
      text-align: left;
      border-left: 1px solid black;
      padding-left: 5px;
      margin-left: -5px;
    }
    .first .th-inner {
        border-left: none;
        padding-left: 6px;
      }
      
    /* for hidden header hack to calculate widths of dynamic content */
    
    .hidden-head {
      min-width: 530px; /* enough width to show all header text, or bad things happen */
    }
    
    .hidden-header .th-inner {
      position: static;
      overflow-y: hidden;
      height: 0;
      white-space: nowrap;
      padding-right: 5px;
    }
    
    /* for complex headers */
    
    .complex.fixed-table-container {
      padding-top: 60px; /* height of header */
    }
    
    .complex .header-background {
      height: 60px;
    }
    
    .complex-top .th-inner {
      border-bottom: 1px solid black;
      width: 100%
    }
    
    .complex-bottom .th-inner {
      top: 30px;
      width: 100%
    }
    
    .complex-top .third .th-inner { /* double row cell */
      height: 60px;
      border-bottom: none;
      background-color: #D5ECFF;
    }
    
    /* for the lower half of the page. These columns are uniform width but the content wraps. Doesn't solve overflow with table headers.
    The hyphens are not well supported but don't seem to do any harm. */

    .fixed-break table {
      table-layout: fixed;
      word-wrap: break-word;
      -moz-hyphens:auto;
      -ms-hyphens:auto;
      -webkit-hyphens:auto;
      hyphens:auto;
    }

    </style>
  </head>
  <body>
    <h3>Get the full explanation and leave comments at <a href="http://salzerdesign.com/blog/?p=191">salzerdesign.com</a>.</h3>

    <h2>Regular Table</h2>
    <div class="fixed-table-container regular">
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div>First</div>
              </th>
              <th class="second">
                <div>Second</div>
              </th>
              <th class="third">
                <div>Third</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>Last</td>
              <td>Last</td>
              <td>Last</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- This markup is just like the first except the content is different -->
    <h2>Pure CSS Fixed Header Variable Width Table</h2>
    <div class="fixed-table-container">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div class="th-inner">First</div>
              </th>
              <th>
                <div class="th-inner second">Second and Longer</div>
              </th>
              <th>
                <div class="th-inner">Third</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second this has longer content and so forth</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third slightly longer</td>
            </tr>
        <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    
    <!-- This markup is the same except for the hidden header row -->
    <h2>Pure CSS Fixed Header etc. with hidden header for width calculation</h2>
    <div class="fixed-table-container hidden-head">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div class="th-inner">First Column</div>
              </th>
              <th>
                <div class="th-inner second">Second and Longer than Content in the Column</div>
              </th>
              <th>
                <div class="th-inner">Third</div>
              </th>
        </tr>
        <tr class="hidden-header">
        <th class="first">
          <div class="th-inner">First Column</div>
        </th>
        <th>
          <div class="th-inner second">Second and Longer than Content in the Column</div>
        </th>
        <th>
          <div class="th-inner">Third</div>
        </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third slightly longer</td>
            </tr>
        <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <h2>Pure CSS Fixed Header with Complex Header Rows</h2>
    <div class="fixed-table-container complex">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr class="complex-top">
              <th class="first" colspan="2">
                <div class="th-inner">First and Second</div>
              </th>
              <th class="third" rowspan="2">
                <div class="th-inner">Third</div>
              </th>
            </tr>
            <tr class="complex-bottom">
              <th class="first">
                <div class="th-inner">First</div>
              </th>
              <th class="second">
                <div class="th-inner">Second</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>Last</td>
              <td>Last</td>
              <td>Last</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <h2>Same table with header style for <a href="http://tablesorter.com/docs/">jQuery Table Sorter</a> plugin</h2>
    
    <div class="fixed-table-container sort-decoration">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
    <table id="tablesorter-demo" class="tablesorter" cellspacing="0">
          <thead>
        <tr>
          <th class="first">
        <div class="th-inner">
          <span>First Name</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Last Name</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Age</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Total</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Peter</td>
          <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
          <td>28</td>
          <td>$9.99</td>
        </tr>
        <tr>
          <td>John</td>
          <td>Hood</td>
          <td>33</td>
          <td>$19.99</td>
        </tr>
        <tr>
          <td>Clark</td>
          <td>Kent</td>
          <td>18</td>
          <td>$15.89</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Almighty</td>
          <td>45</td>
          <td>$153.19</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Evans</td>
          <td>22</td>
          <td>$13.19</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Evans</td>
          <td>22</td>
          <td>$13.19</td>
        </tr>
        <tr>
          <td>Elizabeth</td>
          <td>Bennet</td>
          <td>20</td>
          <td>$132.19</td>
        </tr>
        <tr>
          <td>Jack</td>
          <td>Bagthorpe</td>
          <td>11</td>
          <td>$10</td>
        </tr>
        <tr>
          <td>Rosie</td>
          <td>Bagthorpe</td>
          <td>9</td>
          <td>$15</td>
        </tr>
      </tbody>
    </table>
      </div>
    </div>
    <p> The sorting is from the <a href="http://jquery.com">jQuery</a> plugin <a href="http://tablesorter.com/docs/">Table Sorter</a>
    written by <a href="http://lovepeacenukes.com">Christian Bach</a>. Please see his site for documentation. This is just showing how the pure
    CSS fixed-header table headers can be styled to show sorting.</p>
    
    <!-- below is fixed -->
    <h2>Regular Table with fixed layout and word-break</h2>
    <div class="fixed-table-container regular fixed-break">
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div>First</div>
              </th>
              <th class="second">
                <div>Second</div>
              </th>
              <th class="third">
                <div>Third</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>Last</td>
              <td>Last</td>
              <td>Last</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- This markup is just like the first except the content is different -->
    <h2>Pure CSS Fixed Header Variable Width Table with fixed layout and word-break</h2>
    <div class="fixed-table-container fixed-break">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div class="th-inner">First</div>
              </th>
              <th>
                <div class="th-inner second" >Second and Longer</div>
              </th>
              <th>
                <div class="th-inner" >Third</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>SecondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfSecondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadfSecondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second this has longer content and so forth</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third slightly longer</td>
            </tr>
        <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    
    <!-- This markup is the same except for the hidden header row -->
    <h2>Pure CSS Fixed Header etc. with hidden header for width calculation with fixed layout and word-break</h2>
    <div class="fixed-table-container hidden-head fixed-break">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr>
              <th class="first">
                <div class="th-inner">First Column</div>
              </th>
              <th>
                <div class="th-inner second">Second and Longer than Content in the Column</div>
              </th>
              <th>
                <div class="th-inner">Third</div>
              </th>
        </tr>
        <tr class="hidden-header">
        <th class="first">
          <div class="th-inner">First Column</div>
        </th>
        <th>
          <div class="th-inner second">Second and Longer than Content in the Column</div>
        </th>
        <th>
          <div class="th-inner">Third</div>
        </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third slightly longer</td>
            </tr>
        <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <h2>Pure CSS Fixed Header with Complex Header Rows with fixed layout and word-break</h2>
    <div class="fixed-table-container complex fixed-break">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
        <table cellspacing="0">
          <thead>
            <tr class="complex-top">
              <th class="first" colspan="2">
                <div class="th-inner">First and Second</div>
              </th>
              <th class="third" rowspan="2">
                <div class="th-inner">Third</div>
              </th>
            </tr>
            <tr class="complex-bottom">
              <th class="first">
                <div class="th-inner">First</div>
              </th>
              <th class="second">
                <div class="th-inner">Second</div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>First</td>
              <td>First</td>
              <td>First</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>First</td>
              <td>Second</td>
              <td>Third</td>
            </tr>
            <tr>
              <td>Last</td>
              <td>Last</td>
              <td>Last</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <h2>Same table with header style for <a href="http://tablesorter.com/docs/">jQuery Table Sorter</a> plugin with fixed layout and word-break</h2>
    
    <div class="fixed-table-container sort-decoration fixed-break">
      <div class="header-background"> </div>
      <div class="fixed-table-container-inner">
    <table id="tablesorter-demo" class="tablesorter" cellspacing="0">
          <thead>
        <tr>
          <th class="first">
        <div class="th-inner">
          <span>First Name</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Last Name</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Age</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
          <th>
        <div class="th-inner">
          <span>Total</span>
          <span class="sortArrow">&nbsp;</span>
        </div>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Peter</td>
          <td>Secondasdfasdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfsadf</td>
          <td>28</td>
          <td>$9.99</td>
        </tr>
        <tr>
          <td>John</td>
          <td>Hood</td>
          <td>33</td>
          <td>$19.99</td>
        </tr>
        <tr>
          <td>Clark</td>
          <td>Kent</td>
          <td>18</td>
          <td>$15.89</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Almighty</td>
          <td>45</td>
          <td>$153.19</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Evans</td>
          <td>22</td>
          <td>$13.19</td>
        </tr>
        <tr>
          <td>Bruce</td>
          <td>Evans</td>
          <td>22</td>
          <td>$13.19</td>
        </tr>
        <tr>
          <td>Elizabeth</td>
          <td>Bennet</td>
          <td>20</td>
          <td>$132.19</td>
        </tr>
        <tr>
          <td>Jack</td>
          <td>Bagthorpe</td>
          <td>11</td>
          <td>$10</td>
        </tr>
        <tr>
          <td>Rosie</td>
          <td>Bagthorpe</td>
          <td>9</td>
          <td>$15</td>
        </tr>
      </tbody>
    </table>
      </div>
    </div>
    <p> The sorting is from the <a href="http://jquery.com">jQuery</a> plugin <a href="http://tablesorter.com/docs/">Table Sorter</a>
    written by <a href="http://lovepeacenukes.com">Christian Bach</a>. Please see his site for documentation. This is just showing how the pure
    CSS fixed-header table headers can be styled to show sorting.</p>
    
    
  </body>
</html>

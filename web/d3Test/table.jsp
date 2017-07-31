<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Simple Grid</title>
    <!-- grid.simple.min.css, grid.simple.min.js -->
    <link rel="stylesheet" href="http://bsgrid.oschina.mopaas.com/builds/merged/bsgrid.all.min.css"/>
    <script type="text/javascript" src="http://bsgrid.oschina.mopaas.com/plugins/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="http://bsgrid.oschina.mopaas.com/builds/js/lang/grid.zh-CN.min.js"></script>
    <script type="text/javascript" src="http://bsgrid.oschina.mopaas.com/builds/merged/bsgrid.all.min.js"></script>
</head>
<body style="background-color: #fff;">
<table id="searchTable">
    <tr>
        <th w_index="XH" width="5%;">XH</th>
        <th w_index="ID" width="5%;">ID</th>
        <th w_index="CHAR" w_align="left" width="1%;">CHAR</th>
        <th w_index="TEXT" w_align="left" width="30%;">TEXT</th>
        <th w_index="DATE" width="1%;">DATE</th>
        <th w_index="TIME" width="15%;">TIME</th>
        <th w_index="NUM" width="5%;">NUM</th>
        <th w_render="operate" width="10%;">Operate</th>
    </tr>
</table>
<script type="text/javascript">
    var gridObj;
    $(function () {
    	//url: '<%=request.getContextPath() %>/search?method=searchJsonData&from=0&size=10',
        gridObj = $.fn.bsgrid.init('searchTable', {
            url: 'http://localhost/realTimeWeb/d3Test/table_json.jsp?method=test',
            // autoLoad: false,
            pageSizeSelect: true,
            pageSize: 10,
            processUserdata: function (userdata, options) {
                $('#searchTable tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
                var cNum = dynamic_columns.length;
                for (var i = 0; i < cNum; i++) {
                    $('#searchTable tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
    });

    function operate(record, rowIndex, colIndex, options) {
        return '<a href="#" onclick="alert(\'ID=' + gridObj.getRecordIndexValue(record, 'ID') + '\');">Operate</a>';
    }
</script>
</body>
</html>
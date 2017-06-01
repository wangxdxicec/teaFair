<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/tpl/user/managerrole/head.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>金泓信展商管理后台</title>
    <style>
        body {
            margin: 0px;
            padding: 0px;
            width: 100%;
            height: 100%;
        }

        input {
            width: 200px;
            height: 20px;
        }
    </style>
</head>
<body>
<!-- 展商visa列表 -->
<div id="tvisatabs" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
	<div title="展商visa列表" style="padding:5px">
		<table id="tvisa" data-options="url:'${base}/user/queryTVisaByPage',
         						   loadMsg: '数据加载中......',
						           singleSelect:false,	//只能当行选择：关闭
						           fit:true,
						           fitColumns:true,
						           idField:'id',
								   toolbar:'#tvisaBar',
						           rownumbers: 'true',
						           pagination:'true',
						           pageSize:'20'">
			<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field: 'passportName', width: $(this).width() / 6">
					<span id="sPassportName" class="sortable">姓名</span><br/>
					<input id="tvisaPassportName" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'nationality', width: $(this).width() / 6">
					<span id="sNationality" class="sortable">国籍</span><br/>
					<input id="tvisaNationality" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'companyName', width: $(this).width() / 6">
					<span id="sCompanyName" class="sortable">公司</span><br/>
					<input id="tvisaCompanyName" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'updateTime', formatter:formatDatebox, width: $(this).width() / 6">
					<span id="supdateTime" class="sortable">更新时间</span><br/>
					<input id="updateTime" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
				<th data-options="field: 'id', formatter:formatImage, width: $(this).width() / 6">
					查看护照图片<br/>
				</th>
				<th data-options="field: 'createTime', formatter:formatDatebox, width: $(this).width() / 6">
					<span id="screateTime" class="sortable">登记时间</span><br/>
					<input id="createTime" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
				</th>
			</tr>
			</thead>
		</table>
	</div>
</div>
<!-- 导出所选展商到Excel -->
<form id="exportTVisasToExcel" action="${base}/user/exportTVisasToExcel" method="post">
	<div id="vidParm1"></div>
</form>
<!-- 工具栏 -->
<div id="tvisaBar">
    <div>
		<div class="easyui-menubutton" menu="#export" iconCls="icon-redo">导出</div>
    </div>
	<div id="export" style="width:180px;">
		<div id="exportAllVisas" iconCls="icon-redo">所有VISA信息到Excel</div>
		<div id="exportSelectedVisas" iconCls="icon-redo">所选VISA信息到Excel</div>
	</div>
</div>

<script>
	var checkedItems = [];
	var country = [];
	var sort = "";
	var order = "asc";
	var vidParm1 = document.getElementById("vidParm1");
//----------------------------------------------------工具栏函数开始--------------------------------------------------------//
	//导出所有VISA信息到Excel
	$('#exportAllVisas').click(function(){
//		$.messager.alert('提示', '开发中');
		vidParm1.innerHTML = "";
		var node = "<input type='hidden' name='vids' value='-1'/>";
		vidParm1.innerHTML += node;
		document.getElementById("exportTVisasToExcel").submit();
		$.messager.alert('提示', '导出所有展商成功');
	});
	//导出所选VISA信息到Excel
	$('#exportSelectedVisas').click(function(){
//		$.messager.alert('提示', '开发中');
//     	alert(checkedItems);
		vidParm1.innerHTML = "";
//     	alert(vidParm1.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='vids' value='"+checkedItems[i]+"'/>";
				vidParm1.innerHTML += node;
			}
//         	alert(vidParm1.innerHTML);
			document.getElementById("exportTVisasToExcel").submit();
			$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
//----------------------------------------------------工具栏函数结束--------------------------------------------------------//
//----------------------------------------------------自定义函数开始--------------------------------------------------------//
	//国家显示
	function formatCountry(val, row) {
		if (val != null) {
			if(val == 44) return country[0].chineseName;
			if(val > 0 && val <= 43){
				return country[val].chineseName;
			}else if(val > 43 && val <= 240){
				return country[val - 1].chineseName;
			}else{
				return null;
			}
		} else {
			return null;
		}
	}
	//显示护照
	function formatImage(val, row) {
		if (row.passportPage != null) {
			return "<a href='${base}/user/showPassportPage?vid=" + val + "' target='_blank'>查看</a>";
		} else {
			return null;
		}
	}
	//日期时间格式转换
	function formatDatebox(value) {
		if (value == null || value == '') {
			return '';
		}
		var dt;
		if (value instanceof Date) {
			dt = value;
		}
		else {
			dt = new Date(value);
			if (isNaN(dt)) {
				value = value.replace(/\/Date\((-?\d+)\)\//, '$1'); //标红的这段是关键代码，将那个长字符串的日期值转换成正常的JS日期格式
				dt = new Date();
				dt.setTime(value);
			}
		}

		return dt.format("yyyy-MM-dd h:m");   //这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法，在后面的步骤3定义
	}

	Date.prototype.format = function (format)
	{
		var o = {
			"M+": this.getMonth() + 1, //month
			"d+": this.getDate(),    //day
			"h+": this.getHours(),   //hour
			"m+": this.getMinutes(), //minute
			"s+": this.getSeconds(), //second
			"q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
			"S": this.getMilliseconds() //millisecond
		}
		if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
				(this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o) if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] :
							("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}

	function filter(){
		var filterParm = "?";
		if(document.getElementById("tvisaPassportName").value != ""){
			filterParm += '&passportName=' + document.getElementById("tvisaPassportName").value;
		}
		if(document.getElementById("tvisaNationality").value != ""){
			filterParm += '&nationality=' + document.getElementById("tvisaNationality").value;
		}
		if(document.getElementById("tvisaCompanyName").value != ""){
			filterParm += '&companyName=' + document.getElementById("tvisaCompanyName").value;
		}
		if(document.getElementById("updateTime").value != ""){
			filterParm += '&updateTime=' + document.getElementById("updateTime").value;
		}
		if(document.getElementById("createTime").value != ""){
			filterParm += '&createTime=' + document.getElementById("createTime").value;
		}
		$('#tvisa').datagrid('options').url = '${base}/user/queryTVisaByPage' + filterParm;
		$('#tvisa').datagrid('reload');
		/*$('#tvisa').datagrid('reload', {
			passportName : document.getElementById("tvisaPassportName").value,
			nationality : document.getElementById("tvisaNationality").value,
			companyName : document.getElementById("tvisaCompanyName").value,
			createTime : document.getElementById("createTime").value,
			sort : sort,
			order : order
		});*/
	}
//----------------------------------------------------自定义函数结束--------------------------------------------------------//
    $(document).ready(function () {

    	// 国外展商VISA信息列表渲染
        $('#tvisa').datagrid({
       		onSelect:function (rowIndex, rowData){
	        	var row = $('#tvisa').datagrid('getSelections');
				for (var i = 0; i < row.length; i++) {
					if (findCheckedItem(row[i].id) == -1) {
						checkedItems.push(row[i].id);
					}
				}
//					alert(checkedItems);
	        },
	        onUnselect:function (rowIndex, rowData){
				var k = findCheckedItem(rowData.id);
				if (k != -1) {
					checkedItems.splice(k, 1);
				}
//					alert(checkedItems);
	        },
	        onSelectAll:function (rows){
	        	for (var i = 0; i < rows.length; i++) {
	        		var k = findCheckedItem(rows[i].id);
					if (k == -1) {
						checkedItems.push(rows[i].id);
					}
				}
//					alert(checkedItems);
	        },
	        onUnselectAll:function (rows){
	        	for (var i = 0; i < rows.length; i++) {
					var k = findCheckedItem(rows[i].id);
					if (k != -1) {
						checkedItems.splice(k, 1);
					}
				}
// 					alert(checkedItems);
	        },
			onDblClickRow: function (index, field, value) {
				if(field.passportName != ""){
					if (!$("#tvisatabs").tabs("exists", field.passportName)) {
						$('#tvisatabs').tabs('add', {
							title: field.passportName,
							content:'<iframe frameborder="0" src="'+ "${base}/user/tVisaDetailInfo?id=" + field.id+'" style="width:100%;height:99%;"></iframe>',
							closable: true
						});
					} else {
						$("#tvisatabs").tabs("select", field.passportName);
					}
				}
			}
        }).datagrid('getPager').pagination({
            pageSize: 20,//每页显示的记录条数，默认为10
            pageList: [10,20,30,40,50],//可以设置每页记录条数的列表
            beforePageText: '第',//页数文本框前显示的汉字
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
        function findCheckedItem(id) {
			for (var i = 0; i < checkedItems.length; i++) {
				if (checkedItems[i] == id) return i;
			}
			return -1;
		}
		$("#tvisa").data().datagrid.dc.view.find("div.datagrid-header td .sortable").click(function(){
			//sort = $(this).prop("id").substr(1, $(this).prop("id").length);
			if(order == "asc"){
				$('#tvisa').datagrid('reload', {
					passportName : document.getElementById("tvisaPassportName").value,
					nationality : document.getElementById("tvisaNationality").value,
					companyName : document.getElementById("tvisaCompanyName").value,
					createTime : document.getElementById("createTime").value,
					sort : sort,
					order : order
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0] + " ▲");
				order = "desc";
			}else if(order == "desc"){
				$('#tvisa').datagrid('reload', {
					passportName : document.getElementById("tvisaPassportName").value,
					nationality : document.getElementById("tvisaNationality").value,
					companyName : document.getElementById("tvisaCompanyName").value,
					createTime : document.getElementById("createTime").value,
					sort : sort,
					order : order
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0] + " ▼");
				order = "null";
			}else{
				$('#tvisa').datagrid('reload', {
					passportName : document.getElementById("tvisaPassportName").value,
					nationality : document.getElementById("tvisaNationality").value,
					companyName : document.getElementById("tvisaCompanyName").value,
					updateTime : document.getElementById("updateTime").value,
					createTime : document.getElementById("createTime").value,
					sort : sort,
					order : order
				});
				$(this).html($(this).html().split(" ▲")[0].split(" ▼")[0]);
				order = "asc";
			}
		});
    });
</script>
</body>
</html>
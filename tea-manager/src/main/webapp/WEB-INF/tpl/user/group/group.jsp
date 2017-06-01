<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/tpl/user/managerrole/head.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>金泓信展商管理后台</title>
    <link rel="stylesheet" type="text/css" href="${base}/resource/easyui/themes/metro-blue/easyui.css">
    <link rel="stylesheet" type="text/css" href="${base}/resource/easyui/themes/icon.css">
    <script type="text/javascript" src="${base}/resource/jquery.min.js"></script>
    <script type="text/javascript" src="${base}/resource/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${base}/resource/common.js"></script>
    <script type="text/javascript" src="${base}/resource/easyui/easyui-validate.js"></script>
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
<!-- 展团列表 -->
<table id="groups" data-options="url:'${base}/user/queryExhibitorGroupByPage',
         						   loadMsg: '数据加载中......',
						           singleSelect:false,	//只能当行选择：关闭
						           fit:true,
						           fitColumns:true,
								   toolbar:'#groupbar',
						           rownumbers: 'true',
						           pagination:'true',
						           pageSize:'20'">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field: 'groupName', title: '展团中文名', width: $(this).width() / 2">
				展团中文名
			</th>
			<th data-options="field: 'groupNameEn', title: '展团英文名', width: $(this).width() / 2">
				展团英文名
			</th>
		</tr>
	</thead>
</table>
<!-- 展团工具栏 -->
<div id="groupbar">
    <div>
        <div id="addExhibitorGroup" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加展团</div>
        <div id="deleteExhibitorGroups" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除展团</div>
    </div>
</div>
<!-- 添加展团  -->
<div id="addExhibitorGroupDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="addExhibitorGroupForm" name="addExhibitorGroupForm">
        <table style="width: 320px;margin: 20px auto">
			<tr>
				<td style="width: 90px;text-align: right">展团中文名：</td>
				<td><input class="easyui-validatebox" type="text" name="groupName"></td>
			</tr>
			<tr>
				<td style="width: 90px;text-align: right">展团英文名：</td>
				<td><input class="easyui-validatebox" type="text" name="groupNameEn"></td>
			</tr>
        </table>
    </form>
</div>
<!-- 修改展团  -->
<div id="modifyExhibitorGroupDlg" data-options="iconCls:'icon-edit',modal:true">
    <form id="modifyExhibitorGroupForm" name="modifyExhibitorGroupForm">
        <table style="width: 320px;margin: 20px auto">
			<tr>
				<td style="width: 90px;text-align: right">展团中文名：</td>
				<td><input class="easyui-validatebox" type="text" name="groupName"></td>
			</tr>
			<tr>
				<td style="width: 90px;text-align: right">展团英文名：</td>
				<td><input class="easyui-validatebox" type="text" name="groupNameEn"></td>
			</tr>
			<input type="hidden" value="" name="id">
        </table>
    </form>
</div>

<script>
	var checkedItems = [];
//----------------------------------------------------工具栏函数开始--------------------------------------------------------//
	$('#addExhibitorGroup').click(function(){
		document.getElementById("addExhibitorGroupForm").reset();
		$("#addExhibitorGroupDlg").dialog("open");
	});
	$('#deleteExhibitorGroups').click(function(){
		$.messager.confirm('确认删除','你确定要删除展团吗?',function(r){
		    if (r){
		    	if(checkedItems.length > 0){
		    		$.ajax({
		                url: "${base}/user/deleteExhibitorGroups",
		                type: "post",
		                dataType: "json",
		                data: {"ids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#groups").datagrid("reload");
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '删除成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
		        	$.messager.alert('提示', '删除展团成功');
				}else{
					$.messager.alert('提示', '请至少选择一项展团再删除');
				}
		    }
		});
	});
//----------------------------------------------------工具栏函数结束--------------------------------------------------------//
    $(document).ready(function () {
    	// 文章列表渲染
        $('#groups').datagrid({
       		onSelect:function (rowIndex, rowData){
	        	var row = $('#groups').datagrid('getSelections');
				for (var i = 0; i < row.length; i++) {
					if (findCheckedItem(row[i].id) == -1) {
						checkedItems.push(row[i].id);
					}
				}
// 					alert(checkedItems);
	        },
	        onUnselect:function (rowIndex, rowData){
				var k = findCheckedItem(rowData.id);
				if (k != -1) {
					checkedItems.splice(k, 1);
				}
// 					alert(checkedItems);
	        },
	        onSelectAll:function (rows){
	        	for (var i = 0; i < rows.length; i++) {
	        		var k = findCheckedItem(rows[i].id);
					if (k == -1) {
						checkedItems.push(rows[i].id);
					}
				}
// 					alert(checkedItems);
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
	        	document.modifyExhibitorGroupForm.id.value = field.id;
	        	document.modifyExhibitorGroupForm.groupName.value = field.groupName;
	        	document.modifyExhibitorGroupForm.groupNameEn.value = field.groupNameEn;
	        	$("#modifyExhibitorGroupDlg").dialog("open");
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
    	
     	// 添加展团弹出框
        $('#addExhibitorGroupDlg').dialog({
            title: '添加展团',
            width: 350,
            height: 180,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    handler: function () {
                    	if ($("#addExhibitorGroupForm").form("validate")) {
                        	if(document.addExhibitorGroupForm.groupName.value.trim() != "" || document.addExhibitorGroupForm.groupNameEn.value.trim() != ""){
                        		$.ajax({
                                    url: "${base}/user/addExhibitorGroup",
                                    type: "post",
                                    dataType: "json",
                                    data: $("#addExhibitorGroupForm").serializeJson(),
                                    success: function (data) {
                                        if (data.resultCode == 0) {
                                            $("#groups").datagrid("reload");
                                            $("#addExhibitorGroupDlg").dialog("close");
                                            $.messager.show({
                                                title: '成功',
                                                msg: '添加展团成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
                                            $("#addExhibitorGroupForm").clearForm();
                                        } else if (data.resultCode == 2) {
                                            $.messager.alert('错误', data.description);
                                        } else {
                                            $.messager.alert('错误', '系统错误');
                                        }
                                    }
                                });
                        	}else{
                        		$.messager.alert('错误', '展团中文名或英文名至少要填一个');
                        	}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("addExhibitorGroupForm").reset();
                    	$("#addExhibitorGroupDlg").dialog("close");
                    }
                }
            ]
        });
		// 修改展团弹出框
        $('#modifyExhibitorGroupDlg').dialog({
            title: '修改展团',
            width: 350,
            height: 180,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    handler: function () {
                    	if ($("#modifyExhibitorGroupForm").form("validate")) {
                        	if(document.modifyExhibitorGroupForm.groupName.value.trim() != "" || document.modifyExhibitorGroupForm.groupNameEn.value.trim() != ""){
                        		$.ajax({
                                    url: "${base}/user/modifyExhibitorGroup",
                                    type: "post",
                                    dataType: "json",
                                    data: $("#modifyExhibitorGroupForm").serializeJson(),
                                    success: function (data) {
                                        if (data.resultCode == 0) {
                                            $("#groups").datagrid("reload");
                                            $("#modifyExhibitorGroupDlg").dialog("close");
                                            $.messager.show({
                                                title: '成功',
                                                msg: '添加展团成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
                                            $("#modifyExhibitorGroupForm").clearForm();
                                        } else if (data.resultCode == 2) {
                                            $.messager.alert('错误', data.description);
                                        } else {
                                            $.messager.alert('错误', '系统错误');
                                        }
                                    }
                                });
                        	}else{
                        		$.messager.alert('错误', '展团中文名或英文名至少要填一个');
                        	}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorGroupForm").reset();
                    	$("#modifyExhibitorGroupDlg").dialog("close");
                    }
                }
            ]
        });
    });
</script>
</body>
</html>
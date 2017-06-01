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
<!-- 标签列表 -->
<table id="tags" pagination="true" pageSize="20"></table>
<!-- 添加所属人表单 -->
<div id="addTagDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="addTagForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: center">所属人：</td>
                <td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></td>
            </tr>
        </table>
    </form>
</div>
<!-- 修改所属人表单 -->
<div id="modifyTagDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyTagForm" name="modifyTagForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: center">所属人：</td>
                <td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></td>
            </tr>
        </table>
        <input type="hidden" value="" name="id" />
    </form>
</div>
<script>
	var checkedItems = [];
	// 工具栏按钮
    var tagbar = [
        {
            text: '添加所属人',
            iconCls: 'icon-add',
            handler: function () {
            	$("#addTagDlg").dialog("open");
            }
        },
        {
            text: '删除所属人',
            iconCls: 'icon-remove',
            handler: function () {
            	if(checkedItems.length > 0){
            		$.messager.confirm('确认删除','你确定要删除所属人吗?',function(r){
	        		    if (r){
                    		$.ajax({
                                url: "${base}/user/removeTags",
                                type: "post",
                                dataType: "json",
                                data: {"tids": checkedItems},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                        $.messager.show({
                                            title: '成功',
                                            msg: '删除成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                        $("#tags").datagrid("reload");
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                        	$.messager.alert('提示', '删除所属人成功');
	        		    }
        			});
            	}else{
    				$.messager.alert('提示', '请至少选择一项所属人再删除');
    			}
            }
        }
    ];
    
    $(document).ready(function () {
    	// 文章列表渲染
        $("#tags").datagrid({
            url: '${base}/user/queryTags',
            singleSelect:false,	//只能当行选择：关闭
            fit:true,
            fitColumns:true,
            toolbar:tagbar,
            rownumbers: true,
            columns: [
                [
    				{field: 'ck', checkbox:true }, 
                    {field: 'name', title: '所属人', width: 100}
                ]
            ],
            onSelect:function (rowIndex, rowData){
            	var row = $('#tags').datagrid('getSelections');
				for (var i = 0; i < row.length; i++) {
					if (findCheckedItem(row[i].id) == -1) {
						checkedItems.push(row[i].id);
					}
				}
// 				alert(checkedItems);
            },
            onUnselect:function (rowIndex, rowData){
				var k = findCheckedItem(rowData.id);
				if (k != -1) {
					checkedItems.splice(k, 1);
				}
// 				alert(checkedItems);
            },
            onSelectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
            		var k = findCheckedItem(rows[i].id);
					if (k == -1) {
						checkedItems.push(rows[i].id);
					}
				}
// 				alert(checkedItems);
            },
            onUnselectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
					var k = findCheckedItem(rows[i].id);
					if (k != -1) {
						checkedItems.splice(k, 1);
					}
				}
// 				alert(checkedItems);
            },
            onDblClickRow: function (index, field, value) {
            	document.modifyTagForm.id.value = field.id;
            	document.modifyTagForm.name.value = field.name;
            	$("#modifyTagDlg").dialog("open");
            }
        });
        function findCheckedItem(id) {
			for (var i = 0; i < checkedItems.length; i++) {
				if (checkedItems[i] == id) return i;
			}
			return -1;
		}
        
		// 添加所属人标签
        $('#addTagDlg').dialog({
            title: '添加所属人',
            width: 350,
            height: 150,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    iconCls: 'icon-ok',
                    handler: function () {
                        if ($("#addTagForm").form("validate")) {
                            $.ajax({
                                url: "${base}/user/addTag",
                                type: "post",
                                dataType: "json",
                                data: $("#addTagForm").serializeJson(),
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                        $("#tags").datagrid("reload");
                                        $("#addTagDlg").dialog("close");
                                        $.messager.show({
                                            title: '成功',
                                            msg: '添加展商账号成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                        $("#addTagForm").clearForm();
                                    } else if (data.resultCode == 2) {
                                        $.messager.alert('错误', '所属人冲突');
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("addTagForm").reset();  
                    	$("#addTagDlg").dialog("close");
                    }
                }
            ]
        });
        $('#modifyTagDlg').dialog({
            title: '修改所属人',
            width: 350,
            height: 150,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    handler: function () {
                    	if ($("#modifyTagForm").form("validate")) {
                            $.ajax({
                                url: "${base}/user/modifyTag",
                                type: "post",
                                dataType: "json",
                                data: $("#modifyTagForm").serializeJson(),
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                        $("#tags").datagrid("reload");
                                        $("#modifyTagDlg").dialog("close");
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改所属人成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyTagForm").reset();
                    	$("#modifyTagDlg").dialog("close");
                    }
                }
            ]
        });
    });
</script>
</body>
</html>
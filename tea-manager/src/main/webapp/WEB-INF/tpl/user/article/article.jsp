<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/tpl/user/managerrole/head.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>金泓信展商管理后台</title>
    <script src="${base}/resource/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="${base}/resource/ckeditor/samples/sample.css">
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
<!-- 公告列表 -->
<table id="articles" data-options="url:'${base}/user/queryArticlesByPage',
         						   loadMsg: '数据加载中......',
						           singleSelect:false,	//只能当行选择：关闭
						           fit:true,
						           fitColumns:true,
								   toolbar:'#articlebar',
						           rownumbers: 'true',
						           pagination:'true',
						           pageSize:'20'">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field: 'title', title: '公告标题', width: $(this).width() / 6">
				公告标题<br/>
				<input id="articleTitle" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
			<th data-options="field: 'digest', title: '公告摘要', width: $(this).width() / 6">
				公告摘要<br/>
				<input id="articleAbstract" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
			<th data-options="field: 'content', title: '公告正文', width: $(this).width() / 6">
				公告正文<br/>
				<input id="articleContent" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
			<th data-options="field: 'titleEn', title: 'Title', width: $(this).width() / 6">
				Title<br/>
				<input id="articleTitleEn" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
			<th data-options="field: 'digestEn', title: 'Abstract', width: $(this).width() / 6">
				Abstract<br/>
				<input id="articleAbstractEn" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
			<th data-options="field: 'contentEn', title: 'Content', width: $(this).width() / 6">
				Content<br/>
				<input id="articleContentEn" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
			</th>
		</tr>
	</thead>
</table>
<!-- 工具栏 -->
<div id="articlebar">
    <div>
        <div id="addArticle" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加公告</div>
        <div id="deleteArticles" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除公告</div>
    </div>
</div>
<!-- 添加公告  -->
<div id="addArticleDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="addArticleForm" name="addArticleForm">
        <table style="width: 100%;height: 100%;">
        	<tr>
                <td>
                	<table style="width: 100%;height: 100%;">
                		<tr>
                			<td style="width: 90px;text-align: right">公告标题：</td>
			                <td><input class="easyui-validatebox" type="text" name="title"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">公告摘要：</td>
			                <td><input class="easyui-validatebox" type="text" name="digest"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">公告正文：</td>
			                <td></td>
                		</tr>
                		<tr>
                			<td colspan="2">
                				<textarea name="content" id="addContent"></textarea>
                			</td>
                		</tr>
                	</table>
                </td>
                <td>
                	<table style="width: 100%;height: 100%;">
                		<tr>
			                <td style="width: 90px;text-align: right">Title：</td>
			                <td><input class="easyui-validatebox" type="text" name="titleEn"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">Abstract：</td>
			                <td><input class="easyui-validatebox" type="text" name="digestEn"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">content：</td>
			                <td></td>
                		</tr>
                		<tr>
                			<td colspan="2">
                				<textarea name="contentEn" id="addContentEn"></textarea>
                			</td>
                		</tr>
                	</table>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 修改公告  -->
<div id="modifyArticleDlg" data-options="iconCls:'icon-edit',modal:true">
    <form id="modifyArticleForm" name="modifyArticleForm">
        <table style="width: 100%;height: 100%;">
        	<tr>
                <td>
                	<table style="width: 100%;height: 100%;">
                		<tr>
                			<td style="width: 90px;text-align: right">公告标题：</td>
			                <td><input class="easyui-validatebox" type="text" name="title"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">公告摘要：</td>
			                <td><input class="easyui-validatebox" type="text" name="digest"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">公告正文：</td>
			                <td></td>
                		</tr>
                		<tr>
                			<td colspan="2">
                				<textarea name="content" id="modifyContent"></textarea>
                			</td>
                		</tr>
                	</table>
                </td>
                <td>
                	<table style="width: 100%;height: 100%;">
                		<tr>
			                <td style="width: 90px;text-align: right">Title：</td>
			                <td><input class="easyui-validatebox" type="text" name="titleEn"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">Abstract：</td>
			                <td><input class="easyui-validatebox" type="text" name="digestEn"></td>
                		</tr>
                		<tr>
                			<td style="width: 90px;text-align: right">content：</td>
			                <td></td>
                		</tr>
                		<tr>
                			<td colspan="2">
                				<textarea name="contentEn" id="modifyContentEn"></textarea>
                			</td>
                		</tr>
                	</table>
                </td>
            </tr>
        </table>
        <input type="hidden" value="" name="id" />
    </form>
</div>

<script>
	var checkedItems = [];

//----------------------------------------------------CKEDITOR初始化函数开始--------------------------------------------------------//
	CKEDITOR.replace( 'addContent' );
	CKEDITOR.replace( 'addContentEn' );
	CKEDITOR.replace( 'modifyContent' );
	CKEDITOR.replace( 'modifyContentEn' );
	CKEDITOR.config.width = 540;
	CKEDITOR.config.height = 320;
	CKEDITOR.config.toolbarCanCollapse = true;
	CKEDITOR.config.toolbarStartupExpanded = false;
//----------------------------------------------------CKEDITOR初始化函数结束--------------------------------------------------------//
//----------------------------------------------------工具栏函数开始--------------------------------------------------------//
	$('#addArticle').click(function(){
		document.getElementById("addArticleForm").reset();
		CKEDITOR.instances.addContent.setData("");
    	CKEDITOR.instances.addContentEn.setData("");
		$("#addArticleDlg").dialog("open");
	});
	$('#deleteArticles').click(function(){
		$.messager.confirm('确认删除','你确定要删除公告吗?',function(r){
		    if (r){
		    	if(checkedItems.length > 0){
		    		$.ajax({
		                url: "${base}/user/deleteArticles",
		                type: "post",
		                dataType: "json",
		                data: {"ids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	checkedItems = [];
		                    	filter();
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
		        	$.messager.alert('提示', '删除公告成功');
				}else{
					$.messager.alert('提示', '请至少选择一项公告再删除');
				}
		    }
		});
	});
//----------------------------------------------------工具栏函数结束--------------------------------------------------------//
//----------------------------------------------------自定义函数开始--------------------------------------------------------//
	function filter(){
		var filterParm = "?";
		if(document.getElementById("articleTitle").value != ""){
			filterParm += '&title=' + document.getElementById("articleTitle").value;
		}
		if(document.getElementById("articleAbstract").value != ""){
			filterParm += '&digest=' + document.getElementById("articleAbstract").value;
		}
		if(document.getElementById("articleContent").value != ""){
			filterParm += '&content=' + document.getElementById("articleContent").value;
		}
		if(document.getElementById("articleTitleEn").value != ""){
			filterParm += '&titleEn=' + document.getElementById("articleTitleEn").value;
		}
		if(document.getElementById("articleAbstractEn").value != ""){
			filterParm += '&digestEn=' + document.getElementById("articleAbstractEn").value;
		}
		if(document.getElementById("articleContentEn").value != ""){
			filterParm += '&contentEn=' + document.getElementById("articleContentEn").value;
		}
		$('#articles').datagrid('options').url = '${base}/user/queryArticlesByPage' + filterParm;
	    $('#articles').datagrid('reload'); 
	}
//----------------------------------------------------自定义函数结束--------------------------------------------------------//

    $(document).ready(function () {
    	// 公告列表渲染
        $('#articles').datagrid({
       		onSelect:function (rowIndex, rowData){
	        	var row = $('#articles').datagrid('getSelections');
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
	        	CKEDITOR.instances.modifyContent.setData(field.content);
	        	CKEDITOR.instances.modifyContentEn.setData(field.contentEn);
	        	document.modifyArticleForm.id.value = field.id;
	        	document.modifyArticleForm.title.value = field.title;
	        	document.modifyArticleForm.digest.value = field.digest;
	        	document.modifyArticleForm.titleEn.value = field.titleEn;
	        	document.modifyArticleForm.digestEn.value = field.digestEn;
	        	$("#modifyArticleDlg").dialog("open");
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
    	
     	// 添加公告弹出框
        $('#addArticleDlg').dialog({
            title: '添加公告',
            width: 700,
            height: 480,
            maximized:true,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    handler: function () {
                    	var addContent = CKEDITOR.instances.addContent.getData();
                    	var addContentEn = CKEDITOR.instances.addContentEn.getData();
                    	document.getElementById("addContent").value = addContent;
                    	document.getElementById("addContentEn").value = addContentEn;
                    	
                    	if ($("#addArticleForm").form("validate")) {
                    		if(document.addArticleForm.title.value.trim() != ""){
                    			if(document.addArticleForm.digest.value.trim() != ""){
                    				if(addContent != ""){
                    					$.ajax({
                                            url: "${base}/user/addArticle",
                                            type: "post",
                                            dataType: "json",
                                            data: $("#addArticleForm").serializeJson(),
                                            success: function (data) {
                                                if (data.resultCode == 0) {
                                                	filter();
                                                    $("#addArticleDlg").dialog("close");
                                                    $.messager.show({
                                                        title: '成功',
                                                        msg: '添加公告成功',
                                                        timeout: 5000,
                                                        showType: 'slide'
                                                    });
                                                } else {
                                                    $.messager.alert('错误', '系统错误');
                                                }
                                            }
                                        });
                    				}else{
                        				$.messager.alert('错误', '请填写中文内容');
                        			}
                    			}else{
                    				$.messager.alert('错误', '请填写中文摘要');
                    			}
                    		}else if(document.addArticleForm.titleEn.value.trim() != ""){
                    			if(document.addArticleForm.digestEn.value.trim() != ""){
                    				if(addContentEn != ""){
                    					$.ajax({
                                            url: "${base}/user/addArticle",
                                            type: "post",
                                            dataType: "json",
                                            data: $("#addArticleForm").serializeJson(),
                                            success: function (data) {
                                                if (data.resultCode == 0) {
                                                	filter();
                                                    $("#addArticleDlg").dialog("close");
                                                    $.messager.show({
                                                        title: '成功',
                                                        msg: '添加公告成功',
                                                        timeout: 5000,
                                                        showType: 'slide'
                                                    });
                                                } else {
                                                    $.messager.alert('错误', '系统错误');
                                                }
                                            }
                                        });
                    				}else{
                        				$.messager.alert('错误', '请填写英文内容');
                        			}
                    			}else{
                    				$.messager.alert('错误', '请填写英文摘要');
                    			}
                    		}else{
                    			$.messager.alert('错误', '中英文标题至少填一项');
                    		}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("addArticleForm").reset();
                    	$("#addArticleDlg").dialog("close");
                    }
                }
            ]
        });
		// 修改公告弹出框
        $('#modifyArticleDlg').dialog({
            title: '修改公告',
            width: 700,
            height: 480,
            maximized:true,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    handler: function () {
                    	var modifyContent = CKEDITOR.instances.modifyContent.getData();
                    	var modifyContentEn = CKEDITOR.instances.modifyContentEn.getData();
                    	document.getElementById("modifyContent").value = modifyContent;
                    	document.getElementById("modifyContentEn").value = modifyContentEn;
                    	
                    	if ($("#modifyArticleForm").form("validate")) {
                    		if(document.modifyArticleForm.title.value.trim() != ""){
                    			if(document.modifyArticleForm.digest.value.trim() != ""){
                    				if(modifyContent != ""){
                    					$.ajax({
                                            url: "${base}/user/modifyArticle",
                                            type: "post",
                                            dataType: "json",
                                            data: $("#modifyArticleForm").serializeJson(),
                                            success: function (data) {
                                                if (data.resultCode == 0) {
                                                	filter();
                                                    $("#modifyArticleDlg").dialog("close");
                                                    $.messager.show({
                                                        title: '成功',
                                                        msg: '修改公告成功',
                                                        timeout: 5000,
                                                        showType: 'slide'
                                                    });
                                                } else {
                                                    $.messager.alert('错误', '系统错误');
                                                }
                                            }
                                        });
                    				}else{
                        				$.messager.alert('错误', '请填写中文内容');
                        			}
                    			}else{
                    				$.messager.alert('错误', '请填写中文摘要');
                    			}
                    		}else if(document.modifyArticleForm.titleEn.value.trim() != ""){
                    			if(document.modifyArticleForm.digestEn.value.trim() != ""){
                    				if(modifyContentEn != ""){
                    					$.ajax({
                                            url: "${base}/user/modifyArticle",
                                            type: "post",
                                            dataType: "json",
                                            data: $("#modifyArticleForm").serializeJson(),
                                            success: function (data) {
                                                if (data.resultCode == 0) {
                                                	filter();
                                                    $("#modifyArticleDlg").dialog("close");
                                                    $.messager.show({
                                                        title: '成功',
                                                        msg: '修改公告成功',
                                                        timeout: 5000,
                                                        showType: 'slide'
                                                    });
                                                } else {
                                                    $.messager.alert('错误', '系统错误');
                                                }
                                            }
                                        });
                    				}else{
                        				$.messager.alert('错误', '请填写英文内容');
                        			}
                    			}else{
                    				$.messager.alert('错误', '请填写英文摘要');
                    			}
                    		}else{
                    			$.messager.alert('错误', '中英文标题至少填一项');
                    		}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyArticleForm").reset();
                    	$("#modifyArticleDlg").dialog("close");
                    }
                }
            ]
        });
    });
</script>
</body>
</html>
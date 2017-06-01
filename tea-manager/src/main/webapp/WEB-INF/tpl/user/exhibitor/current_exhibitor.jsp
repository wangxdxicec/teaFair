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

		.exhibitors:hover{
			background-color:#6caef5;
		}
		.exhibitors{
			padding:8px;
		}
	</style>
</head>

<div id="tabs" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
	<div title="展商列表" style="padding:5px">
		<table id="exhibitors" data-options="url:'${base}/user/queryExhibitorsByPage?type=1',
            								 loadMsg: '数据加载中......',
									         singleSelect:false,	//只能当行选择：关闭
									         fit:true,
									         fitColumns:true,
									         idField:'eid',
									         remoteSort:true,
									         view: emptyView,
											 emptyMsg: '没有记录',
											 toolbar:'#toolbar',
									         rownumbers: true,
									         pagination:'true',
									         pageSize:'20'">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field: 'tag', sortable:true, formatter: formatTag, width: $(this).width() * 0.07">
						所属人<br/>
						<select id="exhibitorsTag" style="width:100%;height:21px;" onchange="filter(this.options[this.options.selectedIndex].value);">
						</select>
					</th>
					<th data-options="field: 'group', sortable:true, formatter: formatGroup, width: $(this).width() * 0.07">
						展团<br/>
						<select id="exhibitorsGroup" style="width:100%;height:21px;" onchange="filter(this.options[this.options.selectedIndex].value);">
						</select>
					</th>
					<th data-options="field: 'boothNumber', sortable:true, width: $(this).width() * 0.07">
						展位号<br/>
						<input id="exhibitorsBoothNumber" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
					</th>
					<th data-options="field: 'company', sortable:true, width: $(this).width() * 0.25">
						公司中文名<br/>
						<input id="exhibitorsCompany" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
					</th>
					<th data-options="field: 'companye', sortable:true, width: $(this).width() * 0.26">
						公司英文名<br/>
						<input id="exhibitorsCompanye" style="width:100%;height:15px;" type="text" onkeyup="filter();"/>
					</th>
					<th data-options="field: 'area', sortable:true, formatter: formatArea, width: $(this).width() * 0.07">
						展区<br/>
						<select id="exhibitorsArea" style="width:100%;height:21px;" onchange="filter();">
							<option selected value="">全部</option>
							<option value="1">国内</option>
							<option value="2">国外</option>
						</select>
					</th>
					<th data-options="field: 'country', sortable:true, formatter: formatCountry, width: $(this).width() * 0.07">
						国家<br/>
						<select id="exhibitorsCountry" style="width:100%;height:21px;" onchange="filter(this.options[this.options.selectedIndex].value);">
						</select>
					</th>
					<th data-options="field: 'province', sortable:true, formatter: formatProvince, width: $(this).width() * 0.07">
						省份<br/>
						<select id="exhibitorsProvince" style="width:100%;height:21px;" onchange="filter(this.options[this.options.selectedIndex].value);">
						</select>
					</th>
					<th data-options="field: 'isLogout', sortable:true, formatter: formatStatus, width: $(this).width() * 0.07">
						状态<br/>
						<select id="exhibitorsIsLogout" style="width:104%;height:21px;" onchange="filter();">
							<%--<option selected value="">全部</option>--%>
							<option selected value="0">正常</option>
							<%--<option value="1">注销</option>--%>
						</select>
					</th>
				</tr>
			</thead>
	</table>
		<!-- 导出所选会刊 -->
		<form id="exportTransactionsToZip" action="${base}/user/exportTransactionsToZip" method="post">
			<div id="eidParm1"></div>
		</form>
		<!-- 导出所选展商到Excel -->
		<form id="exportExhibitorsToExcel" action="${base}/user/exportExhibitorsToExcel" method="post">
			<div id="eidParm2"></div>
		</form>
		<!-- 导出所选展位号+企业楣牌 -->
		<form id="exportBoothNumAndMeipaiToExcel" action="${base}/user/exportBoothNumAndMeipaiToExcel" method="post">
			<div id="eidParm3"></div>
		</form>
		<!-- 导出展商参展人员到Excel -->
		<form id="exportExhibitorJoinersToExcel" action="${base}/user/exportExhibitorJoinersToExcel" method="post">
			<div id="eidParm5"></div>
		</form>
		<!-- 导出所有展商增值税专用发票 -->
		<form id="exportExhibitorInvitationToZip" action="${base}/user/exportExhibitorInvitationToZip" method="post">
			<div id="eidParm7"></div>
		</form>
	</div>
</div>
<!-- 添加展商账号表单 -->
<div id="addExhibitorDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="addExhibitorForm" name="addExhibitorForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">展商中文名称：</td>
                <td><input class="easyui-validatebox" type="text" name="companyName"></td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">展商英文名称：</td>
                <td><input class="easyui-validatebox" type="text" name="companyNameE"></td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">用户名：</td>
                <td><input class="easyui-validatebox" type="text" name="username"></td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">密码：</td>
                <td><input class="easyui-validatebox" type="password" name="password"></td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">展位号：</td>
                <td><input class="easyui-validatebox" type="text" name="boothNumber" required="true" missingMessage="展位号不能为空"></td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">国家：</td>
                <td>
					<select id="country" name="country" style="width:204px;height:25px;" onchange="country_change(this.options[this.options.selectedIndex].value)">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">省份：</td>
                <td>
                	<select id="province" name="province" style="width:204px;height:25px;">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">所属人：</td>
                <td>
					<select id="tag" name="tag" style="width:204px;height:25px;">
					</select>
				</td>
            </tr>
            <tr>
                <td style="width: 90px;text-align: right">展区：</td>
                <td>
					<select id="area" name="area" style="width:204px;height:25px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
            </tr>
			<tr>
				<td style="width: 90px;text-align: right">展位面积：</td>
				<td><input class="easyui-validatebox" type="text" name="exhibitionArea"></td>
			</tr>
        </table>
    </form>
</div>

<!-- 批量修改所属人表单 -->
<div id="modifyExhibitorsTagDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsTagForm" name="modifyExhibitorsTagForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">所属人：</td>
                <td>
					<select id="modifyTag" name="modifyTag" style="width:204px;">
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 批量修改展团表单 -->
<div id="modifyExhibitorsGroupDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsGroupForm" name="modifyExhibitorsGroupForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">展团：</td>
                <td>
					<select id="modifyGroup" name="modifyGroup" style="width:204px;">
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 批量修改展区表单 -->
<div id="modifyExhibitorsAreaDlg" data-options="iconCls:'icon-add',modal:true">
    <form id="modifyExhibitorsAreaForm" name="modifyExhibitorsAreaForm">
        <table style="width: 320px;margin: 20px auto">
            <tr>
                <td style="width: 90px;text-align: right">展区：</td>
                <td>
					<select id="modifyArea" name="modifyArea" style="width:204px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 导入展商账号 -->
<div id="importExhibitorsDlg" data-options="iconCls:'icon-add',modal:true">
	<form id="importExhibitorsForm" name="importExhibitorsForm">
	   	<table style="width: 320px;margin: 20px auto">
			<tr>
				<td colspan="2" style="width: 90px;text-align: left"><a href="${base}/resource/template.xls">下载导入模版</a><br /></td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">导入模版：</td>
				<td style="width: 90px;text-align: left"><input type="file" name="file" id="file" /></td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">国家：</td>
				<td>
					<select id="countryImport" name="country" style="width:200px;" onchange="country_change_import(this.options[this.options.selectedIndex].value)">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">省份：</td>
				<td>
					<select id="provinceImport" name="province" style="width:200px;">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">展区：</td>
				<td>
					<select id="areaImport" name="area" style="width:200px;">
						<option selected value="">请选择</option>
						<option value="1">国内</option>
						<option value="2">国外</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">展团：</td>
				<td>
					<select id="groupImport" name="group" style="width:200px;">
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 70px;text-align: left">所属人：</td>
				<td>
					<select id="tagImport" name="tag" style="width:200px;">
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 工具栏 -->
<div id="toolbar">
    <div>
        <div id="addExhibitor" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加展商账号</div>
		<div id="modifyExhibitorsTag" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改所属人</div>
		<div id="modifyExhibitorsGroup" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改展团</div>
		<div id="modifyExhibitorsArea" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改展区</div>
        <div id="removeExhibitor" class="easyui-linkbutton" iconCls="icon-remove" plain="true">注销展商账号</div>
        <div id="enableExhibitor" class="easyui-linkbutton" iconCls="icon-edit" plain="true">启用展商账号</div>
        <%--<div id="deleteExhibitor" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除展商账号</div>--%>
        <div class="easyui-menubutton" menu="#export" iconCls="icon-redo">导出</div>
		<div class="easyui-menubutton" menu="#import" iconCls="icon-undo">导入</div>
    </div>
    <div id="export" style="width:180px;">
    	<div id="exportAllTransactions" iconCls="icon-redo">所有会刊</div>
    	<div id="exportSelectedTransactions" iconCls="icon-redo">所选会刊</div>
    	<div class="menu-sep"></div>
		<div id="exportAllBoothNumAndMeipai" iconCls="icon-redo">所有展位号+企业楣牌</div>
		<div id="exportSelectedBoothNumAndMeipai" iconCls="icon-redo">所选展位号+企业楣牌</div>
		<div class="menu-sep"></div>
		<div id="exportAllExhibitors" iconCls="icon-redo">所有展商基本信息到Excel</div>
		<div id="exportSelectedExhibitors" iconCls="icon-redo">所选展商基本信息到Excel</div>
		<div id="exportAllExhibitorJoiners" iconCls="icon-redo">所有参展人员列表到Excel</div>
		<div id="exportSelectedExhibitorJoiners" iconCls="icon-redo">所选参展人员列表到Excel</div>
		<div class="menu-sep"></div>
		<div id="exportAllExhibitorInvitationInfo" iconCls="icon-redo">所有展商增值税专用发票</div>
		<div id="exportSelectedExhibitorInvitationInfo" iconCls="icon-redo">所选展商增值税专用发票</div>
	</div>
	<div id="import" style="width:100px;">
		<div id="importExhibitor" iconCls="icon-undo">导入展商账号</div>
	</div>
</div>

<script>
	var checkedItems = [];
	var country = [];
	var province = [];
	var tags = {};
	var groups = {};
	var exhibitorsProvinceOld = -1;
	var exhibitorsCountryOld = -1;
	var eidParm1 = document.getElementById("eidParm1");
	var eidParm2 = document.getElementById("eidParm2");
	var eidParm3 = document.getElementById("eidParm3");
	var classify = document.getElementById("classify");
//----------------------------------------------------------折叠面板按钮开始-----------------------------------------------------------//
	//打开展商列表
	$('#exhibitorsList').click(function(){
		$('#tabs').tabs('select', "展商列表");
	});
	//打开展团列表
	$('#exhibitorsGroupList').click(function(){
		addTab("展团列表","${base}/user/exhibitorGroup");
	});
//----------------------------------------------------------折叠面板按钮开始-----------------------------------------------------------//	
//----------------------------------------------------------工具栏按钮开始------------------------------------------------------------//
	//添加展商账号
	$('#addExhibitor').click(function(){
		document.getElementById("addExhibitorForm").reset();
       	$("#country").html('');
		$("#country").append('<option value="">请选择</option>');
		for(var i=0,a;a=country[i++];){
			$("#country").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
		}
		$("#province").html('');
		document.getElementById('province').disabled=true;
		$("#tag").html('');
		$("#tag").append('<option value="">请选择</option>');
		for(var tag in tags){
			$("#tag").append('<option value="'+tag+'">'+tags[tag]+'</option>');
		}
        $("#addExhibitorDlg").dialog("open");
	});
	//批量修改所属人
	$('#modifyExhibitorsTag').click(function(){
		if(checkedItems.length > 0){
			$.ajax({
	       		type:"POST",
	       		dataType:"json",
	       		url:"${base}/user/queryTags",
	       		success : function(result) {
	       			if(result){
	       				$("#modifyTag").html('');
	       				$("#modifyTag").append('<option value="">请选择</option>');
	       				for(var i=0,a;a=result.rows[i++];){
//	        				    console.log(a);
	       					$("#modifyTag").append('<option value="'+a.id+'">'+a.name+'</option>');
	       				}
	       			}
	       		}
	       	});
	        $("#modifyExhibitorsTagDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//批量修改展团
	$('#modifyExhibitorsGroup').click(function(){
		if(checkedItems.length > 0){
			$.ajax({
	       		type:"POST",
	       		dataType:"json",
	       		url:"${base}/user/queryExhibitorGroupByPage",
	       		success : function(result) {
	       			if(result){
	       				$("#modifyGroup").html('');
	       				$("#modifyGroup").append('<option value="">请选择</option>');
	       				for(var i=0,a;a=result.rows[i++];){
//	        				    console.log(a);
	       					$("#modifyGroup").append('<option value="'+a.id+'">'+a.groupName+'</option>');
	       				}
	       			}
	       		}
	       	});
	        $("#modifyExhibitorsGroupDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//批量修改展区
	$('#modifyExhibitorsArea').click(function(){
		if(checkedItems.length > 0){
	        $("#modifyExhibitorsAreaDlg").dialog("open");
		}else{
			$.messager.alert('提示', '请至少选择一项展商再修改所属人');
		}
	});
	//注销展商账号
	$('#removeExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('注销展商','你确定要注销展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/disableExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '注销成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再注销');
		}
	});
	//启用展商账号
	$('#enableExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('启用展商','你确定要启用展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/enableExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
		                    	checkedItems = [];
		                        $.messager.show({
		                            title: '成功',
		                            msg: '启用成功',
		                            timeout: 5000,
		                            showType: 'slide'
		                        });
		                    } else {
		                        $.messager.alert('错误', '系统错误');
		                    }
		                }
		            });
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再启用');
		}
	});
	//删除展商账号
	$('#deleteExhibitor').click(function(){
		if(checkedItems.length > 0){
			$.messager.confirm('删除展商','你确定要删除展商吗?',function(r){
			    if (r){
			    	$.ajax({
		                url: "${base}/user/deleteExhibitors",
		                type: "post",
		                dataType: "json",
		                data: {"eids": checkedItems},
		                traditional: true,
		                success: function (data) {
		                    if (data.resultCode == 0) {
		                    	$("#exhibitors").datagrid("reload");
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
		        	$.messager.alert('提示', '删除展商成功');
			    }
			});
		}else{
			$.messager.alert('提示', '请至少选择一项展商再删除');
		}
	});
	//导出所有会刊
	$('#exportAllTransactions').click(function(){
        eidParm1.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm1.innerHTML += node;
		var node2 = "<input type='hidden' name='type' value='1'/>";
		eidParm1.innerHTML += node2;
        document.getElementById("exportTransactionsToZip").submit();
        $.messager.alert('提示', '请勿关闭窗口,耐心等待1~2分钟后会提示下载');
	});
	//导出所选会刊
	$('#exportSelectedTransactions').click(function(){
//     	alert(checkedItems);
		eidParm1.innerHTML = "";
//     	alert(eidParm1.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm1.innerHTML += node;
        	}
			var node2 = "<input type='hidden' name='type' value='1'/>";
			eidParm1.innerHTML += node2;
        	document.getElementById("exportTransactionsToZip").submit();
        	$.messager.alert('提示', '导出所选会刊成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展商到Excel
	$('#exportAllExhibitors').click(function(){
        eidParm2.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm2.innerHTML += node;
		var node2 = "<input type='hidden' name='type' value='1'/>";
		eidParm2.innerHTML += node2;
        document.getElementById("exportExhibitorsToExcel").submit();
        $.messager.alert('提示', '导出所有展商成功');
	});
	//导出所选展商到Excel
	$('#exportSelectedExhibitors').click(function(){
//     	alert(checkedItems);
		eidParm2.innerHTML = "";
//     	alert(eidParm2.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm2.innerHTML += node;
        	}
			var node2 = "<input type='hidden' name='type' value='1'/>";
			eidParm2.innerHTML += node2;
        	document.getElementById("exportExhibitorsToExcel").submit();
        	$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展位号+企业楣牌
	$('#exportAllBoothNumAndMeipai').click(function(){
        eidParm3.innerHTML = "";
        var node = "<input type='hidden' name='eids' value='-1'/>";
        eidParm3.innerHTML += node;
		var node2 = "<input type='hidden' name='type' value='1'/>";
		eidParm3.innerHTML += node2;
        document.getElementById("exportBoothNumAndMeipaiToExcel").submit();
        $.messager.alert('提示', '导出所有展位号+企业楣牌成功');
	});
	//导出所选展位号+企业楣牌
	$('#exportSelectedBoothNumAndMeipai').click(function(){
//     	alert(checkedItems);
		eidParm3.innerHTML = "";
//     	alert(eidParm3.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
        		var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
        		eidParm3.innerHTML += node;
        	}
			var node2 = "<input type='hidden' name='type' value='1'/>";
			eidParm3.innerHTML += node2;
        	document.getElementById("exportBoothNumAndMeipaiToExcel").submit();
        	$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展商参展人员信息到Excel
	$('#exportAllExhibitorJoiners').click(function(){
		eidParm5.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm5.innerHTML += node;
		var node2 = "<input type='hidden' name='type' value='1'/>";
		eidParm5.innerHTML += node2;
		document.getElementById("exportExhibitorJoinersToExcel").submit();
		$.messager.alert('提示', '导出所有展商参展人员信息成功');
	});
	//导出所选展商参展人员信息到Excel
	$('#exportSelectedExhibitorJoiners').click(function(){
//     	alert(checkedItems);
		eidParm5.innerHTML = "";
//     	alert(eidParm4.innerHTML);
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
				eidParm5.innerHTML += node;
			}
			var node2 = "<input type='hidden' name='type' value='1'/>";
			eidParm5.innerHTML += node2;
			document.getElementById("exportExhibitorJoinersToExcel").submit();
			$.messager.alert('提示', '导出所选展商成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});
	//导出所有展商增值税专用发票
	$('#exportAllExhibitorInvitationInfo').click(function(){
		eidParm7.innerHTML = "";
		var node = "<input type='hidden' name='eids' value='-1'/>";
		eidParm7.innerHTML += node;
		document.getElementById("exportExhibitorInvitationToZip").submit();
		$.messager.alert('提示', '请勿关闭窗口,耐心等待1~2分钟后会提示下载');
	});
	//导出所选展商增值税专用发票
	$('#exportSelectedExhibitorInvitationInfo').click(function(){
		eidParm7.innerHTML = "";
		if(checkedItems.length > 0){
			for (var i = 0; i < checkedItems.length; i++) {
				var node = "<input type='hidden' name='eids' value='"+checkedItems[i]+"'/>";
				eidParm7.innerHTML += node;
			}
			document.getElementById("exportExhibitorInvitationToZip").submit();
			$.messager.alert('提示', '导出所选展商增值税专用发票成功');
		}else{
			$.messager.alert('提示', '请至少选择一项展商再导出');
		}
	});


	//导入展商账号
	$('#importExhibitor').click(function(){
		$("#countryImport").html('');
		$("#countryImport").append('<option value="">请选择</option>');
		for(var i=0,a;a=country[i++];){
// 			console.log(a);
			$("#countryImport").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
		}
		$("#provinceImport").html('');
		document.getElementById('provinceImport').disabled=true;
		$.ajax({
       		type:"POST",
       		dataType:"json",
       		url:"${base}/user/queryExhibitorGroupByPage",
       		success : function(result) {
       			if(result){
       				$("#groupImport").html('');
       				$("#groupImport").append('<option value="">请选择</option>');
       				for(var i=0,a;a=result.rows[i++];){
//        				    console.log(a);
       					$("#groupImport").append('<option value="'+a.id+'">'+a.groupName+'</option>');
       				}
       			}
       		}
       	});
		$.ajax({
       		type:"POST",
       		dataType:"json",
       		url:"${base}/user/queryTags",
       		success : function(result) {
       			if(result){
       				$("#tagImport").html('');
       				$("#tagImport").append('<option value="">请选择</option>');
       				for(var i=0,a;a=result.rows[i++];){
//        				    console.log(a);
       					$("#tagImport").append('<option value="'+a.id+'">'+a.name+'</option>');
       				}
       			}
       		}
       	});
		$("#importExhibitorsDlg").dialog("open");
	});
//----------------------------------------------------------工具栏按钮结束------------------------------------------------------------//
//----------------------------------------------------------自定义函数开始------------------------------------------------------------//
	function formatTag(val, row) {
        if (val != null) {
			return tags[val];
        } else {
            return null;
        }
    }
	function formatGroup(val, row) {
        if (val != null) {
			return groups[val];
        } else {
            return null;
        }
    }
	function formatArea(val, row) {
        if (val == 1) {
			return "国内";
        } else if (val == 2) {
        	return "国外";
        } else return "";
    }
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
	function formatProvince(val, row) {
        if (val != null) {
        	if(val > 0 && val <= province.length){
	            return province[val - 1].chineseName;
        	}
        	return null;
        } else {
            return null;
        }
    }
    function formatStatus(val, row) {
        if (val == 0) {
            return '正常';
        } else {
            return '注销';
        }
    }
    
    // 动态添加标签页
    function addTab(title, url){
		if ($('#tabs').tabs('exists', title)){
			$('#tabs').tabs('select', title);
		} else {
			var content = '<iframe scrolling="auto" frameborder="0" src="'+url+'" style="width:100%;height:99%;"></iframe>';
			$('#tabs').tabs('add',{
				title:title,
				content:content,
				closable:true
			});
		}
	}
    function country_change(countryId){
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryProvinceByCountryId",
    		data:{ 'countryId': countryId },
    		success : function(result) {
    			if(result){
    				$("#province").html('');
    				document.getElementById('province').disabled=false;
	   		 		$("#province").append('<option value="">请选择</option>');
	   		 		for(var i=0,a;a=province[i++];){
// 	   		 		    console.log(a);
	   		 			$("#province").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
	   		 		}
    			}
    		},
    		error : function(result) {
   				$("#province").html('');
   				document.getElementById('province').disabled=true;
    		}
    	});
    }
    function country_change_import(countryId){
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryProvinceByCountryId",
    		data:{ 'countryId': countryId },
    		success : function(result) {
    			if(result){
    				$("#provinceImport").html('');
    				document.getElementById('provinceImport').disabled=false;
	   		 		$("#provinceImport").append('<option value="">请选择</option>');
	   		 		for(var i=0,a;a=province[i++];){
// 	   		 		    console.log(a);
	   		 			$("#provinceImport").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
	   		 		}
    			}
    		},
    		error : function(result) {
   				$("#provinceImport").html('');
   				document.getElementById('provinceImport').disabled=true;
    		}
    	});
    }
    function filter(countryId){
    	var filterParm = "?";
//     	console.log("exhibitorsAreaOld:"+exhibitorsAreaOld);
//     	console.log("exhibitorsArea:"+document.getElementById("exhibitorsArea").value);
//     	console.log("exhibitorsCountryOld"+exhibitorsCountryOld);
//     	console.log("exhibitorsCountry:"+document.getElementById("exhibitorsCountry").value);
//     	console.log("====================================================");
    	if(document.getElementById("exhibitorsTag").value != ""){
    		filterParm += '&tag=' + document.getElementById("exhibitorsTag").value;
    	}
    	if(document.getElementById("exhibitorsGroup").value != ""){
    		filterParm += '&group=' + document.getElementById("exhibitorsGroup").value;
    	}
    	if(document.getElementById("exhibitorsBoothNumber").value != ""){
    		filterParm += '&boothNumber=' + document.getElementById("exhibitorsBoothNumber").value;
    	}
    	if(document.getElementById("exhibitorsCompany").value != ""){
    		filterParm += '&company=' + document.getElementById("exhibitorsCompany").value;
    	}
    	if(document.getElementById("exhibitorsCompanye").value != ""){
    		filterParm += '&companye=' + document.getElementById("exhibitorsCompanye").value;
    	}
    	if(document.getElementById("exhibitorsArea").value != ""){
    		filterParm += '&area=' + document.getElementById("exhibitorsArea").value;
    	}
    	if(document.getElementById("exhibitorsCountry").value != ""){
    		if(document.getElementById("exhibitorsCountry").value != exhibitorsCountryOld){
    			filterParm += '&country=' + document.getElementById("exhibitorsCountry").value;
    			exhibitorsCountryOld = document.getElementById("exhibitorsCountry").value;
        		$.ajax({
            		type:"POST",
            		dataType:"json",
            		url:"${base}/user/queryProvinceByCountryId",
            		data:{ 'countryId': countryId },
            		success : function(result) {
            			if(result){
            				$("#exhibitorsProvince").html('');
            				document.getElementById('exhibitorsProvince').disabled=false;
        	   		 		$("#exhibitorsProvince").append('<option value="">请选择</option>');
        	   		 		for(var i=0,a;a=province[i++];){
//         	   		 		    console.log(a);
        	   		 			$("#exhibitorsProvince").append('<option value="'+a.id+'">'+a.chineseName+'</option>');
        	   		 		}
            			}
            		},
            		error : function(result) {
           				$("#exhibitorsProvince").html('');
           				document.getElementById('exhibitorsProvince').disabled=true;
            		}
            	});
    		}
    	}else{
    		filterParm += '&country=' + document.getElementById("exhibitorsCountry").value;
			exhibitorsCountryOld = document.getElementById("exhibitorsCountry").value;
    		$("#exhibitorsProvince").html('');
			document.getElementById('exhibitorsProvince').disabled=true;
    	}
    	if(document.getElementById("exhibitorsProvince").value != ""){
    		if(document.getElementById("exhibitorsProvince").value != exhibitorsProvinceOld){
	    		filterParm += '&province=' + document.getElementById("exhibitorsProvince").value;
	    		exhibitorsProvinceOld = document.getElementById("exhibitorsProvince").value;
    		}
    	}
    	if(document.getElementById("exhibitorsIsLogout").value != ""){
    		filterParm += '&isLogout=' + document.getElementById("exhibitorsIsLogout").value;
    	}
		filterParm += '&type=1';
    	$('#exhibitors').datagrid('options').url = '${base}/user/queryExhibitorsByPage' + filterParm;
        $('#exhibitors').datagrid('reload');
    }
//----------------------------------------------------------自定义函数结束------------------------------------------------------------//
  
    $(document).ready(function () {
    	//加载国家列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryAllCountry",
    		success : function(result) {
    			if(result){
    				country = result;
    				$("#exhibitorsCountry").html('');
    				$("#exhibitorsCountry").append('<option value="">全部</option>');
    				for(var i=0,a;a=country[i++];){
//     					console.log(a);
    					$("#exhibitorsCountry").append('<option value="'+a.id+'">'+a.countryValue+a.chineseName+'</option>');
    				}
    				document.getElementById('exhibitorsProvince').disabled=true;
//     				for(var i=0,a;a=result.areas[i++];){
//     				    console.log(a.text);
//     				}
    			}
    		}
    	});
    	//加载省份列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryAllProvince",
    		success : function(result) {
    			if(result){
    				province = result;
//     				for(var i=0,a;a=result.areas[i++];){
//     				    console.log(a.text);
//     				}
    			}
    		}
    	});
    	//加载所属人列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryTags",
    		success : function(result) {
    			if(result){
    				$("#exhibitorsTag").html('');
    				$("#exhibitorsTag").append('<option value="">全部</option>');
    				for(var i=0,a;a=result.rows[i++];){
    					tags[a.id] = a.name;
    					$("#exhibitorsTag").append('<option value="'+a.id+'">'+a.name+'</option>');
    				}
//     				for(var i=0,a;a=result.rows[i++];){
//     				    console.log(a.id + ":" + a.name);
//     				}
    			}
    		}
    	});
    	//加载展团列表
    	$.ajax({
    		type:"POST",
    		dataType:"json",
    		url:"${base}/user/queryExhibitorGroupByPage",
    		success : function(result) {
    			if(result){
    				$("#exhibitorsGroup").html('');
    				$("#exhibitorsGroup").append('<option value="">全部</option>');
    				for(var i=0,a;a=result.rows[i++];){
    					groups[a.id] = a.groupName;
    					$("#exhibitorsGroup").append('<option value="'+a.id+'">'+a.groupName+'</option>');
    				}
//     				for(var i=0,a;a=result.rows[i++];){
//     				    console.log(a.id + ":" + a.name);
//     				}
    			}
    		}
    	});
    	
    	$('#menu').accordion({
			onSelect: function(title){
				if(title == "公告管理"){
					addTab("公告列表","${base}/user/article");
				}else if(title == "客商管理"){
					addTab("客商列表","${base}/user/customer");
				}else if(title == "标签管理"){
					addTab("标签列表","${base}/user/tag");
				}else if(title == "展商管理"){
					addTab("展商列表","${base}/user/exhibitor");
				}
			}	
		});
    	
        // 展商列表渲染
		$('#exhibitors').datagrid({
            onSelect:function (rowIndex, rowData){
            	var row = $('#exhibitors').datagrid('getSelections');
				for (var i = 0; i < row.length; i++) {
					if (findCheckedItem(row[i].eid) == -1) {
						checkedItems.push(row[i].eid);
					}
				}
// 				alert(checkedItems);
            },
            onUnselect:function (rowIndex, rowData){
				var k = findCheckedItem(rowData.eid);
				if (k != -1) {
					checkedItems.splice(k, 1);
				}
// 				alert(checkedItems);
            },
            onSelectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
            		var k = findCheckedItem(rows[i].eid);
					if (k == -1) {
						checkedItems.push(rows[i].eid);
					}
				}
// 				alert(checkedItems);
            },
            onUnselectAll:function (rows){
            	for (var i = 0; i < rows.length; i++) {
					var k = findCheckedItem(rows[i].eid);
					if (k != -1) {
						checkedItems.splice(k, 1);
					}
				}
// 				alert(checkedItems);
            },
            rowStyler:function(index,row){
				if (row.infoFlag == 1){
					return 'color:green;font-weight:bold;';
				}else if(row.infoFlag == 5) {
					return 'color:black;font-weight:bold;';	//账号刚激活，但未登录的
				}
			},
            onDblClickRow: function (index, field, value) {
            	if(field.company != ""){
	                if (!$("#tabs").tabs("exists", field.company)) {
	                    $('#tabs').tabs('add', {
	                        title: field.company,
	                        content:'<iframe frameborder="0" src="'+ "${base}/user/exhibitor?eid=" + field.eid+'" style="width:100%;height:99%;"></iframe>',
	                        closable: true
	                    });
	                } else {
	                    $("#tabs").tabs("select", field.company);
	                }
            	}else if(field.companye != ""){
            		if (!$("#tabs").tabs("exists", field.companye)) {
	                    $('#tabs').tabs('add', {
	                        title: field.companye,
	                        content:'<iframe frameborder="0" src="'+ "${base}/user/exhibitor?eid=" + field.eid+'" style="width:100%;height:99%;"></iframe>',
	                        closable: true
	                    });
	                } else {
	                    $("#tabs").tabs("select", field.companye);
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
        function findCheckedItem(eid) {
			for (var i = 0; i < checkedItems.length; i++) {
				if (checkedItems[i] == eid) return i;
			}
			return -1;
		}

        // 添加展商账号弹出框
        $('#addExhibitorDlg').dialog({
            title: '添加展商账号',
            width: 350,
            height: 390,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    iconCls: 'icon-ok',
                    handler: function () {
                        if ($("#addExhibitorForm").form("validate")) {
                        	if(document.addExhibitorForm.companyName.value.trim() != "" || document.addExhibitorForm.companyNameE.value.trim() != ""){
                        		$.ajax({
                                    url: "${base}/user/addExhibitor",
                                    type: "post",
                                    dataType: "json",
                                    data: $("#addExhibitorForm").serializeJson(),
                                    success: function (data) {
                                        if (data.resultCode == 0) {
                                            $("#addExhibitorDlg").dialog("close");
                                            $.messager.show({
                                                title: '成功',
                                                msg: '添加展商账号成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
                                            $("#exhibitors").datagrid("reload");
                                            $("#addExhibitorForm").clearForm();
                                        } else if (data.resultCode == 2) {
                                            $.messager.alert('错误', data.description);
                                        } else {
                                            $.messager.alert('错误', '系统错误');
                                        }
                                    }
                                });
                        	}else{
                        		$.messager.alert('错误', '展商中文名或英文名至少要填一个');
                        	}
                        }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("addExhibitorForm").reset();  
                    	$("#addExhibitorDlg").dialog("close");
                    }
                }
            ]
        });
		// 批量修改所属人弹出框
        $('#modifyExhibitorsTagDlg').dialog({
            title: '批量修改所属人',
            width: 350,
            height: 140,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var tag = document.getElementById("modifyTag").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsTag",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "tag": tag},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#modifyExhibitorsTagDlg").dialog("close");
                                    	$("#exhibitors").datagrid("reload");
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsTagForm").reset();  
                    	$("#modifyExhibitorsTagDlg").dialog("close");
                    }
                }
            ]
        });
     	// 批量修改展团弹出框
        $('#modifyExhibitorsGroupDlg').dialog({
            title: '批量修改所属人',
            width: 350,
            height: 140,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var group = document.getElementById("modifyGroup").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsGroup",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "group": group},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#exhibitors").datagrid("reload");
                                    	$("#modifyExhibitorsGroupDlg").dialog("close");
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsGroupForm").reset();  
                    	$("#modifyExhibitorsGroupDlg").dialog("close");
                    }
                }
            ]
        });
		// 批量修改展区弹出框
        $('#modifyExhibitorsAreaDlg').dialog({
            title: '批量修改展区',
            width: 350,
            height: 140,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认修改',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	if(checkedItems.length > 0){
                    		var area = document.getElementById("modifyArea").value;
                    		$.ajax({
                                url: "${base}/user/modifyExhibitorsArea",
                                type: "post",
                                dataType: "json",
                                data: {"eids": checkedItems, "area": area},
                                traditional: true,
                                success: function (data) {
                                    if (data.resultCode == 0) {
                                    	$("#modifyExhibitorsAreaDlg").dialog("close");
                                    	$("#exhibitors").datagrid("reload");
                                    	checkedItems = [];
                                        $.messager.show({
                                            title: '成功',
                                            msg: '修改成功',
                                            timeout: 5000,
                                            showType: 'slide'
                                        });
                                    } else {
                                        $.messager.alert('错误', '系统错误');
                                    }
                                }
                            });
                		}else{
                			$.messager.alert('提示', '请至少选择一项展商再修改');
                		}
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	document.getElementById("modifyExhibitorsAreaForm").reset();  
                    	$("#modifyExhibitorsAreaDlg").dialog("close");
                    }
                }
            ]
        });
		// 导入展商账号弹出框
        $('#importExhibitorsDlg').dialog({
            title: '导入展商账号',
            width: 350,
            height: 340,
            closed: true,
            cache: false,
            modal: true,
            buttons: [
                {
                    text: '确认添加',
                    iconCls: 'icon-ok',
                    handler: function () {
                    	var file = document.getElementById("file").value;
						var country = document.getElementById("countryImport").value;
						var province = document.getElementById("provinceImport").value;
						var area = document.getElementById("areaImport").value;
						var group = document.getElementById("groupImport").value;
						var tag = document.getElementById("tagImport").value;
                    	if(file == null || file == ""){
                    		$.messager.alert('提示', '请选择所要上传的文件！');
                    	} else {
	                    	var index = file.lastIndexOf(".");
	                    	if(index < 0) {
	                    		$.messager.alert('提示', '上传的文件格式不正确，请选择97-2003Excel文件(*.xls)！');
	                    	} else {
		                    	var ext = file.substring(index + 1, file.length);
		                    	if(ext != "xls") {
		                    		$.messager.alert('提示', '上传的文件格式不正确，请选择97-2003Excel文件(*.xls)！');
		                    	} else {
		                    		$.ajaxFileUpload({
										url:'upload/exhibitors',
										dataType: 'text/html',
										data:{"file":$("#importExhibitorsForm").serializeJson(), "isCurrent": 1,
										"country":country, "province": province, "area": area, "group": group, "tag": tag},
										fileElementId:'file',
										success: function (data){
											$("#importExhibitorsDlg").dialog("close");
											filter();
											var report = data;
											report = report.replace(new RegExp('","', 'g'), '<br/>');
											report = report.substring(2, report.length-2);
											$.messager.alert('成功', report);
											$.messager.show({
                                                title: '成功',
                                                msg: '导入展商账号成功',
                                                timeout: 5000,
                                                showType: 'slide'
                                            });
										},
										error: function (data){
											$.messager.alert('错误', data);
	                    		        }
		                    		});
		                    	}
	                    	}
	                    }
                    }
                },
                {
                    text: '取消',
                    handler: function () {
                    	$("#importExhibitorsDlg").dialog("close");
                    }
                }
            ]
        });
    });
</script>
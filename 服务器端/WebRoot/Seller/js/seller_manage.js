var seller_manage_tool = null; 
$(function () { 
	initSellerManageTool(); //建立Seller管理对象
	seller_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#seller_manage").datagrid({
		url : 'Seller/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "sellerUserName",
		sortOrder : "desc",
		toolbar : "#seller_manage_tool",
		columns : [[
			{
				field : "sellerUserName",
				title : "商家账号",
				width : 140,
			},
			{
				field : "sellerName",
				title : "商户名称",
				width : 140,
			},
			{
				field : "sellerPhoto",
				title : "商户照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "workTime",
				title : "经营时间",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "workAddress",
				title : "工作地址",
				width : 140,
			},
			{
				field : "workLicense",
				title : "营业许可证",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "scoreValue",
				title : "评价分数",
				width : 70,
			},
			{
				field : "shenHeState",
				title : "审核状态",
				width : 140,
			},
			{
				field : "addTime",
				title : "注册时间",
				width : 140,
			},
		]],
	});

	$("#sellerEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#sellerEditForm").form("validate")) {
					//验证表单 
					if(!$("#sellerEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#sellerEditForm").form({
						    url:"Seller/" + $("#seller_sellerUserName_edit").val() + "/update",
						    onSubmit: function(){
								if($("#sellerEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#sellerEditDiv").dialog("close");
			                        seller_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#sellerEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#sellerEditDiv").dialog("close");
				$("#sellerEditForm").form("reset"); 
			},
		}],
	});
});

function initSellerManageTool() {
	seller_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#seller_manage").datagrid("reload");
		},
		redo : function () {
			$("#seller_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#seller_manage").datagrid("options").queryParams;
			queryParams["sellerUserName"] = $("#sellerUserName").val();
			queryParams["sellerName"] = $("#sellerName").val();
			queryParams["telephone"] = $("#telephone").val();
			queryParams["shenHeState"] = $("#shenHeState").val();
			queryParams["addTime"] = $("#addTime").val();
			$("#seller_manage").datagrid("options").queryParams=queryParams; 
			$("#seller_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#sellerQueryForm").form({
			    url:"Seller/OutToExcel",
			});
			//提交表单
			$("#sellerQueryForm").submit();
		},
		remove : function () {
			var rows = $("#seller_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var sellerUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							sellerUserNames.push(rows[i].sellerUserName);
						}
						$.ajax({
							type : "POST",
							url : "Seller/deletes",
							data : {
								sellerUserNames : sellerUserNames.join(","),
							},
							beforeSend : function () {
								$("#seller_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#seller_manage").datagrid("loaded");
									$("#seller_manage").datagrid("load");
									$("#seller_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#seller_manage").datagrid("loaded");
									$("#seller_manage").datagrid("load");
									$("#seller_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#seller_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Seller/" + rows[0].sellerUserName +  "/update",
					type : "get",
					data : {
						//sellerUserName : rows[0].sellerUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (seller, response, status) {
						$.messager.progress("close");
						if (seller) { 
							$("#sellerEditDiv").dialog("open");
							$("#seller_sellerUserName_edit").val(seller.sellerUserName);
							$("#seller_sellerUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入商家账号",
								editable: false
							});
							$("#seller_password_edit").val(seller.password);
							$("#seller_password_edit").validatebox({
								required : true,
								missingMessage : "请输入预留密码段",
							});
							$("#seller_sellerName_edit").val(seller.sellerName);
							$("#seller_sellerName_edit").validatebox({
								required : true,
								missingMessage : "请输入商户名称",
							});
							$("#seller_sellerPhoto").val(seller.sellerPhoto);
							$("#seller_sellerPhotoImg").attr("src", seller.sellerPhoto);
							$("#seller_workContent_edit").val(seller.workContent);
							$("#seller_workContent_edit").validatebox({
								required : true,
								missingMessage : "请输入经营内容",
							});
							$("#seller_workTime_edit").val(seller.workTime);
							$("#seller_workTime_edit").validatebox({
								required : true,
								missingMessage : "请输入经营时间",
							});
							$("#seller_telephone_edit").val(seller.telephone);
							$("#seller_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#seller_workAddress_edit").val(seller.workAddress);
							$("#seller_workAddress_edit").validatebox({
								required : true,
								missingMessage : "请输入工作地址",
							});
							$("#seller_workLicense").val(seller.workLicense);
							$("#seller_workLicenseImg").attr("src", seller.workLicense);
							$("#seller_scoreValue_edit").val(seller.scoreValue);
							$("#seller_scoreValue_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入评价分数",
								invalidMessage : "评价分数输入不对",
							});
							$("#seller_shenHeState_edit").val(seller.shenHeState);
							$("#seller_shenHeState_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
							});
							$("#seller_addTime_edit").val(seller.addTime);
							$("#seller_addTime_edit").validatebox({
								required : true,
								missingMessage : "请输入注册时间",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}

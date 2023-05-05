$(function () {
	$("#seller_sellerUserName").validatebox({
		required : true, 
		missingMessage : '请输入商家账号',
	});

	$("#seller_password").validatebox({
		required : true, 
		missingMessage : '请输入预留密码段',
	});

	$("#seller_sellerName").validatebox({
		required : true, 
		missingMessage : '请输入商户名称',
	});

	$("#seller_workContent").validatebox({
		required : true, 
		missingMessage : '请输入经营内容',
	});

	$("#seller_workTime").validatebox({
		required : true, 
		missingMessage : '请输入经营时间',
	});

	$("#seller_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#seller_workAddress").validatebox({
		required : true, 
		missingMessage : '请输入工作地址',
	});

	$("#seller_scoreValue").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入评价分数',
		invalidMessage : '评价分数输入不对',
	});

	$("#seller_shenHeState").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	$("#seller_addTime").validatebox({
		required : true, 
		missingMessage : '请输入注册时间',
	});

	//单击添加按钮
	$("#sellerAddButton").click(function () {
		//验证表单 
		if(!$("#sellerAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#sellerAddForm").form({
			    url:"Seller/add",
			    onSubmit: function(){
					if($("#sellerAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#sellerAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#sellerAddForm").submit();
		}
	});

	//单击清空按钮
	$("#sellerClearButton").click(function () { 
		$("#sellerAddForm").form("clear"); 
	});
});

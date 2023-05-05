$(function () {
	$.ajax({
		url : "Seller/" + $("#seller_sellerUserName_edit").val() + "/update",
		type : "get",
		data : {
			//sellerUserName : $("#seller_sellerUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (seller, response, status) {
			$.messager.progress("close");
			if (seller) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#sellerModifyButton").click(function(){ 
		if ($("#sellerEditForm").form("validate")) {
			$("#sellerEditForm").form({
			    url:"Seller/" +  $("#seller_sellerUserName_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#sellerEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

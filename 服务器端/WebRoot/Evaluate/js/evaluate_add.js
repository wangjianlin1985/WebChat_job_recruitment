$(function () {
	$("#evaluate_sellerObj_sellerUserName").combobox({
	    url:'Seller/listAll',
	    valueField: "sellerUserName",
	    textField: "sellerName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#evaluate_sellerObj_sellerUserName").combobox("getData"); 
            if (data.length > 0) {
                $("#evaluate_sellerObj_sellerUserName").combobox("select", data[0].sellerUserName);
            }
        }
	});
	$("#evaluate_evaluateScore").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入评分',
		invalidMessage : '评分输入不对',
	});

	$("#evaluate_evaluateContent").validatebox({
		required : true, 
		missingMessage : '请输入评价内容',
	});

	$("#evaluate_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#evaluate_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#evaluate_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#evaluate_evaluateTime").validatebox({
		required : true, 
		missingMessage : '请输入评价时间',
	});

	//单击添加按钮
	$("#evaluateAddButton").click(function () {
		//验证表单 
		if(!$("#evaluateAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#evaluateAddForm").form({
			    url:"Evaluate/add",
			    onSubmit: function(){
					if($("#evaluateAddForm").form("validate"))  { 
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
                        $("#evaluateAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#evaluateAddForm").submit();
		}
	});

	//单击清空按钮
	$("#evaluateClearButton").click(function () { 
		$("#evaluateAddForm").form("clear"); 
	});
});

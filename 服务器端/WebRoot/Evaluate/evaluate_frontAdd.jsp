<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Seller" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商家评价添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Evaluate/frontlist">商家评价列表</a></li>
			    	<li role="presentation" class="active"><a href="#evaluateAdd" aria-controls="evaluateAdd" role="tab" data-toggle="tab">添加商家评价</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="evaluateList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="evaluateAdd"> 
				      	<form class="form-horizontal" name="evaluateAddForm" id="evaluateAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="evaluate_sellerObj_sellerUserName" class="col-md-2 text-right">被评价商家:</label>
						  	 <div class="col-md-8">
							    <select id="evaluate_sellerObj_sellerUserName" name="evaluate.sellerObj.sellerUserName" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="evaluate_evaluateScore" class="col-md-2 text-right">评分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="evaluate_evaluateScore" name="evaluate.evaluateScore" class="form-control" placeholder="请输入评分">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="evaluate_evaluateContent" class="col-md-2 text-right">评价内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="evaluate_evaluateContent" name="evaluate.evaluateContent" rows="8" class="form-control" placeholder="请输入评价内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="evaluate_userObj_user_name" class="col-md-2 text-right">评论用户:</label>
						  	 <div class="col-md-8">
							    <select id="evaluate_userObj_user_name" name="evaluate.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="evaluate_evaluateTime" class="col-md-2 text-right">评价时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="evaluate_evaluateTime" name="evaluate.evaluateTime" class="form-control" placeholder="请输入评价时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxEvaluateAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#evaluateAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加商家评价信息
	function ajaxEvaluateAdd() { 
		//提交之前先验证表单
		$("#evaluateAddForm").data('bootstrapValidator').validate();
		if(!$("#evaluateAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Evaluate/add",
			dataType : "json" , 
			data: new FormData($("#evaluateAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#evaluateAddForm").find("input").val("");
					$("#evaluateAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse > a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证商家评价添加表单字段
	$('#evaluateAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"evaluate.evaluateScore": {
				validators: {
					notEmpty: {
						message: "评分不能为空",
					},
					numeric: {
						message: "评分不正确"
					}
				}
			},
			"evaluate.evaluateContent": {
				validators: {
					notEmpty: {
						message: "评价内容不能为空",
					}
				}
			},
			"evaluate.evaluateTime": {
				validators: {
					notEmpty: {
						message: "评价时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被评价商家下拉框值 
	$.ajax({
		url: basePath + "Seller/listAll",
		type: "get",
		success: function(sellers,response,status) { 
			$("#evaluate_sellerObj_sellerUserName").empty();
			var html="";
    		$(sellers).each(function(i,seller){
    			html += "<option value='" + seller.sellerUserName + "'>" + seller.sellerName + "</option>";
    		});
    		$("#evaluate_sellerObj_sellerUserName").html(html);
    	}
	});
	//初始化评论用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#evaluate_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#evaluate_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>

<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>商家添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Seller/frontlist">商家管理</a></li>
  			<li class="active">添加商家</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="sellerAddForm" id="sellerAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="seller_sellerUserName" class="col-md-2 text-right">商家账号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="seller_sellerUserName" name="seller.sellerUserName" class="form-control" placeholder="请输入商家账号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="seller_password" class="col-md-2 text-right">预留密码段:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_password" name="seller.password" class="form-control" placeholder="请输入预留密码段">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_sellerName" class="col-md-2 text-right">商户名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_sellerName" name="seller.sellerName" class="form-control" placeholder="请输入商户名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_sellerPhoto" class="col-md-2 text-right">商户照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="seller_sellerPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="seller_sellerPhoto" name="seller.sellerPhoto"/>
					    <input id="sellerPhotoFile" name="sellerPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_workContent" class="col-md-2 text-right">经营内容:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_workContent" name="seller.workContent" class="form-control" placeholder="请输入经营内容">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_workTime" class="col-md-2 text-right">经营时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_workTime" name="seller.workTime" class="form-control" placeholder="请输入经营时间">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_telephone" name="seller.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_workAddress" class="col-md-2 text-right">工作地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_workAddress" name="seller.workAddress" class="form-control" placeholder="请输入工作地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_workLicense" class="col-md-2 text-right">营业许可证:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="seller_workLicenseImg" border="0px"/><br/>
					    <input type="hidden" id="seller_workLicense" name="seller.workLicense"/>
					    <input id="workLicenseFile" name="workLicenseFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_scoreValue" class="col-md-2 text-right">评价分数:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_scoreValue" name="seller.scoreValue" class="form-control" placeholder="请输入评价分数">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_shenHeState" class="col-md-2 text-right">审核状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_shenHeState" name="seller.shenHeState" class="form-control" placeholder="请输入审核状态">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="seller_addTime" class="col-md-2 text-right">注册时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="seller_addTime" name="seller.addTime" class="form-control" placeholder="请输入注册时间">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxSellerAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#sellerAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加商家信息
	function ajaxSellerAdd() { 
		//提交之前先验证表单
		$("#sellerAddForm").data('bootstrapValidator').validate();
		if(!$("#sellerAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Seller/add",
			dataType : "json" , 
			data: new FormData($("#sellerAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#sellerAddForm").find("input").val("");
					$("#sellerAddForm").find("textarea").val("");
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
	//验证商家添加表单字段
	$('#sellerAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"seller.sellerUserName": {
				validators: {
					notEmpty: {
						message: "商家账号不能为空",
					}
				}
			},
			"seller.password": {
				validators: {
					notEmpty: {
						message: "预留密码段不能为空",
					}
				}
			},
			"seller.sellerName": {
				validators: {
					notEmpty: {
						message: "商户名称不能为空",
					}
				}
			},
			"seller.workContent": {
				validators: {
					notEmpty: {
						message: "经营内容不能为空",
					}
				}
			},
			"seller.workTime": {
				validators: {
					notEmpty: {
						message: "经营时间不能为空",
					}
				}
			},
			"seller.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"seller.workAddress": {
				validators: {
					notEmpty: {
						message: "工作地址不能为空",
					}
				}
			},
			"seller.scoreValue": {
				validators: {
					notEmpty: {
						message: "评价分数不能为空",
					},
					numeric: {
						message: "评价分数不正确"
					}
				}
			},
			"seller.shenHeState": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
			"seller.addTime": {
				validators: {
					notEmpty: {
						message: "注册时间不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>

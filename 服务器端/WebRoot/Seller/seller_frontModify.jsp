<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Seller" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Seller seller = (Seller)request.getAttribute("seller");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改商家信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">商家信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="sellerEditForm" id="sellerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="seller_sellerUserName_edit" class="col-md-3 text-right">商家账号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="seller_sellerUserName_edit" name="seller.sellerUserName" class="form-control" placeholder="请输入商家账号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="seller_password_edit" class="col-md-3 text-right">预留密码段:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_password_edit" name="seller.password" class="form-control" placeholder="请输入预留密码段">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerName_edit" class="col-md-3 text-right">商户名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_sellerName_edit" name="seller.sellerName" class="form-control" placeholder="请输入商户名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerPhoto_edit" class="col-md-3 text-right">商户照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="seller_sellerPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="seller_sellerPhoto" name="seller.sellerPhoto"/>
			    <input id="sellerPhotoFile" name="sellerPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_workContent_edit" class="col-md-3 text-right">经营内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_workContent_edit" name="seller.workContent" class="form-control" placeholder="请输入经营内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_workTime_edit" class="col-md-3 text-right">经营时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_workTime_edit" name="seller.workTime" class="form-control" placeholder="请输入经营时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_telephone_edit" name="seller.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_workAddress_edit" class="col-md-3 text-right">工作地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_workAddress_edit" name="seller.workAddress" class="form-control" placeholder="请输入工作地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_workLicense_edit" class="col-md-3 text-right">营业许可证:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="seller_workLicenseImg" border="0px"/><br/>
			    <input type="hidden" id="seller_workLicense" name="seller.workLicense"/>
			    <input id="workLicenseFile" name="workLicenseFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_scoreValue_edit" class="col-md-3 text-right">评价分数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_scoreValue_edit" name="seller.scoreValue" class="form-control" placeholder="请输入评价分数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_shenHeState_edit" name="seller.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_addTime_edit" class="col-md-3 text-right">注册时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_addTime_edit" name="seller.addTime" class="form-control" placeholder="请输入注册时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSellerModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#sellerEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改商家界面并初始化数据*/
function sellerEdit(sellerUserName) {
	$.ajax({
		url :  basePath + "Seller/" + sellerUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (seller, response, status) {
			if (seller) {
				$("#seller_sellerUserName_edit").val(seller.sellerUserName);
				$("#seller_password_edit").val(seller.password);
				$("#seller_sellerName_edit").val(seller.sellerName);
				$("#seller_sellerPhoto").val(seller.sellerPhoto);
				$("#seller_sellerPhotoImg").attr("src", basePath +　seller.sellerPhoto);
				$("#seller_workContent_edit").val(seller.workContent);
				$("#seller_workTime_edit").val(seller.workTime);
				$("#seller_telephone_edit").val(seller.telephone);
				$("#seller_workAddress_edit").val(seller.workAddress);
				$("#seller_workLicense").val(seller.workLicense);
				$("#seller_workLicenseImg").attr("src", basePath +　seller.workLicense);
				$("#seller_scoreValue_edit").val(seller.scoreValue);
				$("#seller_shenHeState_edit").val(seller.shenHeState);
				$("#seller_addTime_edit").val(seller.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交商家信息表单给服务器端修改*/
function ajaxSellerModify() {
	$.ajax({
		url :  basePath + "Seller/" + $("#seller_sellerUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#sellerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#sellerQueryForm").submit();
            }else{
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
    sellerEdit("<%=request.getParameter("sellerUserName")%>");
 })
 </script> 
</body>
</html>


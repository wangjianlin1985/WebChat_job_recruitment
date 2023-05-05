<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Evaluate" %>
<%@ page import="com.chengxusheji.po.Seller" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Evaluate> evaluateList = (List<Evaluate>)request.getAttribute("evaluateList");
    //获取所有的sellerObj信息
    List<Seller> sellerList = (List<Seller>)request.getAttribute("sellerList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Seller sellerObj = (Seller)request.getAttribute("sellerObj");
    String evaluateContent = (String)request.getAttribute("evaluateContent"); //评价内容查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商家评价查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#evaluateListPanel" aria-controls="evaluateListPanel" role="tab" data-toggle="tab">商家评价列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Evaluate/evaluate_frontAdd.jsp" style="display:none;">添加商家评价</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="evaluateListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>评价id</td><td>被评价商家</td><td>评分</td><td>评价内容</td><td>评论用户</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<evaluateList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Evaluate evaluate = evaluateList.get(i); //获取到商家评价对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=evaluate.getEvaluateId() %></td>
 											<td><%=evaluate.getSellerObj().getSellerName() %></td>
 											<td><%=evaluate.getEvaluateScore() %></td>
 											<td><%=evaluate.getEvaluateContent() %></td>
 											<td><%=evaluate.getUserObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Evaluate/<%=evaluate.getEvaluateId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="evaluateEdit('<%=evaluate.getEvaluateId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="evaluateDelete('<%=evaluate.getEvaluateId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>商家评价查询</h1>
		</div>
		<form name="evaluateQueryForm" id="evaluateQueryForm" action="<%=basePath %>Evaluate/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="sellerObj_sellerUserName">被评价商家：</label>
                <select id="sellerObj_sellerUserName" name="sellerObj.sellerUserName" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Seller sellerTemp:sellerList) {
	 					String selected = "";
 					if(sellerObj!=null && sellerObj.getSellerUserName()!=null && sellerObj.getSellerUserName().equals(sellerTemp.getSellerUserName()))
 						selected = "selected";
	 				%>
 				 <option value="<%=sellerTemp.getSellerUserName() %>" <%=selected %>><%=sellerTemp.getSellerName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="evaluateContent">评价内容:</label>
				<input type="text" id="evaluateContent" name="evaluateContent" value="<%=evaluateContent %>" class="form-control" placeholder="请输入评价内容">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">评论用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="evaluateEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商家评价信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="evaluateEditForm" id="evaluateEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="evaluate_evaluateId_edit" class="col-md-3 text-right">评价id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="evaluate_evaluateId_edit" name="evaluate.evaluateId" class="form-control" placeholder="请输入评价id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="evaluate_sellerObj_sellerUserName_edit" class="col-md-3 text-right">被评价商家:</label>
		  	 <div class="col-md-9">
			    <select id="evaluate_sellerObj_sellerUserName_edit" name="evaluate.sellerObj.sellerUserName" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="evaluate_evaluateScore_edit" class="col-md-3 text-right">评分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="evaluate_evaluateScore_edit" name="evaluate.evaluateScore" class="form-control" placeholder="请输入评分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="evaluate_evaluateContent_edit" class="col-md-3 text-right">评价内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="evaluate_evaluateContent_edit" name="evaluate.evaluateContent" rows="8" class="form-control" placeholder="请输入评价内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="evaluate_userObj_user_name_edit" class="col-md-3 text-right">评论用户:</label>
		  	 <div class="col-md-9">
			    <select id="evaluate_userObj_user_name_edit" name="evaluate.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="evaluate_evaluateTime_edit" class="col-md-3 text-right">评价时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="evaluate_evaluateTime_edit" name="evaluate.evaluateTime" class="form-control" placeholder="请输入评价时间">
			 </div>
		  </div>
		</form> 
	    <style>#evaluateEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxEvaluateModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.evaluateQueryForm.currentPage.value = currentPage;
    document.evaluateQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.evaluateQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.evaluateQueryForm.currentPage.value = pageValue;
    documentevaluateQueryForm.submit();
}

/*弹出修改商家评价界面并初始化数据*/
function evaluateEdit(evaluateId) {
	$.ajax({
		url :  basePath + "Evaluate/" + evaluateId + "/update",
		type : "get",
		dataType: "json",
		success : function (evaluate, response, status) {
			if (evaluate) {
				$("#evaluate_evaluateId_edit").val(evaluate.evaluateId);
				$.ajax({
					url: basePath + "Seller/listAll",
					type: "get",
					success: function(sellers,response,status) { 
						$("#evaluate_sellerObj_sellerUserName_edit").empty();
						var html="";
		        		$(sellers).each(function(i,seller){
		        			html += "<option value='" + seller.sellerUserName + "'>" + seller.sellerName + "</option>";
		        		});
		        		$("#evaluate_sellerObj_sellerUserName_edit").html(html);
		        		$("#evaluate_sellerObj_sellerUserName_edit").val(evaluate.sellerObjPri);
					}
				});
				$("#evaluate_evaluateScore_edit").val(evaluate.evaluateScore);
				$("#evaluate_evaluateContent_edit").val(evaluate.evaluateContent);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#evaluate_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#evaluate_userObj_user_name_edit").html(html);
		        		$("#evaluate_userObj_user_name_edit").val(evaluate.userObjPri);
					}
				});
				$("#evaluate_evaluateTime_edit").val(evaluate.evaluateTime);
				$('#evaluateEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商家评价信息*/
function evaluateDelete(evaluateId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Evaluate/deletes",
			data : {
				evaluateIds : evaluateId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#evaluateQueryForm").submit();
					//location.href= basePath + "Evaluate/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交商家评价信息表单给服务器端修改*/
function ajaxEvaluateModify() {
	$.ajax({
		url :  basePath + "Evaluate/" + $("#evaluate_evaluateId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#evaluateEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#evaluateQueryForm").submit();
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

})
</script>
</body>
</html>


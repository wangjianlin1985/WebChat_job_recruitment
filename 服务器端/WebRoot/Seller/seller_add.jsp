<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/seller.css" />
<div id="sellerAddDiv">
	<form id="sellerAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商家账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_sellerUserName" name="seller.sellerUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">预留密码段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_password" name="seller.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商户名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_sellerName" name="seller.sellerName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商户照片:</span>
			<span class="inputControl">
				<input id="sellerPhotoFile" name="sellerPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">经营内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workContent" name="seller.workContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">经营时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workTime" name="seller.workTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_telephone" name="seller.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workAddress" name="seller.workAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">营业许可证:</span>
			<span class="inputControl">
				<input id="workLicenseFile" name="workLicenseFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">评价分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_scoreValue" name="seller.scoreValue" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_shenHeState" name="seller.shenHeState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_addTime" name="seller.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="sellerAddButton" class="easyui-linkbutton">添加</a>
			<a id="sellerClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Seller/js/seller_add.js"></script> 

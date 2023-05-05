<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/seller.css" /> 

<div id="seller_manage"></div>
<div id="seller_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="seller_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="seller_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="seller_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="seller_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="seller_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="sellerQueryForm" method="post">
			商家账号：<input type="text" class="textbox" id="sellerUserName" name="sellerUserName" style="width:110px" />
			商户名称：<input type="text" class="textbox" id="sellerName" name="sellerName" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			审核状态：<input type="text" class="textbox" id="shenHeState" name="shenHeState" style="width:110px" />
			注册时间：<input type="text" class="textbox" id="addTime" name="addTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="seller_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="sellerEditDiv">
	<form id="sellerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商家账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_sellerUserName_edit" name="seller.sellerUserName" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">预留密码段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_password_edit" name="seller.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商户名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_sellerName_edit" name="seller.sellerName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商户照片:</span>
			<span class="inputControl">
				<img id="seller_sellerPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="seller_sellerPhoto" name="seller.sellerPhoto"/>
				<input id="sellerPhotoFile" name="sellerPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">经营内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workContent_edit" name="seller.workContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">经营时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workTime_edit" name="seller.workTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_telephone_edit" name="seller.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_workAddress_edit" name="seller.workAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">营业许可证:</span>
			<span class="inputControl">
				<img id="seller_workLicenseImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="seller_workLicense" name="seller.workLicense"/>
				<input id="workLicenseFile" name="workLicenseFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">评价分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_scoreValue_edit" name="seller.scoreValue" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_shenHeState_edit" name="seller.shenHeState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="seller_addTime_edit" name="seller.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Seller/js/seller_manage.js"></script> 

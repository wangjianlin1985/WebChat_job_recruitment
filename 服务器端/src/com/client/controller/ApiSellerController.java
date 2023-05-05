package com.client.controller;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.chengxusheji.po.Seller;
import com.chengxusheji.service.SellerService;
import com.client.service.AuthService;
import com.client.utils.JsonResult;
import com.client.utils.JsonResultBuilder;
import com.client.utils.ReturnCode;

@RestController
@RequestMapping("/api/seller") 
public class ApiSellerController {
	@Resource SellerService sellerService;
	@Resource AuthService authService;

	@InitBinder("seller")
	public void initBinderSeller(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("seller.");
	}

	/*客户端ajax方式添加商家信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public JsonResult add(@Validated Seller seller, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors()) //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR);
		if(sellerService.getSeller(seller.getSellerUserName()) != null) //验证主键是否重复
			return JsonResultBuilder.error(ReturnCode.PRIMARY_EXIST_ERROR);
        sellerService.addSeller(seller); //添加到数据库
        return JsonResultBuilder.ok();
	}

	/*客户端ajax更新商家信息*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JsonResult update(@Validated Seller seller, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors())  //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR); 
		seller.setShenHeState("待审核"); //商户修改个人信息后需要管理员重新审核
        sellerService.updateSeller(seller);  //更新记录到数据库
        return JsonResultBuilder.ok(sellerService.getSeller(seller.getSellerUserName()));
	}

	/*ajax方式显示获取商家详细信息*/
	@RequestMapping(value="/get/{sellerUserName}",method=RequestMethod.POST)
	public JsonResult getSeller(@PathVariable String sellerUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键sellerUserName获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerUserName); 
        return JsonResultBuilder.ok(seller);
	}
	
	
	/*ajax方式显示获取商家详细信息*/
	@RequestMapping(value="/selfGet",method=RequestMethod.POST)
	public JsonResult selfGetSeller(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息
		String sellerUserName = authService.getUserName(request);
		if(sellerUserName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		/*根据主键sellerUserName获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerUserName); 
        return JsonResultBuilder.ok(seller);
	}
	
	

	/*ajax方式删除商家记录*/
	@RequestMapping(value="/delete/{sellerUserName}",method=RequestMethod.POST)
	public JsonResult deleteSeller(@PathVariable String sellerUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		try {
			sellerService.deleteSeller(sellerUserName);
			return JsonResultBuilder.ok();
		} catch (Exception ex) {
			return JsonResultBuilder.error(ReturnCode.FOREIGN_KEY_CONSTRAINT_ERROR);
		}
	}

	//查询最新商户信息
	@RequestMapping(value="/zxList",method=RequestMethod.POST) 
	public JsonResult zxList(HttpServletRequest request,HttpServletResponse response) throws Exception  {
		int getSize = 8;
		List<Seller> sellerList = sellerService.queryZxSeller(getSize);
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
		resultMap.put("list", sellerList);
		return JsonResultBuilder.ok(resultMap);
	}
	
	//客户端查询商家信息
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public JsonResult list(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (sellerUserName == null) sellerUserName = "";
		if (sellerName == null) sellerName = "";
		if (telephone == null) telephone = "";
		if (shenHeState == null) shenHeState = "";
		if (addTime == null) addTime = "";
		if(rows != 0)sellerService.setRows(rows);
		List<Seller> sellerList = sellerService.querySeller(sellerUserName, sellerName, telephone, shenHeState, addTime, page);
	    /*计算总的页数和总的记录数*/
	    sellerService.queryTotalPageAndRecordNumber(sellerUserName, sellerName, telephone, shenHeState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = sellerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = sellerService.getRecordNumber();
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("totalPage", totalPage);
	    resultMap.put("list", sellerList);
	    return JsonResultBuilder.ok(resultMap);
	}

	//客户端ajax获取所有商家
	@RequestMapping(value="/listAll",method=RequestMethod.POST)
	public JsonResult listAll() throws Exception{
		List<Seller> sellerList = sellerService.queryAllSeller(); 
		return JsonResultBuilder.ok(sellerList);
	}
}


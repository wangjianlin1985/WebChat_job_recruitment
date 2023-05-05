package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.SellerService;
import com.chengxusheji.po.Seller;

//Seller管理控制层
@Controller
@RequestMapping("/Seller")
public class SellerController extends BaseController {

    /*业务层对象*/
    @Resource SellerService sellerService;

	@InitBinder("seller")
	public void initBinderSeller(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("seller.");
	}
	/*跳转到添加Seller视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Seller());
		return "Seller_add";
	}

	/*客户端ajax方式提交添加商家信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Seller seller, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(sellerService.getSeller(seller.getSellerUserName()) != null) {
			message = "商家账号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			seller.setSellerPhoto(this.handlePhotoUpload(request, "sellerPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			seller.setWorkLicense(this.handlePhotoUpload(request, "workLicenseFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        sellerService.addSeller(seller);
        message = "商家添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
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
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Seller seller:sellerList) {
			JSONObject jsonSeller = seller.getJsonObject();
			jsonArray.put(jsonSeller);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Seller> sellerList = sellerService.queryAllSeller();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Seller seller:sellerList) {
			JSONObject jsonSeller = new JSONObject();
			jsonSeller.accumulate("sellerUserName", seller.getSellerUserName());
			jsonSeller.accumulate("sellerName", seller.getSellerName());
			jsonArray.put(jsonSeller);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sellerUserName == null) sellerUserName = "";
		if (sellerName == null) sellerName = "";
		if (telephone == null) telephone = "";
		if (shenHeState == null) shenHeState = "";
		if (addTime == null) addTime = "";
		List<Seller> sellerList = sellerService.querySeller(sellerUserName, sellerName, telephone, shenHeState, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    sellerService.queryTotalPageAndRecordNumber(sellerUserName, sellerName, telephone, shenHeState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = sellerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = sellerService.getRecordNumber();
	    request.setAttribute("sellerList",  sellerList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("sellerUserName", sellerUserName);
	    request.setAttribute("sellerName", sellerName);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("shenHeState", shenHeState);
	    request.setAttribute("addTime", addTime);
		return "Seller/seller_frontquery_result"; 
	}

     /*前台查询Seller信息*/
	@RequestMapping(value="/{sellerUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String sellerUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键sellerUserName获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerUserName);

        request.setAttribute("seller",  seller);
        return "Seller/seller_frontshow";
	}

	/*ajax方式显示商家修改jsp视图页*/
	@RequestMapping(value="/{sellerUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String sellerUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键sellerUserName获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSeller = seller.getJsonObject();
		out.println(jsonSeller.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新商家信息*/
	@RequestMapping(value = "/{sellerUserName}/update", method = RequestMethod.POST)
	public void update(@Validated Seller seller, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String sellerPhotoFileName = this.handlePhotoUpload(request, "sellerPhotoFile");
		if(!sellerPhotoFileName.equals("upload/NoImage.jpg"))seller.setSellerPhoto(sellerPhotoFileName); 


		String workLicenseFileName = this.handlePhotoUpload(request, "workLicenseFile");
		if(!workLicenseFileName.equals("upload/NoImage.jpg"))seller.setWorkLicense(workLicenseFileName); 


		try {
			sellerService.updateSeller(seller);
			message = "商家更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "商家更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除商家信息*/
	@RequestMapping(value="/{sellerUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String sellerUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  sellerService.deleteSeller(sellerUserName);
	            request.setAttribute("message", "商家删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "商家删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条商家记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String sellerUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = sellerService.deleteSellers(sellerUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出商家信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(sellerUserName == null) sellerUserName = "";
        if(sellerName == null) sellerName = "";
        if(telephone == null) telephone = "";
        if(shenHeState == null) shenHeState = "";
        if(addTime == null) addTime = "";
        List<Seller> sellerList = sellerService.querySeller(sellerUserName,sellerName,telephone,shenHeState,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Seller信息记录"; 
        String[] headers = { "商家账号","商户名称","商户照片","经营时间","联系电话","工作地址","营业许可证","评价分数","审核状态","注册时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<sellerList.size();i++) {
        	Seller seller = sellerList.get(i); 
        	dataset.add(new String[]{seller.getSellerUserName(),seller.getSellerName(),seller.getSellerPhoto(),seller.getWorkTime(),seller.getTelephone(),seller.getWorkAddress(),seller.getWorkLicense(),seller.getScoreValue() + "",seller.getShenHeState(),seller.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Seller.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}

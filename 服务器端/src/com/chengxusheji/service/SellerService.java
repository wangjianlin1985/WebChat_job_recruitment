package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Seller;

import com.chengxusheji.mapper.SellerMapper;
@Service
public class SellerService {

	@Resource SellerMapper sellerMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加商家记录*/
    public void addSeller(Seller seller) throws Exception {
    	sellerMapper.addSeller(seller);
    }

    /*按照查询条件分页查询商家记录*/
    public ArrayList<Seller> querySeller(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!sellerUserName.equals("")) where = where + " and t_seller.sellerUserName like '%" + sellerUserName + "%'";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_seller.telephone like '%" + telephone + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_seller.shenHeState like '%" + shenHeState + "%'";
    	if(!addTime.equals("")) where = where + " and t_seller.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return sellerMapper.querySeller(where, startIndex, this.rows);
    }
    
    /*查询最新入住的商户*/
    public ArrayList<Seller> queryZxSeller(int getSize) throws Exception { 
     	String where = "where shenHeState='已审核' order by addTime DESC"; 
    	return sellerMapper.queryZxSeller(where, getSize);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Seller> querySeller(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!sellerUserName.equals("")) where = where + " and t_seller.sellerUserName like '%" + sellerUserName + "%'";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_seller.telephone like '%" + telephone + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_seller.shenHeState like '%" + shenHeState + "%'";
    	if(!addTime.equals("")) where = where + " and t_seller.addTime like '%" + addTime + "%'";
    	return sellerMapper.querySellerList(where);
    }

    /*查询所有商家记录*/
    public ArrayList<Seller> queryAllSeller()  throws Exception {
        return sellerMapper.querySellerList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String sellerUserName,String sellerName,String telephone,String shenHeState,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!sellerUserName.equals("")) where = where + " and t_seller.sellerUserName like '%" + sellerUserName + "%'";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_seller.telephone like '%" + telephone + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_seller.shenHeState like '%" + shenHeState + "%'";
    	if(!addTime.equals("")) where = where + " and t_seller.addTime like '%" + addTime + "%'";
        recordNumber = sellerMapper.querySellerCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商家记录*/
    public Seller getSeller(String sellerUserName) throws Exception  {
        Seller seller = sellerMapper.getSeller(sellerUserName);
        return seller;
    }

    /*根据微信openid获取商家记录*/
    public Seller getSellerByOpenid(String openid) throws Exception {
		Seller seller = sellerMapper.getSellerByOpenid(openid);
		return seller;
	}
    
    
    /*更新商家记录*/
    public void updateSeller(Seller seller) throws Exception {
        sellerMapper.updateSeller(seller);
    }

    /*关联读者微信openid记录*/
    public void updateSellerOpenid(String sellerUserName,String openId) throws Exception {
        sellerMapper.updateSellerOpenid(sellerUserName, openId);
    }
    
    
    /*删除一条商家记录*/
    public void deleteSeller (String sellerUserName) throws Exception {
        sellerMapper.deleteSeller(sellerUserName);
    }

    /*删除多条商家信息*/
    public int deleteSellers (String sellerUserNames) throws Exception {
    	String _sellerUserNames[] = sellerUserNames.split(",");
    	for(String _sellerUserName: _sellerUserNames) {
    		sellerMapper.deleteSeller(_sellerUserName);
    	}
    	return _sellerUserNames.length;
    }
    
    
	
}

package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Seller;
import com.chengxusheji.po.UserInfo;

public interface SellerMapper {
	/*添加商家信息*/
	public void addSeller(Seller seller) throws Exception;

	/*按照查询条件分页查询商家记录*/
	public ArrayList<Seller> querySeller(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*查询最新入住商家记录*/
	public ArrayList<Seller> queryZxSeller(@Param("where") String where,@Param("pageSize") int pageSize) throws Exception;
	
	/*按照查询条件查询所有商家记录*/
	public ArrayList<Seller> querySellerList(@Param("where") String where) throws Exception;

	/*按照查询条件的商家记录数*/
	public int querySellerCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商家记录*/
	public Seller getSeller(String sellerUserName) throws Exception;
	
	/*根据openid查询某条商户记录*/
	public Seller getSellerByOpenid(String openid) throws Exception;

	/*更新商家记录*/
	public void updateSeller(Seller seller) throws Exception;
	
	/*关联商户的微信openid*/
	public void updateSellerOpenid(@Param("sellerUserName")String sellerUserName,@Param("openid")String openid) throws Exception;
	
	/*删除商家记录*/
	public void deleteSeller(String sellerUserName) throws Exception;

}

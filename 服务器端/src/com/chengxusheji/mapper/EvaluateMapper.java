package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Evaluate;

public interface EvaluateMapper {
	/*添加商家评价信息*/
	public void addEvaluate(Evaluate evaluate) throws Exception;

	/*按照查询条件分页查询商家评价记录*/
	public ArrayList<Evaluate> queryEvaluate(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商家评价记录*/
	public ArrayList<Evaluate> queryEvaluateList(@Param("where") String where) throws Exception;

	/*按照查询条件的商家评价记录数*/
	public int queryEvaluateCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商家评价记录*/
	public Evaluate getEvaluate(int evaluateId) throws Exception;

	/*更新商家评价记录*/
	public void updateEvaluate(Evaluate evaluate) throws Exception;

	/*删除商家评价记录*/
	public void deleteEvaluate(int evaluateId) throws Exception;

}

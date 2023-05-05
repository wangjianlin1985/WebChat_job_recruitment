package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Seller;
import com.chengxusheji.po.Job;

import com.chengxusheji.mapper.JobMapper;
@Service
public class JobService {

	@Resource JobMapper jobMapper;
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

    /*添加职位记录*/
    public void addJob(Job job) throws Exception {
    	jobMapper.addJob(job);
    }

    /*按照查询条件分页查询职位记录*/
    public ArrayList<Job> queryJob(String jobName,String workAddress,String connectPerson,String telephone,Seller sellerObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!jobName.equals("")) where = where + " and t_job.jobName like '%" + jobName + "%'";
    	if(!workAddress.equals("")) where = where + " and t_job.workAddress like '%" + workAddress + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_job.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_job.telephone like '%" + telephone + "%'";
    	if(null != sellerObj &&  sellerObj.getSellerUserName() != null  && !sellerObj.getSellerUserName().equals(""))  where += " and t_job.sellerObj='" + sellerObj.getSellerUserName() + "'";
    	if(!addTime.equals("")) where = where + " and t_job.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return jobMapper.queryJob(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Job> queryJob(String jobName,String workAddress,String connectPerson,String telephone,Seller sellerObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!jobName.equals("")) where = where + " and t_job.jobName like '%" + jobName + "%'";
    	if(!workAddress.equals("")) where = where + " and t_job.workAddress like '%" + workAddress + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_job.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_job.telephone like '%" + telephone + "%'";
    	if(null != sellerObj &&  sellerObj.getSellerUserName() != null && !sellerObj.getSellerUserName().equals(""))  where += " and t_job.sellerObj='" + sellerObj.getSellerUserName() + "'";
    	if(!addTime.equals("")) where = where + " and t_job.addTime like '%" + addTime + "%'";
    	return jobMapper.queryJobList(where);
    }

    /*查询所有职位记录*/
    public ArrayList<Job> queryAllJob()  throws Exception {
        return jobMapper.queryJobList("where 1=1");
    }
    
    
    /*查询所有职位记录*/
    public ArrayList<Job> sellerQueryAllJob(String sellerUserName)  throws Exception {
        return jobMapper.queryJobList("where 1=1 and t_job.sellerObj='" + sellerUserName + "'");
    }
    
    

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String jobName,String workAddress,String connectPerson,String telephone,Seller sellerObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!jobName.equals("")) where = where + " and t_job.jobName like '%" + jobName + "%'";
    	if(!workAddress.equals("")) where = where + " and t_job.workAddress like '%" + workAddress + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_job.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_job.telephone like '%" + telephone + "%'";
    	if(null != sellerObj &&  sellerObj.getSellerUserName() != null && !sellerObj.getSellerUserName().equals(""))  where += " and t_job.sellerObj='" + sellerObj.getSellerUserName() + "'";
    	if(!addTime.equals("")) where = where + " and t_job.addTime like '%" + addTime + "%'";
        recordNumber = jobMapper.queryJobCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取职位记录*/
    public Job getJob(int jobId) throws Exception  {
        Job job = jobMapper.getJob(jobId);
        return job;
    }

    /*更新职位记录*/
    public void updateJob(Job job) throws Exception {
        jobMapper.updateJob(job);
    }

    /*删除一条职位记录*/
    public void deleteJob (int jobId) throws Exception {
        jobMapper.deleteJob(jobId);
    }

    /*删除多条职位信息*/
    public int deleteJobs (String jobIds) throws Exception {
    	String _jobIds[] = jobIds.split(",");
    	for(String _jobId: _jobIds) {
    		jobMapper.deleteJob(Integer.parseInt(_jobId));
    	}
    	return _jobIds.length;
    }
}

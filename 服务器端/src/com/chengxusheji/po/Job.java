package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Job {
    /*职位id*/
    private Integer jobId;
    public Integer getJobId(){
        return jobId;
    }
    public void setJobId(Integer jobId){
        this.jobId = jobId;
    }

    /*职位名称*/
    @NotEmpty(message="职位名称不能为空")
    private String jobName;
    public String getJobName() {
        return jobName;
    }
    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    /*职位描述*/
    @NotEmpty(message="职位描述不能为空")
    private String jobDesc;
    public String getJobDesc() {
        return jobDesc;
    }
    public void setJobDesc(String jobDesc) {
        this.jobDesc = jobDesc;
    }

    /*工作薪酬*/
    @NotEmpty(message="工作薪酬不能为空")
    private String workPay;
    public String getWorkPay() {
        return workPay;
    }
    public void setWorkPay(String workPay) {
        this.workPay = workPay;
    }

    /*招聘人数*/
    @NotNull(message="必须输入招聘人数")
    private Integer needNum;
    public Integer getNeedNum() {
        return needNum;
    }
    public void setNeedNum(Integer needNum) {
        this.needNum = needNum;
    }

    /*工作地址*/
    @NotEmpty(message="工作地址不能为空")
    private String workAddress;
    public String getWorkAddress() {
        return workAddress;
    }
    public void setWorkAddress(String workAddress) {
        this.workAddress = workAddress;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String connectPerson;
    public String getConnectPerson() {
        return connectPerson;
    }
    public void setConnectPerson(String connectPerson) {
        this.connectPerson = connectPerson;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*发布商家*/
    private Seller sellerObj;
    public Seller getSellerObj() {
        return sellerObj;
    }
    public void setSellerObj(Seller sellerObj) {
        this.sellerObj = sellerObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJob=new JSONObject(); 
		jsonJob.accumulate("jobId", this.getJobId());
		jsonJob.accumulate("jobName", this.getJobName());
		jsonJob.accumulate("jobDesc", this.getJobDesc());
		jsonJob.accumulate("workPay", this.getWorkPay());
		jsonJob.accumulate("needNum", this.getNeedNum());
		jsonJob.accumulate("workAddress", this.getWorkAddress());
		jsonJob.accumulate("connectPerson", this.getConnectPerson());
		jsonJob.accumulate("telephone", this.getTelephone());
		jsonJob.accumulate("sellerObj", this.getSellerObj().getSellerName());
		jsonJob.accumulate("sellerObjPri", this.getSellerObj().getSellerUserName());
		jsonJob.accumulate("addTime", this.getAddTime());
		return jsonJob;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Delivery {
    /*投递id*/
    private Integer deliveryId;
    public Integer getDeliveryId(){
        return deliveryId;
    }
    public void setDeliveryId(Integer deliveryId){
        this.deliveryId = deliveryId;
    }

    /*投递职位*/
    private Job jobObj;
    public Job getJobObj() {
        return jobObj;
    }
    public void setJobObj(Job jobObj) {
        this.jobObj = jobObj;
    }

    /*投递人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*投递时间*/
    @NotEmpty(message="投递时间不能为空")
    private String deliveryTime;
    public String getDeliveryTime() {
        return deliveryTime;
    }
    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    /*处理状态*/
    @NotEmpty(message="处理状态不能为空")
    private String handleState;
    public String getHandleState() {
        return handleState;
    }
    public void setHandleState(String handleState) {
        this.handleState = handleState;
    }

    /*处理内容*/
    @NotEmpty(message="处理内容不能为空")
    private String handleContent;
    public String getHandleContent() {
        return handleContent;
    }
    public void setHandleContent(String handleContent) {
        this.handleContent = handleContent;
    }

    /*对学生评价*/
    @NotEmpty(message="对学生评价不能为空")
    private String evaluate;
    public String getEvaluate() {
        return evaluate;
    }
    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDelivery=new JSONObject(); 
		jsonDelivery.accumulate("deliveryId", this.getDeliveryId());
		jsonDelivery.accumulate("jobObj", this.getJobObj().getJobName());
		jsonDelivery.accumulate("jobObjPri", this.getJobObj().getJobId());
		jsonDelivery.accumulate("userObj", this.getUserObj().getName());
		jsonDelivery.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonDelivery.accumulate("deliveryTime", this.getDeliveryTime());
		jsonDelivery.accumulate("handleState", this.getHandleState());
		jsonDelivery.accumulate("handleContent", this.getHandleContent());
		jsonDelivery.accumulate("evaluate", this.getEvaluate());
		return jsonDelivery;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
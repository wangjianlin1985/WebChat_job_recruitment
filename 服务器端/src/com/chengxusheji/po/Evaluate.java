package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Evaluate {
    /*评价id*/
    private Integer evaluateId;
    public Integer getEvaluateId(){
        return evaluateId;
    }
    public void setEvaluateId(Integer evaluateId){
        this.evaluateId = evaluateId;
    }

    /*被评价商家*/
    private Seller sellerObj;
    public Seller getSellerObj() {
        return sellerObj;
    }
    public void setSellerObj(Seller sellerObj) {
        this.sellerObj = sellerObj;
    }

    /*评分*/
    @NotNull(message="必须输入评分")
    private Float evaluateScore;
    public Float getEvaluateScore() {
        return evaluateScore;
    }
    public void setEvaluateScore(Float evaluateScore) {
        this.evaluateScore = evaluateScore;
    }

    /*评价内容*/
    @NotEmpty(message="评价内容不能为空")
    private String evaluateContent;
    public String getEvaluateContent() {
        return evaluateContent;
    }
    public void setEvaluateContent(String evaluateContent) {
        this.evaluateContent = evaluateContent;
    }

    /*评论用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评价时间*/
    @NotEmpty(message="评价时间不能为空")
    private String evaluateTime;
    public String getEvaluateTime() {
        return evaluateTime;
    }
    public void setEvaluateTime(String evaluateTime) {
        this.evaluateTime = evaluateTime;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonEvaluate=new JSONObject(); 
		jsonEvaluate.accumulate("evaluateId", this.getEvaluateId());
		jsonEvaluate.accumulate("sellerObj", this.getSellerObj().getSellerName());
		jsonEvaluate.accumulate("sellerObjPri", this.getSellerObj().getSellerUserName());
		jsonEvaluate.accumulate("evaluateScore", this.getEvaluateScore());
		jsonEvaluate.accumulate("evaluateContent", this.getEvaluateContent());
		jsonEvaluate.accumulate("userObj", this.getUserObj().getName());
		jsonEvaluate.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonEvaluate.accumulate("evaluateTime", this.getEvaluateTime());
		return jsonEvaluate;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
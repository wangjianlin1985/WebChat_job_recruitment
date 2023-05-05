package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Seller {
    /*商家账号*/
    @NotEmpty(message="商家账号不能为空")
    private String sellerUserName;
    public String getSellerUserName(){
        return sellerUserName;
    }
    public void setSellerUserName(String sellerUserName){
        this.sellerUserName = sellerUserName;
    }

    /*预留密码段*/
    @NotEmpty(message="预留密码段不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*商户名称*/
    @NotEmpty(message="商户名称不能为空")
    private String sellerName;
    public String getSellerName() {
        return sellerName;
    }
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    /*商户照片*/
    private String sellerPhoto;
    public String getSellerPhoto() {
        return sellerPhoto;
    }
    public void setSellerPhoto(String sellerPhoto) {
        this.sellerPhoto = sellerPhoto;
    }

    private String sellerPhotoUrl;
    public void setSellerPhotoUrl(String sellerPhotoUrl) {
		this.sellerPhotoUrl = sellerPhotoUrl;
	}
	public String getSellerPhotoUrl() {
		return  SessionConsts.BASE_URL + sellerPhoto;
	}
    /*经营内容*/
    @NotEmpty(message="经营内容不能为空")
    private String workContent;
    public String getWorkContent() {
        return workContent;
    }
    public void setWorkContent(String workContent) {
        this.workContent = workContent;
    }

    /*经营时间*/
    @NotEmpty(message="经营时间不能为空")
    private String workTime;
    public String getWorkTime() {
        return workTime;
    }
    public void setWorkTime(String workTime) {
        this.workTime = workTime;
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

    /*工作地址*/
    @NotEmpty(message="工作地址不能为空")
    private String workAddress;
    public String getWorkAddress() {
        return workAddress;
    }
    public void setWorkAddress(String workAddress) {
        this.workAddress = workAddress;
    }

    /*营业许可证*/
    private String workLicense;
    public String getWorkLicense() {
        return workLicense;
    }
    public void setWorkLicense(String workLicense) {
        this.workLicense = workLicense;
    }

    private String workLicenseUrl;
    public void setWorkLicenseUrl(String workLicenseUrl) {
		this.workLicenseUrl = workLicenseUrl;
	}
	public String getWorkLicenseUrl() {
		return  SessionConsts.BASE_URL + workLicense;
	}
    /*评价分数*/
    @NotNull(message="必须输入评价分数")
    private Float scoreValue;
    public Float getScoreValue() {
        return scoreValue;
    }
    public void setScoreValue(Float scoreValue) {
        this.scoreValue = scoreValue;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    /*注册时间*/
    @NotEmpty(message="注册时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSeller=new JSONObject(); 
		jsonSeller.accumulate("sellerUserName", this.getSellerUserName());
		jsonSeller.accumulate("password", this.getPassword());
		jsonSeller.accumulate("sellerName", this.getSellerName());
		jsonSeller.accumulate("sellerPhoto", this.getSellerPhoto());
		jsonSeller.accumulate("workContent", this.getWorkContent());
		jsonSeller.accumulate("workTime", this.getWorkTime());
		jsonSeller.accumulate("telephone", this.getTelephone());
		jsonSeller.accumulate("workAddress", this.getWorkAddress());
		jsonSeller.accumulate("workLicense", this.getWorkLicense());
		jsonSeller.accumulate("scoreValue", this.getScoreValue());
		jsonSeller.accumulate("shenHeState", this.getShenHeState());
		jsonSeller.accumulate("addTime", this.getAddTime());
		return jsonSeller;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
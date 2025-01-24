package com.TTteamProject.model;

import com.google.gson.annotations.SerializedName;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
// 복지정책 
public class PolicyDTO {

	// @SerializedName 사용이유 : AJAX로 데이터 가져올 때 필드이름과 JSON필드 이름을 명확히 매핑하기 위함
	// 정책 식별자
	@SerializedName("policy_idx")
	private Double policy_idx;

	// 지역 식별자
	@SerializedName("region_name")
	private String region_name;
	
	// 복지 분류
	@SerializedName("welfare_name")
	private String welfare_name;

	// 복지 제목
	@SerializedName("welfare_title")
	private String welfare_title;

	// 복지 내용
	@SerializedName("welfare_content")
	private String welfare_content;

	// 복지 URL
	@SerializedName("welfare_url")
	private String welfare_url;

	// 복지 신청기간
	@SerializedName("welfare_period")
	private String welfare_period;

	// 복지 첨부파일
	@SerializedName("policy_file")
	private String policy_file;
	
	

//	    public Double getPolicyIdx() {
//	        return POLICY_IDX;
//	    }
//
//	    public void setPolicyIdx(Double policyIdx) {
//	        this.POLICY_IDX = POLICY_IDX;
//	    }
//
//	    public Double getRegionIdx() {
//	        return REGION_IDX;
//	    }
//
//	    public void setRegionIdx(Double regionIdx) {
//	        this.REGION_IDX = REGION_IDX;
//	    }
//
//	    public String getWelfareTitle() {
//	        return WELFARE_TITLE;
//	    }
//
//	    public void setWelfareTitle(String welfareTitle) {
//	        this.WELFARE_TITLE = WELFARE_TITLE;
//	    }
//
//	    public String getWelfareContent() {
//	        return WELFARE_CONTENT;
//	    }
//
//	    public void setWelfareContent(String welfareContent) {
//	        this.WELFARE_CONTENT = WELFARE_CONTENT;
//	    }
//
//	    public String getWelfareUrl() {
//	        return WELFARE_URL;
//	    }
//
//	    public void setWelfareUrl(String welfareUrl) {
//	        this.WELFARE_URL = WELFARE_URL;
//	    }
//
//	    public String getWelfarePeriod() {
//	        return WELFARE_PERIOD;
//	    }
//
//	    public void setWelfarePeriod(String welfarePeriod) {
//	        this.WELFARE_PERIOD = WELFARE_PERIOD;
//	    }
//
//	    public String getPolicyFile() {
//	        return POLICY_FILE;
//	    }
//
//	    public void setPolicyFile(String policyFile) {
//	        this.POLICY_FILE = POLICY_FILE;
//	    }

	// TB_POLICY 모델 복사
//	    public void CopyData(TB_POLICY param)
//	    {
//	        this.POLICY_IDX = param.getPolicyIdx();
//	        this.REGION_IDX = param.getRegionIdx();
//	        this.WELFARE_TITLE = param.getWelfareTitle();
//	        this.WELFARE_CONTENT = param.getWelfareContent();
//	        this.WELFARE_URL = param.getWelfareUrl();
//	        this.WELFARE_PERIOD = param.getWelfarePeriod();
//	        this.POLICY_FILE = param.getPolicyFile();
//	    }

}

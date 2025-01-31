package com.TTteamProject.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class BoardDTO {
 private BigDecimal b_idx;
 private String user_id;
 private String b_content;
 private String b_category;
 private String b_title;
 private Timestamp create_dt;
 
 public BoardDTO(String userId, String b_content, String b_category, String b_title) {
		super();
		this.user_id = userId;
		this.b_content = b_content;
		this.b_category = b_category;
		this.b_title = b_title;
	}
 
public BoardDTO(BigDecimal b_idx, String userId, String b_content, String b_category, String b_title,
		Timestamp create_dt) {
	super();
	this.b_idx = b_idx;
	this.user_id = userId;
	this.b_content = b_content;
	this.b_category = b_category;
	this.b_title = b_title;
	this.create_dt = create_dt;
}

public BoardDTO(BigDecimal b_idx, String b_category, String b_title, String user_id, Timestamp create_dt) {
	super();
	this.b_idx = b_idx;
	this.b_category = b_category;
	this.b_title = b_title;
	this.user_id = user_id;
	this.create_dt = create_dt;
}





public BigDecimal getB_idx() {
	return b_idx;
}
public void setB_idx(BigDecimal b_idx) {
	this.b_idx = b_idx;
}
public String getUserId() {
	return user_id;
}
public void setUserId(String userId) {
	this.user_id = userId;
}
public String getB_content() {
	return b_content;
}
public void setB_content(String b_content) {
	this.b_content = b_content;
}
public String getB_category() {
	return b_category;
}
public void setB_category(String b_category) {
	this.b_category = b_category;
}
public String getB_title() {
	return b_title;
}
public void setB_title(String b_title) {
	this.b_title = b_title;
}
public Timestamp getCreate_dt() {
	return create_dt;
}
public void setCreate_dt(Timestamp create_dt) {
	this.create_dt = create_dt;
}

 
 
 
}

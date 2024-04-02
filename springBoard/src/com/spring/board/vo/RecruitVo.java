package com.spring.board.vo;

public class RecruitVo {
/*
 * 	SEQ	VARCHAR(255)		NOT NULL,
	NAME	VARCHAR(255)		NULL,
	BIRTH	VARCHAR(255)		NULL,
	Field3	VARCHAR(255)		NULL,
	PHONE	VARCHAR(255)		NULL,
	EMAIL	VARCHAR(255)		NULL,
	ADDR	VARCHAR(255)		NULL
	LOCATION	VARCHAR(255)	NULL,
	WORK_TYPE	VARCHAR(255)	NULL,
	SUBMIT	VARCHAR(255)	NULL
 * */
	private String SEQ; //pk
	private String name;
	private String birth;
	private String gender; //gender?
	private String phone;
	private String email;
	private String addr; //주소
	private String location; //희망근무지
	private String workType; //근무형태
	private String submit; //제출여부
	
	@Override
	public String toString() {
		return "RecruitVo [SEQ=" + SEQ + ", name=" + name + ", birth=" + birth + ", gender=" + gender + ", phone="
				+ phone + ", email=" + email + ", addr=" + addr + ", location=" + location + ", workType=" + workType
				+ ", submit=" + submit + "]";
	}
	
	public String getSEQ() {
		return SEQ;
	}
	public void setSEQ(String sEQ) {
		SEQ = sEQ;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getSubmit() {
		return submit;
	}
	public void setSubmit(String submit) {
		this.submit = submit;
	}
	
	
	
	
	
}

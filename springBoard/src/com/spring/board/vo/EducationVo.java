package com.spring.board.vo;

public class EducationVo {
/*
 * 	EDU_SEQ	VARCHAR(255)		NOT NULL,
	SEQ	VARCHAR(255)		NOT NULL,
	SCHOOL_NAME	VARCHAR(255)		NULL,
	DIVISION	VARCHAR(255)		NULL,
	START_PERIOD	VARCHAR(255)		NULL,
	END_PERIOD	VARCHAR(255)		NULL,
	MAJOR	VARCHAR(255)		NULL,
	GRADE	VARCHAR(255)		NULL,
	LOCATION	VARCHAR(255)	NULL
 * */

	private String name;
	private String phone;
	
	private int seq; 
	private int edu_seq;
	
	private String school_name;
	private String division;
	private double start_period;
	private double end_period;
	private String major;
	private double grade;
	private String location;
	
	@Override
	public String toString() {
		return "EducationVo [name=" + name + ", phone=" + phone + ", seq=" + seq + ", edu_seq=" + edu_seq
				+ ", school_name=" + school_name + ", division=" + division + ", start_period=" + start_period
				+ ", end_period=" + end_period + ", major=" + major + ", grade=" + grade + ", location=" + location
				+ "]";
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getEdu_seq() {
		return edu_seq;
	}
	public void setEdu_seq(int edu_seq) {
		this.edu_seq = edu_seq;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public double getStart_period() {
		return start_period;
	}
	public void setStart_period(double start_period) {
		this.start_period = start_period;
	}
	public double getEnd_period() {
		return end_period;
	}
	public void setEnd_period(double end_period) {
		this.end_period = end_period;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}

	
	
}

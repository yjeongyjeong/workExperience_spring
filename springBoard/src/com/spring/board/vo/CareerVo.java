package com.spring.board.vo;

public class CareerVo {
/*
 * 	CAR_SEQ	VARCHAR(255)		NOT NULL,
	SEQ	VARCHAR(255)		NOT NULL,
	COMP_NAME	VARCHAR(255)		NULL,
	LOCATION	VARCHAR(255)		NULL,
	START_PERIOD	VARCHAR(255)		NULL,
	END_PERIOD	VARCHAR(255)		NULL,
	TASK	VARCHAR(255)		NULL,
	SALARY	VARCHAR(255)		NULL
 * */
	private String name;
	private String phone;
	
	private int seq;
	private int car_seq;
	
	private String comp_name;
	private String location;
	private String start_period;
	private String end_period;
	private String task;
	private String salary;
	

	@Override
	public String toString() {
		return "CareerVo [name=" + name + ", phone=" + phone + ", seq=" + seq + ", car_seq=" + car_seq + ", comp_name="
				+ comp_name + ", location=" + location + ", start_period=" + start_period + ", end_period=" + end_period
				+ ", task=" + task + ", salary=" + salary + "]";
	}
	
	

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getCar_seq() {
		return car_seq;
	}

	public void setCar_seq(int car_seq) {
		this.car_seq = car_seq;
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

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getStart_period() {
		return start_period;
	}

	public void setStart_period(String start_period) {
		this.start_period = start_period;
	}

	public String getEnd_period() {
		return end_period;
	}

	public void setEnd_period(String end_period) {
		this.end_period = end_period;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}
	
}

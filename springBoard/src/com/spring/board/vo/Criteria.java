package com.spring.board.vo;

import java.util.List;

public class Criteria {
	
	private int pageNo = 1;
	private int amount = 10; //page 당 데이터 개수
	private String type; // a01, a02 ...
	
	private String codeType = "menu"; //기본값
	private List<String> codeId; //a01, a02.. 
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNo, int amount) {
		this.pageNo = pageNo;
		if(pageNo <= 1) {this.pageNo = 0;}
		this.amount = amount;
	}
	
	/*
	 * public String[] getTypeArr() { return type == null ? new String[] {} :
	 * type.split(","); }
	 */

	
	
	
	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public List<String> getCodeId() {
		return codeId;
	}

	public void setCodeId(List<String> codeId) {
		this.codeId = codeId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	


	
	
}

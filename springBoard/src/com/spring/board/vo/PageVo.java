package com.spring.board.vo;

import java.util.List;

public class PageVo {
	
	private int pageNo = 0;
	private String codeType = "menu"; //�⺻��
	private List<String> codeId; //a01, a02.. 
	

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
	


	
	
}

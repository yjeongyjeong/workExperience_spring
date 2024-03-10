package com.spring.board.vo;

import org.springframework.stereotype.Component;

@Component
public class ComCodeVo {
	private String codeType;
	private String codeId;
	private String codeName;
	private String 	creator;
	private String	modifier;
	
	
	@Override
	public String toString() {
		return "ComCodeVo [codeType=" + codeType + ", codeId=" + codeId + ", codeName=" + codeName + ", creator="
				+ creator + ", modifier=" + modifier + "]";
	}
	
	public ComCodeVo() {
		super();
	}
	public String getCodeType() {
		return codeType;
	}
	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	
	
}

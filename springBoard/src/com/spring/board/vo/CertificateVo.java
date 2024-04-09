package com.spring.board.vo;

public class CertificateVo {
/*
 * 	CERT_SEQ	VARCHAR(255)		NOT NULL,
	SEQ	VARCHAR(255)		NOT NULL,
	QUALIFI_NAME	VARCHAR(255)		NULL,
	ACQU_DATE	VARCHAR(255)		NULL,
	ORGANIZE_NAME	VARCHAR(255)		NULL
 * */
	private String name;
	private String phone;
	
	private String sert_seq;
	private String seq;
	
	private String qualifi_name; 
	private String acqu_date;
	private String organize_name;
	
	@Override
	public String toString() {
		return "CertificateVo [name=" + name + ", phone=" + phone + ", sert_seq=" + sert_seq + ", seq=" + seq
				+ ", qualifi_name=" + qualifi_name + ", acqu_date=" + acqu_date + ", organize_name=" + organize_name
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

	public String getSert_seq() {
		return sert_seq;
	}

	public void setSert_seq(String sert_seq) {
		this.sert_seq = sert_seq;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getQualifi_name() {
		return qualifi_name;
	}

	public void setQualifi_name(String qualifi_name) {
		this.qualifi_name = qualifi_name;
	}

	public String getAcqu_date() {
		return acqu_date;
	}

	public void setAcqu_date(String acqu_date) {
		this.acqu_date = acqu_date;
	}

	public String getOrganize_name() {
		return organize_name;
	}

	public void setOrganize_name(String organize_name) {
		this.organize_name = organize_name;
	}
	
	
}

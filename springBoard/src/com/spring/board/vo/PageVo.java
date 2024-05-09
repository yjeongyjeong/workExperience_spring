package com.spring.board.vo;

public class PageVo {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;
	
	private int realEnd;
	
	public PageVo(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		if(cri.getPageNo() == 0) {
			cri.setPageNo(1);
		}
		
		this.endPage = (int)(Math.ceil(cri.getPageNo()/10.0))*10;
		this.startPage = this.endPage -9;
		
		this.realEnd = (int)(Math.ceil((total)*1.0/cri.getAmount()));
		
		if(realEnd < endPage) endPage = realEnd;
		
		//버튼 활성화 여부(기본 변수가 boolean)
		this.prev = this.startPage >1;
		this.next = this.endPage < realEnd;
	}

	
	
	
	@Override
	public String toString() {
		return "PageVo [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + ", realEnd=" + realEnd + "]";
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public int getRealEnd() {
		return realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}
	
	
	
}

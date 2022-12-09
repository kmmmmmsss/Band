package org.Band.model;

public class CriteriaVO {
	private int pageNum, amount; // 페이지 번호, 페이지 당 게시물 갯수
	private String keyword, type; // 키워드 통해 검색, 키워드 기준
	private int bno, bgno;
	
	public CriteriaVO() {
		this(1,10);
	}
	public CriteriaVO(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getBgno() {
		return bgno;
	}
	public void setBgno(int bgno) {
		this.bgno = bgno;
	}
	@Override
	public String toString() {
		return "CriteriaVO [pageNum=" + pageNum + ", amount=" + amount + ", keyword=" + keyword + ", type=" + type
				+ ", bno=" + bno + ", bgno=" + bgno + "]";
	}
	
}

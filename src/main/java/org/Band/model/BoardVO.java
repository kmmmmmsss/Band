package org.Band.model;

import java.util.Date;

public class BoardVO {
	private int bno, hit, bgnoinsert, likehit, cmthit;
	private String title, content, ID, NICK_NAME;
	private Date regdate, regupdate;
	
	public int getCmthit() {
		return cmthit;
	}
	public void setCmthit(int cmthit) {
		this.cmthit = cmthit;
	}
	public Date getRegupdate() {
		return regupdate;
	}
	public void setRegupdate(Date regupdate) {
		this.regupdate = regupdate;
	}
	public int getLikehit() {
		return likehit;
	}
	public void setLikehit(int likehit) {
		this.likehit = likehit;
	}
	public int getBgnoinsert() {
		return bgnoinsert;
	}
	public void setBgnoinsert(int bgnoinsert) {
		this.bgnoinsert = bgnoinsert;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getNICK_NAME() {
		return NICK_NAME;
	}
	public void setNICK_NAME(String nICK_NAME) {
		NICK_NAME = nICK_NAME;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", hit=" + hit + ", bgnoinsert=" + bgnoinsert + ", likehit=" + likehit
				+ ", cmthit=" + cmthit + ", title=" + title + ", content=" + content + ", ID=" + ID + ", NICK_NAME="
				+ NICK_NAME + ", regdate=" + regdate + ", regupdate=" + regupdate + "]";
	}
	
}

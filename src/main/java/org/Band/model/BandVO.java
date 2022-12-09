package org.Band.model;

import java.util.Date;

public class BandVO {
	int m_no, m_member_cnt, m_sort, m_gender;
	String m_title, m_content, m_loc, m_ID, m_member_ID, m_NICK_NAME;
	Date m_date;
	
	public int getM_sort() {
		return m_sort;
	}
	public void setM_sort(int m_sort) {
		this.m_sort = m_sort;
	}
	public int getM_gender() {
		return m_gender;
	}
	public void setM_gender(int m_gender) {
		this.m_gender = m_gender;
	}
	public String getM_NICK_NAME() {
		return m_NICK_NAME;
	}
	public void setM_NICK_NAME(String m_NICK_NAME) {
		this.m_NICK_NAME = m_NICK_NAME;
	}
	public Date getM_date() {
		return m_date;
	}
	public void setM_date(Date m_date) {
		this.m_date = m_date;
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public int getM_member_cnt() {
		return m_member_cnt;
	}
	public void setM_member_cnt(int m_member_cnt) {
		this.m_member_cnt = m_member_cnt;
	}
	public String getM_title() {
		return m_title;
	}
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getM_loc() {
		return m_loc;
	}
	public void setM_loc(String m_loc) {
		this.m_loc = m_loc;
	}
	public String getM_ID() {
		return m_ID;
	}
	public void setM_ID(String m_ID) {
		this.m_ID = m_ID;
	}
	public String getM_member_ID() {
		return m_member_ID;
	}
	public void setM_member_ID(String m_member_ID) {
		this.m_member_ID = m_member_ID;
	}
	@Override
	public String toString() {
		return "BandVO [m_no=" + m_no + ", m_member_cnt=" + m_member_cnt + ", m_sort=" + m_sort + ", m_gender="
				+ m_gender + ", m_title=" + m_title + ", m_content=" + m_content + ", m_loc=" + m_loc + ", m_ID=" + m_ID
				+ ", m_member_ID=" + m_member_ID + ", m_NICK_NAME=" + m_NICK_NAME + ", m_date=" + m_date + "]";
	}
	
}

package org.Band.model;

import java.util.Date;

public class LikeVO {
	private int LIKENO, BNO, LIKECHECK;
	private String ID;
	private Date LIKEDATE;
	public int getLIKENO() {
		return LIKENO;
	}
	public void setLIKENO(int lIKENO) {
		LIKENO = lIKENO;
	}
	public int getBNO() {
		return BNO;
	}
	public void setBNO(int bNO) {
		BNO = bNO;
	}
	public int getLIKECHECK() {
		return LIKECHECK;
	}
	public void setLIKECHECK(int lIKECHECK) {
		LIKECHECK = lIKECHECK;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public Date getLIKEDATE() {
		return LIKEDATE;
	}
	public void setLIKEDATE(Date lIKEDATE) {
		LIKEDATE = lIKEDATE;
	}
	@Override
	public String toString() {
		return "LikeVO [LIKENO=" + LIKENO + ", BNO=" + BNO + ", LIKECHECK=" + LIKECHECK + ", ID=" + ID + ", LIKEDATE="
				+ LIKEDATE + "]";
	}
	
	
}

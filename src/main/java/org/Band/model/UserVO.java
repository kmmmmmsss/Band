package org.Band.model;


public class UserVO {
	private String ID, PASSWORD, NAME, NICK_NAME, EMAIL, INTRO;
	
	public String getINTRO() {
		return INTRO;
	}

	public void setINTRO(String iNTRO) {
		INTRO = iNTRO;
	}
	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getNICK_NAME() {
		return NICK_NAME;
	}

	public void setNICK_NAME(String nICK_NAME) {
		NICK_NAME = nICK_NAME;
	}

	public String getEMAIL() {
		return EMAIL;
	}

	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	@Override
	public String toString() {
		return "UserVO [ID=" + ID + ", PASSWORD=" + PASSWORD + ", NAME=" + NAME + ", NICK_NAME=" + NICK_NAME
				+ ", EMAIL=" + EMAIL + ", INTRO=" + INTRO + "]";
	}
	
}

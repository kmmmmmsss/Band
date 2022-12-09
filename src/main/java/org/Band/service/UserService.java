package org.Band.service;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.Band.model.ProfileVO;
import org.Band.model.UserVO;

public interface UserService {
	public boolean loginCheck(UserVO user, HttpSession session);
	public void signup(UserVO user);
	public UserVO profile(UserVO user);
	public int idCheck(String ID);
	public int emCheck(String EMAIL);
	public void userUpdate(UserVO user);
	public UserVO findId(UserVO user);
	public UserVO findPw(UserVO user);
	public void pwUpdate(String PASSWORD, String EMAIL, String ID);
	public void userdraw(UserVO user);
	
	public List<ProfileVO> getInfo(String ID);
	public List<ProfileVO> likeInfo(String ID);
	public List<ProfileVO> bandInfo(String ID);
	public List<ProfileVO> bests(String ID);
}

package org.Band.service;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.Band.mapper.UserMapper;
import org.Band.model.ProfileVO;
import org.Band.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper usermapper;
	
	public boolean loginCheck(UserVO user, HttpSession session) {
		UserVO login=usermapper.loginCheck(user);
		boolean result=false;	
		// login가 null이 아니면
		if(login!=null) {
			session.setAttribute("login", login);
			session.setAttribute("loginId", login.getID());
			System.out.println("로그인 정보..."+session.getAttribute("login"));
			result=true;
		}
		return result;
	}
	public void signup(UserVO user) {
		usermapper.signup(user);
	}
	public UserVO profile(UserVO user) {
		return usermapper.profile(user);
	}
	public int idCheck(String ID) {
		return usermapper.idCheck(ID);
	}
	public int emCheck(String EMAIL) {
		return usermapper.emCheck(EMAIL);
	}
	public void userUpdate(UserVO user) {
		usermapper.userUpdate(user);
	}
	public UserVO findId(UserVO user) {
		return usermapper.findId(user);
	}
	public UserVO findPw(UserVO user) {
		return usermapper.findPw(user);
	}
	public void pwUpdate(String PASSWORD, String EMAIL, String ID) {
		usermapper.pwUpdate(PASSWORD, EMAIL, ID);
	}
	public void userdraw(UserVO user) {
		usermapper.userdraw(user);
	}
	
	public List<ProfileVO> getInfo(String ID) {
		return usermapper.getInfo(ID);
	}
	public List<ProfileVO> likeInfo(String ID){
		return usermapper.likeInfo(ID);
	}
	public List<ProfileVO> bandInfo(String ID){
		return usermapper.bandInfo(ID);
	}
	public List<ProfileVO> bests(String ID){
		return usermapper.bests(ID);
	}
}

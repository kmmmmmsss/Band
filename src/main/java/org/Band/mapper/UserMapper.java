package org.Band.mapper;



import java.util.List;

import org.Band.model.ProfileVO;
import org.Band.model.UserVO;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
	public UserVO loginCheck(UserVO user);
	public void signup(UserVO user);
	public UserVO profile(UserVO user);
	public int idCheck(String ID);
	public int emCheck(String EMAIL);
	public void userUpdate(UserVO user);
	public UserVO findId(UserVO user);
	public UserVO findPw(UserVO user);
	public void pwUpdate(@Param("PASSWORD")String PASSWORD, @Param("EMAIL")String EMAIL, @Param("ID")String ID);
	public void userdraw(UserVO user);
	
	public List<ProfileVO> getInfo(String ID);
	public List<ProfileVO> likeInfo(String ID);
	public List<ProfileVO> bandInfo(String ID);
	public List<ProfileVO> bests(String ID);
}

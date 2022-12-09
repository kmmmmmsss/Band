package org.Band.model;

public class ProfileVO {
	private UserVO user;
	private BoardVO board;
	private LikeVO like;
	private BandVO band;
	
	public BandVO getBand() {
		return band;
	}
	public void setBand(BandVO band) {
		this.band = band;
	}
	public LikeVO getLike() {
		return like;
	}
	public void setLike(LikeVO like) {
		this.like = like;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public BoardVO getBoard() {
		return board;
	}
	public void setBoard(BoardVO board) {
		this.board = board;
	}
	@Override
	public String toString() {
		return "ProfileVO [user=" + user + ", board=" + board + ", like=" + like + ", band=" + band + "]";
	}
}

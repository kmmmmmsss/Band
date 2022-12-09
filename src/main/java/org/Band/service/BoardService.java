package org.Band.service;

import java.util.List;

import org.Band.model.BoardVO;
import org.Band.model.CriteriaVO;

public interface BoardService {
	public List<BoardVO> ListPage(CriteriaVO cri);
	public int getTotal(CriteriaVO cri);
	public void write(BoardVO board);
	public BoardVO view(int bno);
	public int modify(BoardVO board);
	public int delete(int bno);
	public void boardhit(int bno);
	public void cmthit(int bno);
	
	public void updateLike(int bno);
	public void updateLikeCancel(int bno);
	public void insertLike(int bno, String ID);
	public void deleteLike(int bno, String ID);
	public int likeCheck(int bno, String ID);
	public void updateLikeCheck(int bno, String ID);
	public void updateLikeCheckCancel(int bno, String ID);
}

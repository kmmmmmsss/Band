package org.Band.service;

import java.util.List;

import org.Band.mapper.BoardMapper;
import org.Band.model.BoardVO;
import org.Band.model.CriteriaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardMapper bm;
	
	public List<BoardVO>ListPage(CriteriaVO cri){
		return bm.ListPage(cri);
	}
	public int getTotal(CriteriaVO cri) {
		return bm.getTotal(cri);
	}
	public void write(BoardVO board) {
		bm.write(board);
	}
	public BoardVO view(int bno) {
		return bm.view(bno);
	}
	public int modify(BoardVO board) {
		return bm.modify(board);
	}
	public int delete(int bno) {
		return bm.delete(bno);
	}
	public void boardhit(int bno) {
		bm.boardhit(bno);
	}
	public void cmthit(int bno) {
		bm.cmthit(bno);
	}
	
	
	
	public void updateLike(int bno) {
		bm.updateLike(bno);
	}
	public void updateLikeCancel(int bno) {
		bm.updateLikeCancel(bno);
	}
	public void insertLike(int bno, String ID) {
		bm.insertLike(bno, ID);
	}
	public void deleteLike(int bno, String ID) {
		bm.deleteLike(bno, ID);
	}
	public int likeCheck(int bno, String ID) {
		return bm.likeCheck(bno, ID);
	}
	public void updateLikeCheck(int bno, String ID) {
		bm.updateLikeCheck(bno, ID);
	}
	public void updateLikeCheckCancel(int bno, String ID) {
		bm.updateLikeCheckCancel(bno, ID);
	}
}

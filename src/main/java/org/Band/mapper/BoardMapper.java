package org.Band.mapper;

import java.util.List;

import org.Band.model.BoardVO;
import org.Band.model.CriteriaVO;
import org.apache.ibatis.annotations.Param;

public interface BoardMapper {
	public List<BoardVO> ListPage(CriteriaVO cri);
	public int getTotal(CriteriaVO cri);
	public void write(BoardVO board);
	public BoardVO view(int bno);
	public int modify(BoardVO board);
	public int delete(int bno);
	public void boardhit(int bno);
	public void cmthit(int bno);
	
	// 좋아요 
	public void updateLike(@Param("bno") int bno);
	public void updateLikeCancel(@Param("bno") int bno);
	public void insertLike(@Param("bno") int bno, @Param("ID") String ID);
	public void deleteLike(@Param("bno") int bno, @Param("ID") String ID);
	public int likeCheck(@Param("bno") int bno, @Param("ID") String ID);
	public void updateLikeCheck(@Param("bno") int bno, @Param("ID") String ID);
	public void updateLikeCheckCancel(@Param("bno") int bno, @Param("ID") String ID);
}

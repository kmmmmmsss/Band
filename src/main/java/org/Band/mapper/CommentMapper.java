package org.Band.mapper;

import java.util.List;

import org.Band.model.CommentVO;

public interface CommentMapper {
	public List<CommentVO> cmtList(int bno);
	public int cmtInsert(CommentVO cmt);
	public void cmtUpdate(CommentVO cmt);
	public void cmtDelete(int rno);
	public CommentVO cmtSelect(CommentVO cmt);
	
	public int minsert(CommentVO cmt);
	public List<CommentVO> mlist(int m_no);
	public CommentVO mSelect(CommentVO cmt);
}

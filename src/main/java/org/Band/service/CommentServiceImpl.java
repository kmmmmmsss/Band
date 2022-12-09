package org.Band.service;



import java.util.List;

import org.Band.mapper.CommentMapper;
import org.Band.model.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentServiceImpl implements CommentService{
	@Autowired
	CommentMapper cm;
	
	public List<CommentVO> cmtList(int bno){
		return cm.cmtList(bno);
	}
	public int cmtInsert(CommentVO cmt) {
		return cm.cmtInsert(cmt);
	}
	public void cmtUpdate(CommentVO cmt) {
		cm.cmtUpdate(cmt);
	}
	public void cmtDelete(int rno) {
		cm.cmtDelete(rno);
	}
	public CommentVO cmtSelect(CommentVO cmt) {
		return cm.cmtSelect(cmt);
	}
	public int minsert(CommentVO cmt) {
		return cm.minsert(cmt);
	}
	public List<CommentVO> mlist(int m_no){
		return cm.mlist(m_no);
	}
	public CommentVO mSelect(CommentVO cmt) {
		return cm.mSelect(cmt);
	}
}

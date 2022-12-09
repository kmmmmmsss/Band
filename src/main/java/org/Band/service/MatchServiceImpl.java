package org.Band.service;

import java.util.List;

import org.Band.mapper.MatchMapper;
import org.Band.model.BandVO;
import org.Band.model.CriteriaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatchServiceImpl implements MatchService {
	@Autowired
	MatchMapper mm;
	
	public void regist(BandVO band) {
		mm.regist(band);
	}
	public List<BandVO> matchList(CriteriaVO cri){
		return mm.matchList(cri);
	}
	public int mtotal(CriteriaVO cri) {
		return mm.mtotal(cri);
	}
	public BandVO mview(int m_no) {
		return mm.mview(m_no);
	}
	public int update(BandVO band) {
		return mm.update(band);
	}
	public int delee(int m_no) {
		return mm.delee(m_no);
	}
}

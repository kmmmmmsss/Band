package org.Band.service;

import java.util.List;

import org.Band.model.BandVO;
import org.Band.model.CriteriaVO;

public interface MatchService {
	public void regist(BandVO band);
	public List<BandVO> matchList(CriteriaVO cri);
	public int mtotal(CriteriaVO cri);
	public BandVO mview(int m_no);
	public int update(BandVO band);
	public int delee(int m_no);
}

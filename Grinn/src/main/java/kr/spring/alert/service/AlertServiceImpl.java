package kr.spring.alert.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.alert.dao.AlertMapper;
import kr.spring.alert.vo.AlertVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.trade.vo.TradeVO;

@Service
@Transactional
public class AlertServiceImpl implements AlertService{
	
	@Autowired
	private AlertMapper alertMapper;
	

	

	@Override
	public List<MemberVO> followId(Integer mem_num) {
		return alertMapper.followId(mem_num);
	}

	@Override
	public MemberVO followPhoto(Integer mem_num) {
		return alertMapper.followPhoto(mem_num);
	}




	@Override
	public List<AlertVO> commentInfo(Integer mem_num) {
		return alertMapper.commentInfo(mem_num);
	}


	@Override
	public List<AlertVO> favInfo(Integer mem_num) {
		return alertMapper.favInfo(mem_num);
	}


	@Override
	public List<AlertVO> purchaseInfo(Integer mem_num) {
		return alertMapper.purchaseInfo(mem_num);
	}


	@Override
	public List<AlertVO> saleInfo(Integer mem_num) {
		return alertMapper.saleInfo(mem_num);
	}

	@Override
	public MemberVO profilePhoto(Integer mem_num) {
		return alertMapper.profilePhoto(mem_num);
	}




}

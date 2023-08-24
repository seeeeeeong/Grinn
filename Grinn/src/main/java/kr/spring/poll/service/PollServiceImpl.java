package kr.spring.poll.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.vo.ItemVO;
import kr.spring.poll.dao.PollMapper;
import kr.spring.poll.vo.PollReplyVO;
import kr.spring.poll.vo.PollReportVO;
import kr.spring.poll.vo.PollSubVO;
import kr.spring.poll.vo.PollVO;
import kr.spring.poll.vo.VoterVO;

@Service
@Transactional
public class PollServiceImpl implements PollService{
	
	@Autowired
	PollMapper pollMapper;

	@Override
	public List<PollVO> selectPollList(Map<String, Object> map) {
		return pollMapper.selectPollList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return pollMapper.selectRowCount(map);
	}

	@Override
	public PollVO selectPoll(PollVO poll) {
		return pollMapper.selectPoll(poll);
	}

	@Override
	public void insertPoll(PollVO poll) {
		pollMapper.insertPoll(poll);
		
	}
	
	@Override
	public void updatePollByItem_num(PollVO poll) {
		pollMapper.updatePollByItem_num(poll);
		
	}
	
	@Override
	public void deletePollByItem_num(Integer item_num) {
		pollMapper.deletePollByItem_num(item_num);
	}

	@Override
	public void updateHit(Integer poll_num) {
		pollMapper.updateHit(poll_num);
		
	}

	@Override
	public void deletePoll(Integer poll_num) {
		pollMapper.deleteReplyByPollNum(poll_num);
		pollMapper.deletePoll(poll_num);
		
	}

	@Override
	public List<PollReplyVO> selectListReply(Map<String, Object> map) {
		return pollMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return pollMapper.selectRowCountReply(map);
	}

	@Override
	public PollReplyVO selectReply(Integer re_num) {
		return pollMapper.selectReply(re_num);
	}

	@Override
	public void insertReply(PollReplyVO pollReplyVO) {
		pollMapper.insertReply(pollReplyVO);
		
	}

	@Override
	public void updateReply(PollReplyVO pollReplyVO) {
		pollMapper.updateReply(pollReplyVO);
		
	}

	@Override
	public void deleteReply(Integer re_num) {
		pollMapper.deleteReply(re_num);
		
	}

	@Override
	public PollSubVO selectPoll_item(PollSubVO sub) {
		return pollMapper.selectPoll_item(sub);
	}

	@Override
	public int selectPoll_item_count(Integer poll_num) {
		return pollMapper.selectPoll_item_count(poll_num);
	}

	@Override
	public void insertPolling(PollSubVO sub) {
		pollMapper.insertPolling(sub);
		
	}

	@Override
	public void deletePolling(Integer pollsub_num) {
		pollMapper.deletePolling(pollsub_num);
		
	}

	
		
	

}

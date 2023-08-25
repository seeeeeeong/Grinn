package kr.spring.poll.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;
import kr.spring.poll.vo.PollReplyVO;
import kr.spring.poll.vo.PollReportVO;
import kr.spring.poll.vo.PollSubVO;
import kr.spring.poll.vo.PollVO;
import kr.spring.poll.vo.VoterVO;

public interface PollService {
	// 투표글 목록
	public List<PollVO> selectPollList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	// 투표글 상세
	public PollVO selectPoll(Integer poll_num);
	// 투표글 등록
	public void insertPoll(PollVO poll);
	// 투표항목 수정
	public void updatePollByItem_num(PollVO poll);
	// 투표항목 삭제
	public void deletePollByItem_num(Integer item_num);
	// 투표글 조회수
	public void updateHit(@Param(value="poll_num") Integer poll_num);
	// 투표글 삭제
	public void deletePoll(@Param(value="poll_num") Integer poll_num);
	
	public PollSubVO selectPoll_item(PollSubVO sub);
	public int selectPoll_item_count(Integer poll_num);
	public void insertPolling(PollSubVO sub);
	public void deletePolling(Integer pollsub_num);
	
	public List<PollSubVO> selectPollCount(Integer poll_num);
	
	//==================================================================
	//============== 투표글 댓글 ==========================================
	//==================================================================
	
	// 투표글 댓글
	public List<PollReplyVO> selectListReply(Map<String, Object> map);
	public int selectRowCountReply(Map<String, Object> map);
	// 투표글 댓글 상세
	public PollReplyVO selectReply(Integer re_num);
	// 투표글 댓글 등록
	public void insertReply(PollReplyVO pollReplyVO);
	// 투표글 댓글 수정
	public void updateReply(PollReplyVO pollReplyVO);
	// 투표글 댓글 삭제
	public void deleteReply(Integer re_num);
}

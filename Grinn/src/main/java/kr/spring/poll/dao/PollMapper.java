package kr.spring.poll.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.spring.item.vo.ItemVO;
import kr.spring.poll.vo.PollReplyVO;
import kr.spring.poll.vo.PollReportVO;
import kr.spring.poll.vo.PollSubVO;
import kr.spring.poll.vo.PollVO;
import kr.spring.poll.vo.VoterVO;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PollMapper {
	// 투표글 목록
	public List<PollVO> selectPollList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	// 투표글 상세
	public PollVO selectPoll(PollVO poll);
	// 투표글 등록
	public void insertPoll(PollVO poll);
	// 투표항목 추가
	public void updatePollByItem_num(PollVO poll);
	// 투표항목 삭제
	public void deletePollByItem_num(Integer item_num);
	// 투표글 조회수
	@Update("UPDATE poll SET poll_hit=poll_hit+1 WHERE poll_num=#{poll_num}")
	public void updateHit(@Param(value="poll_num") Integer poll_num);
	// 투표글 삭제
	@Delete("DELETE FROM poll WHERE poll_num=#{poll_num}")
	public void deletePoll(@Param(value="poll_num") Integer poll_num);
	
	@Select("SELECT * FROM pollsub WHERE poll_num=#{poll_num} AND mem_num=#{mem_num}")
	public PollSubVO selectPoll_item(PollSubVO sub);
	@Select("SELECT COUNT(*) FROM pollsub WHERE poll_num=#{poll_num} AND item_num=#{item_num}")
	public int selectPoll_item_count(Integer poll_num);
	@Insert("INSERT INTO pollsub (pollsub_num,poll_num,mem_num,item_num) VALUES (pollsub_seq.nextval,#{poll_num},#{mem_num},#{item_num})")
	public void insertPolling(PollSubVO sub);
	@Delete("DELETE FROM pollsub WHERE poll_num=#{poll_num}")
	public void deletePolling(Integer pollsub_num);
	
	//==================================================================
	//============== 투표글 댓글 ==========================================
	//==================================================================
	
	// 투표글 댓글
	public List<PollReplyVO> selectListReply(Map<String, Object> map);
	@Select("SELECT COUNT(*) FROM poll_reply WHERE poll_num=#{poll_num}")
	public int selectRowCountReply(Map<String, Object> map);
	// 투표글 댓글 상세
	@Select("SELECT * FROM poll_reply WHERE re_num=#{re_num}")
	public PollReplyVO selectReply(Integer re_num);
	// 투표글 댓글 등록
	public void insertReply(PollReplyVO pollReplyVO);
	// 투표글 댓글 수정
	@Update("UPDATE poll_reply SET re_content=#{re_content}, re_ip=#{re_ip}")
	public void updateReply(PollReplyVO pollReplyVO);
	// 투표글 댓글 삭제
	@Delete("DELETE FROM poll_reply WHERE re_num=#{re_num}")
	public void deleteReply(Integer re_num);
	// 투표글 삭제시 댓글이 존재하면 투표글 삭제전 댓글 삭제
	@Delete("DELETE FROM poll_reply WHERE poll_num=#{poll_num}")
	public void deleteReplyByPollNum(Integer poll_num);
}















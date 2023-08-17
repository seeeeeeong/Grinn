package kr.spring.userStyle.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;

@Mapper
public interface UserStyleMapper {
	// 회원의 아이디, 닉네임, 프로필 이름, 한 줄 소개글 가져오기
	@Select("SELECT m.mem_num, m.mem_id, md.mem_photo, m.mem_nickname, md.mem_int "
			+ "FROM member m INNER JOIN member_detail md ON m.mem_num = md.mem_num " + "WHERE m.mem_num = #{mem_num}")
	public MemberVO selectMember(Integer mem_num);

	// 사용자가 작성한 스타일게시물 총 개수 가져오기
	@Select("SELECT COUNT(*) AS total FROM style " + "WHERE mem_num = #{mem_num}")
	public int selectUserStyleCount(Integer mem_num);

	// 사용자가 작성한 스타일게시물 사진, 내용 가져오기
	@Select("SELECT s.mem_num, s.st_num, s.st_photo1, s.st_phrase FROM member_detail m JOIN style s ON m.mem_num = s.mem_num WHERE m.mem_num = #{mem_num}")
	public List<StyleVO> selectStyle(Integer mem_num);

	// st_num에 해당하는 style 테이블의 정보 가져오기
	@Select("SELECT * FROM style WHERE st_num = #{st_num}")
	public StyleVO selectUserStyle(Integer st_num);

	// 스타일 테이블의 mem_num에 해당하는 member_detail 테이블의 정보 가져오기
	@Select("SELECT * FROM member m JOIN member_detail md ON m.mem_num = md.mem_num JOIN style s ON s.mem_num = md.mem_num WHERE s.st_num = #{st_num}")
	public MemberVO selectStyleProfile(Integer st_num);

	// 좋아요
	@Select("SELECT * FROM style_fav WHERE st_num=#{st_num} AND mem_num=#{mem_num}")
	public StyleFavVO selectFav(StyleFavVO fav);

	@Select("SELECT COUNT(*) FROM style_fav WHERE mem_num=#{mem_num}")
	public int selectFavCount(Integer mem_num);

	@Insert("INSERT INTO style_fav (stfav_num,mem_num,st_num) VALUES (style_fav_seq.nextval,#{mem_num},#{st_num})")
	public void insertFav(StyleFavVO fav);

	@Delete("DELETE FROM style_fav WHERE stfav_num=#{stfav_num}")
	public void deleteFav(Integer stfav_num);

	@Delete("DELETE FROM style_fav WHERE st_num=#{st_num}")
	public void deleteFavByStNum(Integer st_num);

	// 팔로우
	@Insert("INSERT INTO follow (follow_id, to_user, from_user) VALUES (follow_seq.nextval, #{to_user}, #{from_user})")
	public void insertFollow(Integer to_user, Integer from_user);

	// 팔로우 취소
	@Delete("DELETE FROM follow WHERE to_user = #{to_user} AND from_user = #{from_user}")
	public void deleteFollow(Integer to_user, Integer from_user);

	// 팔로잉 여부 확인
	@Select("SELECT COUNT(*) FROM follow WHERE to_user = #{to_user} AND from_user = #{from_user}")
	public int isFollowing(Integer to_user, Integer from_user);

	// 팔로워 mem_num, mem_id
	@Select("SELECT m.mem_num, m.mem_id FROM member m JOIN follow f ON m.mem_num = f.from_user WHERE f.to_user = #{mem_num}")
	public List<MemberVO> followerInfo(Integer mem_num);

	// 팔로잉 mem_num, mem_id
	@Select("SELECT m.mem_num, m.mem_id FROM member m JOIN follow f ON m.mem_num = f.to_user WHERE f.from_user = #{mem_num}")
	public List<MemberVO> followingInfo(Integer mem_num);

	// 팔로워, 팔로잉 프로필 사진
	@Select("SELECT mem_photo, mem_photo_name FROM member_detail WHERE mem_num = #{mem_num}")
	public MemberVO selectFollowerProfile(Integer mem_num);

	// 팔로잉 목록 조회
	@Select("SELECT m.mem_id, md.mem_photo, md.mem_photo_name, md.mem_nickname FROM follow f JOIN member m ON f.to_user = m.mem_num JOIN member_detail md ON f.to_user = md.mem_num WHERE f.from_user = #{mem_num}")
	public MemberVO selectFollowing(Integer mem_num);

	// 팔로워 수 조회
	@Select("SELECT COUNT(*) FROM follow WHERE to_user = #{to_user}")
	public int getFollowerCount(Integer to_user);

	// 팔로잉 수 조회
	@Select("SELECT COUNT(*) FROM follow WHERE from_user = #{to_user}")
	public int getFollowingCount(Integer to_user);
}

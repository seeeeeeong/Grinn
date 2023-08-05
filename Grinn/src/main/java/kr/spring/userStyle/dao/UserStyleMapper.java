package kr.spring.userStyle.dao;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.vo.StyleVO;

@Mapper
public interface UserStyleMapper {
    //회원의 아이디, 프로필 사진, 닉네임, 프로필 이름, 한 줄 소개글 가져오기
    @Select("SELECT m.mem_id, md.mem_photo, m.mem_nickname, md.mem_int " +
            "FROM member m INNER JOIN member_detail md ON m.mem_num = md.mem_num " +
            "WHERE m.mem_num = #{mem_num}")
    public MemberVO selectMember(Integer mem_num);

    //사용자가 작성한 스타일게시물 총 개수 가져오기
    @Select("SELECT COUNT(*) AS total FROM style " +
            "WHERE mem_num = #{mem_num}")
    public int selectUserStyleCount(Integer mem_num);
    
    //사용자가 작성한 스타일게시물 사진, 내용 가져오기
    @Select("SELECT s.st_num, s.st_photo1, s.st_phrase FROM member_detail m JOIN style s ON m.mem_num = s.mem_num WHERE m.mem_num = #{mem_num}")
    public List<StyleVO> selectStyle(Integer mem_num);
    
    //st_num에 해당하는 style 테이블의 정보 가져오기
    @Select("SELECT * FROM style WHERE st_num = #{st_num}")
    public StyleVO selectUserStyle(Integer st_num);

    //팔로우 
    @Insert("INSERT INTO follow (to_user, from_user) VALUES (#{to_user}, #{from_user})")
    public void insertFollow(@Param("to_user") Integer toUser, @Param("from_user") Integer fromUser);

    //팔로우 취소
    @Delete("DELETE FROM follow WHERE to_user = #{to_user} AND from_user = #{from_user}")
    public void deleteFollow(@Param("to_user") Integer toUser, @Param("from_user") Integer fromUser);

    //팔로잉 여부 확인
    @Select("SELECT COUNT(*) FROM follow WHERE to_user = #{to_user} AND from_user = #{from_user}")
    public int checkFollow(@Param("to_user") Integer toUser, @Param("from_user") Integer fromUser);

    //팔로워 목록 조회
    @Select("SELECT from_user FROM follow WHERE to_user = #{to_user}")
    public List<Integer> getFollowers(@Param("to_user") Integer toUser);
    
    //팔로잉 목록 조회
    @Select("SELECT to_user FROM follow WHERE from_user = #{from_user}")
    public List<Integer> getFollowings(@Param("from_user") Integer fromUser);
    
    //팔로워 수 조회
    @Select("SELECT COUNT(*) FROM follow WHERE to_user = #{to_user}")
    public int getFollowerCount(@Param("to_user") Integer toUser);

    //팔로잉 수 조회
    @Select("SELECT COUNT(*) FROM follow WHERE from_user = #{from_user}")
    public int getFollowingCount(@Param("from_user") Integer fromUser);
}

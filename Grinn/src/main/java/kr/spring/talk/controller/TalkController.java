package kr.spring.talk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.talk.service.TalkService;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TalkController {
	@Autowired
	private TalkService talkService;
	@Autowired
	private MemberService memberService;

	/* ====================== 채팅방 생성 ====================== */
	//폼 호출
	@GetMapping("/talk/talkRoomWrite.do")
	public String talkRoomWrite() {
		return "talkRoomWrite";
	}
	//전송된 데이터 처리
	@PostMapping("/talk/talkRoomWrite.do")
	public String talkRoomSubmit(TalkRoomVO vo, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//채팅 멤버 초대 문구 설정 시작
		vo.setTalkVO(new TalkVO());
		vo.getTalkVO().setMem_num(user.getMem_num());
		vo.getTalkVO().setMessage(user.getMem_id() + "님이 "
									+ findMemberId(vo, user) + "님을 초대했습니다.");
		//채팅 멤버 초대 문구 설정 끝
		
		talkService.insertTalkRoom(vo);
		
		return "redirect:/talk/talkList.do";
	}
	//초대한 회원의 id 구하기
	private String findMemberId(TalkRoomVO vo, MemberVO user) {
		String member_id = "";
		int[] members = vo.getMembers();
		for(int i=0; i<members.length; i++) {
			String temp_id = memberService.selectMember(members[i]).getMem_id();
			//초대한 회원의 아이디는 제외
			if(!user.getMem_id().equals(temp_id)) {
				member_id += temp_id;
				if(i < members.length-1) member_id += ", ";
			}
		}
		return member_id;
	}
	
	/* ====================== 채팅 회원 검색 ====================== */
	
	/* ====================== 채팅방 목록 ====================== */
	@RequestMapping("/talk/talkList.do")
	public String chatList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
										String keyword, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		int count = talkService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(null,keyword,currentPage,count,30,10,"talkList.do");
		
		List<TalkRoomVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = talkService.selectTalkRoomList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "talkList";
	}
	
	/* ====================== 채팅 메시지 처리 ====================== */
	
	/* ====================== 채팅방 이름 변경 ====================== */
	
	/* ====================== 채팅 멤버 추가 ====================== */
	
	/* ====================== 채팅방 나가기 ====================== */
}



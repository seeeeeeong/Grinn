package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAdminController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/admin_list.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "admin_list.do");
		
		List<MemberVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_memberList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	@GetMapping("/member/admin_update.do")
	public String form(@RequestParam int mem_num, Model model) {
		
		MemberVO memberVO = memberService.selectMember(mem_num);
		
		model.addAttribute("memberVO", memberVO);
		
		return "admin_memberModify";
	}
	
	@PostMapping("/member/admin_update.do")
	public String submit(MemberVO memberVO, Model model, HttpServletRequest request) {
		
		log.debug("<<관리자 회원권한 수정>> : " + memberVO);
		
		memberService.updateByAdmin(memberVO);
		
		model.addAttribute("message", "회원권한 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/member/admin_update.do?mem_num=" + memberVO.getMem_num());
		
		return "common/resultView";
	}
	
}




























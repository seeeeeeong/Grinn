package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	// 아이디 중복 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String, String> confirmId(@RequestParam String mem_id) {
		log.debug("<<아이디 중복 체크>> : " + mem_id);
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckMember(mem_id);
		if(member != null) {
			mapAjax.put("result", "idDuplicated");
		} else {
			if(!Pattern.matches("^[A-Za-z0-9]{4,12}$", mem_id)) {
				mapAjax.put("result", "notMatchPattern");
			} else {
				mapAjax.put("result", "idNotFound");
			}
		}
		
		return mapAjax;
	}
	
	// 회원가입
	@GetMapping("/member/registerUser.do")
	public String form() {
		return "memberRegister";
	}
	
	// 회원가입 처리
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model) {
		log.debug("<<회원가입>> : " + memberVO);
		
		if(result.hasErrors()) {
			return form();
		}
		
		memberService.insertMember(memberVO);
		model.addAttribute("accessMsg", "회원가입 완료");
		return "common/notice";
	}
	
}




















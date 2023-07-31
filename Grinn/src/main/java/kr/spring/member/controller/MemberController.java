package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
import kr.spring.util.AuthCheckException;
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
	
	// 로그인
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "memberLogin";
	}
	
	// 로그인 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session,
			                  Model model, HttpServletResponse response) {
		log.debug("<<회원로그인>> : " + memberVO);
		
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_passwd")) {
			return formLogin();
		}
		
		// 아이디, 비밀번호 일치 여부 체크
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());
			boolean check = false;
			
			if(member != null) { 
				check = member.isCheckedPassword(memberVO.getMem_passwd());
			}
			if(check) {
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");
				if(autoLogin) {
					String au_id = member.getAu_id();
					if(au_id == null) {
						au_id = UUID.randomUUID().toString();
						log.debug("<<au_id>> : " + au_id);
						memberService.updateAu_id(au_id, member.getMem_num());
					}
					
					Cookie auto_cookie = new Cookie("au-log",au_id);
					auto_cookie.setMaxAge(60*60*24*7);//쿠키 유효시간 1주일
					auto_cookie.setPath("/");
					
					response.addCookie(auto_cookie);
				}
				
				// 인증 성공, 로그인 처리
				session.setAttribute("user", member);
				
				log.debug("<<인증 성공>>");
				log.debug("<<mem_id>> : " + member.getMem_id());
				log.debug("<<mem_auth>> : " + member.getMem_auth());
				log.debug("<<au_id>> : " + member.getAu_id());
				
				if(member.getMem_auth() == 9) {
					return "redirect:/main/admin.do";
				}else {
					return "redirect:/main/main.do";
				}
			}
			
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			if(member != null && member.getMem_auth() == 1) {
				result.reject("noAuthority");
			}else {
				result.reject("invalidIdOrPassword");
			}
			
			log.debug("<<인증 실패>>");
			
			return formLogin();
		}
	}
	
	// 로그아웃
	@RequestMapping("/member/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();
		
		Cookie auto_cookie = new Cookie("au-log","");
		auto_cookie.setMaxAge(0);
		auto_cookie.setPath("/");
		
		response.addCookie(auto_cookie);
		
		return "redirect:/main/main.do";
	}
	
}




















package kr.spring.poll.controller;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.poll.service.PollService;
import kr.spring.poll.vo.PollReplyVO;
import kr.spring.poll.vo.PollSubVO;
import kr.spring.poll.vo.PollVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PollController {
	@Autowired
	PollService pollService;
	@Autowired
	MemberService memberService;
	@Autowired
	ItemService itemService;
	
	/* 자바빈 초기화 */
	@ModelAttribute
	public PollVO initCommand() {
		return new PollVO();
	}
	
	/* 투표글 목록 */
	@RequestMapping("/poll/pollList.do")
	public ModelAndView getPollList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
			@RequestParam(value="order", defaultValue="1") int order) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		int count = pollService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 10, "pollList.do", "&order="+order);
		
		List<PollVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = pollService.selectPollList(map);
			log.debug("<리스트>:"+list);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pollList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/* 투표글 상세 */
	@RequestMapping("/poll/pollView.do")
	public ModelAndView getPollView(@RequestParam int poll_num) {
		
		log.debug("<<투표글 상세>> : " + poll_num);
		pollService.updateHit(poll_num);
		
		
		
		PollVO poll = pollService.selectPoll(poll_num);
		
		return new ModelAndView("pollView", "poll", poll);
	}
	
	
	
	
	
	
	
	/* 관리자 - 투표 목록 */
	@RequestMapping("/poll/admin_pollList.do")
	public ModelAndView getAdminPollList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
			@RequestParam(value="order", defaultValue="1") int order) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		int count = pollService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 10, "pollList.do", "&order="+order);
		
		List<PollVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = pollService.selectPollList(map);
			log.debug("<리스트>:"+list);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pollList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	// ====================================================
	// ===================== 투표글 등록 =====================
	// ====================================================
	
	// 등록폼
	@GetMapping("/poll/pollWrite.do")
	public String form() {
		return "pollWrite";
	}
	// 전송된 데이터 처리
	@PostMapping("/poll/pollWrite.do")
	public String submit(@Valid PollVO pollVO, BindingResult result, HttpServletRequest request, 
						HttpSession session, Model model) {
		
		log.debug("<< 투표글 등록 >> : " + pollVO);
		
		if(result.hasErrors()) {
			return form();
		}
		
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		pollVO.setPoll_date(sf.format(now));
		
		String[] poll_items = pollVO.getPoll_items().split(",");
		for(int i=0; i<poll_items.length; i++) {
			if(i==0) pollVO.setPoll_item1(Integer.parseInt(poll_items[i]));
			if(i==1) pollVO.setPoll_item2(Integer.parseInt(poll_items[i]));
			if(i==2) pollVO.setPoll_item3(Integer.parseInt(poll_items[i]));
			if(i==3) pollVO.setPoll_item4(Integer.parseInt(poll_items[i]));
		}
		
		pollVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		pollVO.setPoll_ip(request.getRemoteAddr());
		
		pollService.insertPoll(pollVO);
		model.addAttribute("message", "투표글이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/poll/pollList.do");
		
		return "common/resultView";
	}
	
	
	
	// ====================================================
	// ===================== 투표글 삭제 =====================
	// ====================================================
	
	/* 투표항목 삭제 */
	@RequestMapping("/poll/deletePoll.do")
	@ResponseBody
	public Map<String, String> delete(@RequestParam int poll_num) {
		
		Map<String, String> mapJson = new HashMap<String, String>();
		pollService.deletePoll(poll_num);
		mapJson.put("result", "success");
		
		return mapJson;
	}
	
	
	
	// ====================================================
	// ===================== 투표항목 검색 ===================
	// ====================================================
	@RequestMapping("/poll/itemSearchAjax.do")
	@ResponseBody
	public Map<String, Object> itemSearchAjax(@RequestParam String item_name, HttpSession session){
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		List<ItemVO> item = itemService.selectSearchItem(item_name);
		mapJson.put("result", "success");
		mapJson.put("item", item);
		
		return mapJson;
	}
	
	// ====================================================
	// ===================== 프로필 사진 =====================
	// ====================================================
	
	public void viewProfile(PollVO pollVO, HttpServletRequest request, Model model) {
		if(pollVO == null || pollVO.getMem_photo() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", pollVO.getMem_photo());
			model.addAttribute("filename", pollVO.getMem_photo_name());
		}
	}
	
	@RequestMapping("/poll/viewProfileByMem_num.do")
	public String getProfileByMem_num(HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO = null;
		if(user != null) {
			memberVO = memberService.selectMember(user.getMem_num());
		}
		
		viewProfileByMem_num(memberVO, request, model);
		
		return "imageView";
	}
	
	public void viewProfileByMem_num(MemberVO memberVO, HttpServletRequest request, Model model) {
		if(memberVO == null || memberVO.getMem_photo() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", memberVO.getMem_photo());
			model.addAttribute("filename", memberVO.getMem_photo_name());
		}
	}
	
	
	// 전체 투표수
	@RequestMapping("/poll/getPolling.do")
	@ResponseBody
	public Map<String,Object> getPolling(PollSubVO sub, HttpSession session){
		log.debug("<<투표글 투표수 - PollSubVO>> : " + sub);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않은 상태
			mapJson.put("status", "noPoll");
		}else {
			//로그인된 회원번호 셋팅
			sub.setMem_num(user.getMem_num());
			
			PollSubVO pollPolling = pollService.selectPoll_item(sub);
			if(pollPolling!=null) {
				mapJson.put("status", "yesPoll");
			}else {
				mapJson.put("status","noPoll");
			}
		}
		mapJson.put("count", pollService.selectPoll_item_count(sub.getPoll_num()));
		return mapJson;
	}
	
	@RequestMapping("/poll/writePolling.do")
	public String writePolling(PollSubVO sub,HttpSession session,Model model){
		log.debug("<<투표글 투표/삭제 - PollSubVO>> : " + sub);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			model.addAttribute("message", "로그인 필수");
			model.addAttribute("url", "../member/login.do");
		}else {
			//로그인된 회원번호 셋팅
			sub.setMem_num(user.getMem_num());
			pollService.insertPolling(sub);
			
			//PollSubVO pollPolling = pollService.selectPoll_item(sub);
			//if(pollPolling!=null) {
				//pollService.deletePolling(pollPolling.getPoll_num());
				
				//mapJson.put("result", "success");
				//mapJson.put("status", "noPoll");
			//}else {
				
				
			model.addAttribute("message", "투표 성공");
			//	mapJson.put("status", "yesPoll");
			//}
			model.addAttribute("url", "../poll/pollList.do");	
			
			//mapJson.put("count", pollService.selectPoll_item_count(
			//		sub.getPoll_num()));
		}
		return "common/resultView";
	}
	
	@RequestMapping("poll/getPollingCount.do")
	@ResponseBody
	public Map<String, Object> getPollingCount(@RequestParam int poll_num) {
		log.debug("<<투표수조회 진입>>");
		List<PollSubVO> list = pollService.selectPollCount(poll_num);
		Map<String,Object> mapJson = new HashMap<>();
		
		mapJson.put("result","success");
		mapJson.put("list", list);
		return mapJson;
	}
	
	
	// ====================================================
	// =============== 투표 항목 (상품 사진) ===================
	// ====================================================
	
	
	public void viewPhotoByItem_num(ItemVO itemVO, HttpServletRequest request, Model model) {
		
		model.addAttribute("imageFile", itemVO.getItem_photo1());
		model.addAttribute("filename", itemVO.getItem_photo1name());
	}
	
	@RequestMapping("/poll/viewPhotoByItem_num.do")
	public String getPhotoByItem_num(@RequestParam(required = false) int item_num, HttpServletRequest request, Model model) {
		ItemVO itemVO = itemService.selectItem(item_num);

		viewPhotoByItem_num(itemVO, request, model);

		return "imageView";
	}
	
	
	/* =====================================================
	 * =================== 투표글 댓글 ========================
	 * =====================================================/
	
	
	/* 투표글에 댓글 등록 */
	@RequestMapping("/poll/writeReply.do")
	@ResponseBody
	public Map<String,String> writeReply(PollReplyVO pollReplyVO,
			      HttpSession session, HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + pollReplyVO);

		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) { // 로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		} else {
			// 회원번호 등록
			pollReplyVO.setMem_num(user.getMem_num());
			// ip 등록
			pollReplyVO.setRe_ip(request.getRemoteAddr());
			// 댓글 등록
			pollService.insertReply(pollReplyVO);
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/* 투표글 댓글 목록 */
	@RequestMapping("/poll/listReply.do")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			@RequestParam(value="rowCount", defaultValue="10") int rowCount,
			@RequestParam int poll_num, HttpSession session){
		
		log.debug("<<currentPage>> : " + currentPage);
		log.debug("<<poll_num>> : " + poll_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("poll_num", poll_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 전체 댓글수
		int count = pollService.selectRowCountReply(map);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 1, null);
		
		List<PollReplyVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = pollService.selectListReply(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		mapJson.put("count",count);
		mapJson.put("list", list);
		
		// 로그인한 회원 정보 셋팅
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/* 투표글 댓글 수정 */
	@RequestMapping("/poll/updateReply.do")
	@ResponseBody
	public Map<String, String> modifyReply(PollReplyVO pollReplyVO,
			HttpSession session, HttpServletRequest request){
		
		log.debug("<<PollReplyVO>> : " + pollReplyVO);
		
		Map<String, String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		PollReplyVO db_reply = pollService.selectReply(pollReplyVO.getRe_num());
		
		if(user == null) { // 로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		} else if(user != null && user.getMem_num() == db_reply.getMem_num()) { // 로그인 회원번호와 작성자 회원번호가 일치
			// ip 등록
			pollReplyVO.setRe_ip(request.getRemoteAddr());
			
			// 댓글 수정
			pollService.updateReply(pollReplyVO);
			
			mapJson.put("result", "success");
		} else {
			// 로그인 회원번호와 작성자 회원번호가 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	
	/* 투표글 댓글 삭제 */
	@RequestMapping("/poll/deleteReply.do")
	@ResponseBody
	public Map<String, String> deleteReply(@RequestParam int re_num, HttpSession session){
		
		log.debug("<<re_num>> : " + re_num);
		
		Map<String, String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		PollReplyVO db_reply = pollService.selectReply(re_num);
		
		if(user == null) {
			// 로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		} else if(user != null && user.getMem_num() == db_reply.getMem_num()) {
			// 로그인한 회원번호와 작성자 회원번호 일치
			pollService.deleteReply(re_num);
			
			mapJson.put("result", "success");
		} else {
			// 로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
}





















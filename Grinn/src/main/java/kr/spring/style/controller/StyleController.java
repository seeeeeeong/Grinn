package kr.spring.style.controller;

import java.util.Collections;
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

import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.style.service.StyleService;
import kr.spring.style.vo.StyleCommentVO;
import kr.spring.style.vo.StyleFavVO;
import kr.spring.style.vo.StyleVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StyleController {
	@Autowired
	private StyleService styleService;
	
	/*========================
	 * 자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public StyleVO initCommand() {
		return new StyleVO();
	}
	
	/*========================
	 * 스타일 작성
	 *========================*/
	//등록폼
	@GetMapping("/style/write.do")
	public String form() {
		return "styleWrite";
	}
	
	//상품 검색
	@RequestMapping("/style/itemSearchAjax.do")
	@ResponseBody
	public Map<String,Object> itemSearchAjax(@RequestParam String item_name){
		Map<String,Object> mapJson = new HashMap<String,Object>();
	
		List<ItemVO> item_tag = styleService.selectSearchItem(item_name);
		mapJson.put("result", "success");
		mapJson.put("item_tag", item_tag);
		
		return mapJson;
	}
	
	//전송된 데이터 처리
	@PostMapping("/style/write.do")
	public String submit(@Valid StyleVO styleVO,
            			 BindingResult result,
            			 HttpServletRequest request,
            			 HttpSession session,
            			 Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
	
		log.debug("<<STYLE 작성>> : " + styleVO);
		
		//유효성 체크 결과 오류가 있으며 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//로그인 작업 완료 후 세션에서 회원번호 호출하여 셋팅하는 것으로 변경
		styleVO.setMem_num(user.getMem_num());
		styleService.insertStyle(styleVO);
		
		model.addAttribute("message", "스타일 업로드 완료!");
		model.addAttribute("url", request.getContextPath()+"/style/list.do");
		
		return "common/resultView";
	}
	
	/*========================
	 * 스타일 목록
	 *========================*/
	@RequestMapping("/style/list.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = styleService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"list.do","&order="+order);
		
		List<StyleVO> list = null;
		if(count > 0) {
			map.put("order",order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = styleService.selectList(map);			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("styleList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*========================
	 * 스타일 상세
	 *========================*/
	@RequestMapping("/style/detail.do")
	public ModelAndView getDetail(@RequestParam int st_num) {
		log.debug("<<스타일 상세 - st_num>> : " + st_num);
		
		//글상세 
		StyleVO style = styleService.selectStyle(st_num);
		
		style.setSt_phrase(StringUtil.useBrNoHtml(style.getSt_phrase()));
		
		return new ModelAndView("styleDetail","style", style);
	}
	
	/*========================
	 * 스타일 좋아요
	 *========================*/
	//좋아요 읽기
	@RequestMapping("/style/getFav.do")
	@ResponseBody
	public Map<String,Object> getFav(StyleFavVO fav, HttpSession session){
		log.debug("<<스타일 좋아요 읽기 - StyleFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않은 상태
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			StyleFavVO styleFav = styleService.selectFav(fav);
			if(styleFav!=null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status","noFav");
			}
		}
		mapJson.put("count", styleService.selectFavCount(
				                   fav.getSt_num()));
		return mapJson;
	}
	//좋아요 등록/삭제
	@RequestMapping("/style/writeFav.do")
	@ResponseBody
	public Map<String,Object> writeFav(StyleFavVO fav,HttpSession session){
		log.debug("<<스타일 좋아요 등록/삭제 - StyleFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			StyleFavVO styleFav = styleService.selectFav(fav);
			if(styleFav!=null) {//등록한 좋아요가 있으면 삭제
				styleService.deleteFav(styleFav.getStfav_num());
				
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			}else {//등록한 좋아요가 없으면 등록
				styleService.insertFav(fav);
				
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", styleService.selectFavCount(
					                          fav.getSt_num()));
		}
		return mapJson;
	}
	
	/*========================
	 * 댓글 등록
	 *========================*/
	@RequestMapping("/style/writeComment.do")
	@ResponseBody
	public Map<String,String> writeComment(StyleCommentVO styleCommentVO,
			                    HttpSession session,
			                    HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + styleCommentVO);

		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else {
			//회원번호 등록
			styleCommentVO.setMem_num(user.getMem_num());
			//댓글 등록
			styleService.insertComment(styleCommentVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*========================
	 * 댓글 목록
	 *========================*/
	@RequestMapping("/style/listComment.do")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
										@RequestParam(value="rowCount", defaultValue="10") int rowCount,
										@RequestParam int st_num, HttpSession session){
		log.debug("<<currentPage>> : " + currentPage);
		log.debug("<<st_num>> :" + st_num);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("st_num", st_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//전체 레코드수
		int count = styleService.selectRowCountComment(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 1, null);
		
		List<StyleCommentVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			log.debug("<<start>> :" + page.getStartRow() + ", " + page.getEndRow());
			list = styleService.selectListComment(map);
	
		}else {
			list = Collections.emptyList();
		}
		
		Map<String, Object> mapJson = new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		
		//로그인한 회원 정보 세팅
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/*========================
	 * 댓글 삭제
	 *========================*/
	@RequestMapping("/style/deleteComment.do")
	@ResponseBody
	public Map<String,String> deleteComment(@RequestParam int com_num, HttpSession session){
		log.debug("<<com_num>> : " + com_num);
		
		Map<String, String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		StyleCommentVO db_comment = styleService.selectComment(com_num);
		
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null && user.getMem_num()==db_comment.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			styleService.deleteComment(com_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 댓글작성자 회원번호 불일치한 경우
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	/*========================
	 * 댓글 수정
	 *========================*/
	@RequestMapping("/style/updateComment.do")
	@ResponseBody
	public Map<String,String> modifyComment(StyleCommentVO styleCommentVO, HttpSession session, HttpServletRequest request){
		log.debug("<<styleCommentVO>> : " + styleCommentVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		StyleCommentVO db_comment = styleService.selectComment(styleCommentVO.getCom_num());
		
		if(user == null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_comment.getMem_num()) {
			//로그인 회원과 작성자 회원의 번호 일치
			//댓글 수정
			styleService.updateComment(styleCommentVO);
			mapJson.put("result", "success");
		}else {
			//로그인 회원과 작성자 회원의 번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
}

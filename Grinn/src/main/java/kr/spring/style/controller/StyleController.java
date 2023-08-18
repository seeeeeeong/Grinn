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

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
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
	
	@Autowired
	private MemberService memberService;
	
	@Autowired 
	private ItemService itemService;
	
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
	 * 스타일 사진 출력
	 *========================*/	
	//게시물 사진 출력(스타일번호 지정)
	@RequestMapping("/style/viewPhoto1.do")
	public String getPhoto1BySt_num(@RequestParam(required = false) int st_num, HttpServletRequest request, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);

		viewPhoto1(styleVO, request, model);

		return "imageView";
	}
	@RequestMapping("/style/viewPhoto2.do")
	public String getPhoto2BySt_num(@RequestParam(required = false) int st_num, HttpServletRequest request, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);

		viewPhoto2(styleVO, request, model);

		return "imageView";
	}
	@RequestMapping("/style/viewPhoto3.do")
	public String getPhoto3BySt_num(@RequestParam(required = false) int st_num, HttpServletRequest request, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);

		viewPhoto3(styleVO, request, model);

		return "imageView";
	}
	@RequestMapping("/style/viewPhoto4.do")
	public String getPhoto4BySt_num(@RequestParam(required = false) int st_num, HttpServletRequest request, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);

		viewPhoto4(styleVO, request, model);

		return "imageView";
	}
	//스타일번호 지정을 통한 게시물 사진 처리를 위한 코드
	public void viewPhoto1(StyleVO styleVO, HttpServletRequest request, Model model) {
		model.addAttribute("imageFile", styleVO.getSt_photo1());
		model.addAttribute("filename", styleVO.getSt_photo1n());
	}
	public void viewPhoto2(StyleVO styleVO, HttpServletRequest request, Model model) {
		if(styleVO.getSt_photo2() != null) {
			model.addAttribute("imageFile", styleVO.getSt_photo2());
			model.addAttribute("filename", styleVO.getSt_photo2n());			
		}
	}
	public void viewPhoto3(StyleVO styleVO, HttpServletRequest request, Model model) {
		if(styleVO.getSt_photo3() != null) {
			model.addAttribute("imageFile", styleVO.getSt_photo3());
			model.addAttribute("filename", styleVO.getSt_photo3n());			
		}
	}
	public void viewPhoto4(StyleVO styleVO, HttpServletRequest request, Model model) {
		if(styleVO.getSt_photo4() != null) {
			model.addAttribute("imageFile", styleVO.getSt_photo4());
			model.addAttribute("filename", styleVO.getSt_photo4n());			
		}
	}
	
	/*========================
	 * 스타일 수정
	 *========================*/
	//수정 폼 호출
	@GetMapping("/style/update.do")
	public String formUpdate(@RequestParam int st_num, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);
		model.addAttribute("styleVO", styleVO);
		
		return "styleModify";
	}
	//전송된 데이터 처리
	@PostMapping("/style/update.do")
	public String submitUpdate(
			    @Valid StyleVO styleVO,
			    BindingResult result,
			    HttpServletRequest request,
			    Model model) {
		
		StyleVO db_styleVO = styleService.selectStyle(styleVO.getSt_num());
		styleVO.setSt_photo1(db_styleVO.getSt_photo1());
		styleVO.setSt_photo1n(db_styleVO.getSt_photo1n());
		if(db_styleVO.getSt_photo2n() != null) {
			styleVO.setSt_photo2(db_styleVO.getSt_photo2());
			styleVO.setSt_photo2n(db_styleVO.getSt_photo2n());
		}
		if(db_styleVO.getSt_photo3n() != null) {
			styleVO.setSt_photo3(db_styleVO.getSt_photo3());
			styleVO.setSt_photo3n(db_styleVO.getSt_photo3n());
		}
		if(db_styleVO.getSt_photo4n() != null) {
			styleVO.setSt_photo4(db_styleVO.getSt_photo4());
			styleVO.setSt_photo4n(db_styleVO.getSt_photo4n());
		}
		
		log.debug("<<글 수정 - StyleVO>> : " + styleVO);
		
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "styleModify";
		}
		
		//글 수정
		styleService.updateStyle(styleVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/style/detail.do?st_num=" + styleVO.getSt_num());

		return "common/resultView";
	}
	
	/*========================
	 * 스타일 삭제
	 *========================*/
	@RequestMapping("/style/delete.do")
	public String submitDelete(
			     @RequestParam int st_num) {
		log.debug("<<글삭제 - st_num>> : " + st_num);
		
		//글삭제
		styleService.deleteStyle(st_num);
		
		return "redirect:/style/list.do";
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
	
	//프로필 사진 출력(스타일번호 지정)
	@RequestMapping("/style/viewProfile.do")
	public String getProfileBySt_num(@RequestParam(required = false) int st_num, HttpServletRequest request, Model model) {
		StyleVO styleVO = styleService.selectStyle(st_num);

		viewProfile(styleVO, request, model);

		return "imageView";
	}
	//스타일번호 지정을 통한 프로필 사진 처리를 위한 코드
	public void viewProfile(StyleVO styleVO, HttpServletRequest request, Model model) {
		if(styleVO == null || styleVO.getMem_photo() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", styleVO.getMem_photo());
			model.addAttribute("filename", styleVO.getMem_photo_name());
		}
	}
	
	//로그인한 회원 프로필 사진 출력
	@RequestMapping("/style/viewProfileByMem_num.do")
	public String getProfileByMem_num(HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO = null;
		if(user != null) {
			memberVO = memberService.selectMember(user.getMem_num());
		}
		
		
		viewProfileByMem_num(memberVO, request, model);
		
		return "imageView";
	}
	//회원번호 지정을 통한 프로필 사진 처리를 위한 코드
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
	
	//댓글번호를 통해 회원 프로필 사진 출력
	@RequestMapping("/style/viewProfileByCom_num.do")
	public String getProfileByCom_num(@RequestParam(required = false) int com_num, HttpServletRequest request, Model model) {
		StyleCommentVO styleCommentVO = styleService.selectComment(com_num);

		viewProfileByCom_num(styleCommentVO, request, model);

		return "imageView";
	}
	//댓글번호 지정을 통한 프로필 사진 처리를 위한 코드
	public void viewProfileByCom_num(StyleCommentVO styleCommentVO, HttpServletRequest request, Model model) {
		if(styleCommentVO == null || styleCommentVO.getMem_photo() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", styleCommentVO.getMem_photo());
			model.addAttribute("filename", styleCommentVO.getMem_photo_name());
		}
	}
	
	//상품번호를 통해 상품 대표 사진 출력
	@RequestMapping("/style/viewPhotoByItem_num.do")
	public String getPhotoByItem_num(@RequestParam(required = false) int item_num, HttpServletRequest request, Model model) {
		ItemVO itemVO = itemService.selectItem(item_num);

		viewPhotoByItem_num(itemVO, request, model);

		return "imageView";
	}
	//댓글번호 지정을 통한 프로필 사진 처리를 위한 코드
	public void viewPhotoByItem_num(ItemVO itemVO, HttpServletRequest request, Model model) {
		
			model.addAttribute("imageFile", itemVO.getItem_photo1());
			model.addAttribute("filename", itemVO.getItem_photo1name());
	}
}

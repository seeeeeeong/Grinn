package kr.spring.item.controller;

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
import kr.spring.item.vo.ItemFavVO;
import kr.spring.item.vo.ItemReviewVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ItemController {

	@Autowired
	private ItemService itemService;

	// ===========자바빈 초기화===========
	@ModelAttribute
	public ItemVO initCommand() {

		return new ItemVO();
	}
	
	@ModelAttribute
	public ItemReviewVO initReviewCommand() {

		return new ItemReviewVO();
	}

	// ===========게시판 목록===========
	@RequestMapping("/item/itemList.do")
	public ModelAndView getItemList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage, 
									@RequestParam(value="order",defaultValue = "1") int order,
									String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = itemService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 12, 10, "itemList.do","&order="+order);
		
		List<ItemVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = itemService.selectList(map);
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("itemList");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}

	// ===========상품 목록 시작(관리자)===========
	@RequestMapping("/item/itemAdminList.do")
	public ModelAndView getAdminItemList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = itemService.selectRowCount(map);

		log.debug("<<count>> : " + count);

		// 페이지처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "itemAdminList.do",
				"&order=" + order);

		List<ItemVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("itemAdminList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());

		return mav;
	}
	// ===========상품 목록 끝 (사용자&관리자)===========
	
	
	// ===========상품 등록시작(관리자)===========
	// 등록폼
	@GetMapping("/item/itemWrite.do")
	public String form() {
		return "itemWrite";
	}

	// ========상품 사진 출력==========
	// 상품 사진 출력(로그인 전용)
	@RequestMapping("/item/photoView.do")
	public String getProfile(@RequestParam int item_num,HttpServletRequest request,Model model) {
		
		ItemVO itemVO = itemService.selectItem(item_num);
		
		model.addAttribute("imageFile", itemVO.getItem_photo1());
		model.addAttribute("filename", itemVO.getItem_photo1name());
	
		return "imageView";
	}
	
	/*
	public String getProfile(@RequestParam int item_num,@RequestParam int item_type,
			HttpServletRequest request,Model model) {
		
		ItemVO itemVO = itemService.selectItem(item_num);
		
		if(item_type==1) {
			model.addAttribute("imageFile", itemVO.getItem_photo1());
			model.addAttribute("filename", itemVO.getItem_photo1name());
		}else if(item_type==2) {
			model.addAttribute("imageFile", itemVO.getItem_photo2());
			model.addAttribute("filename", itemVO.getItem_photo2name());
		}
		return "imageView";
	}
	*/

	// 상품 사진 출력(회원번호 지정)
	@RequestMapping("/item/viewProfile.do")
	public String getProfileByItem_num(@RequestParam int item_num, HttpServletRequest request, Model model) {
		ItemVO itemVO = itemService.selectItem(item_num);
		
		viewProfile(itemVO, request, model);
		
		return "imageView";
	}

	// 상품 사진 처리를 위한 공통 코드
	public void viewProfile(ItemVO itemVO, HttpServletRequest request, Model model) {
		if (itemVO == null || itemVO.getItem_photo1() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/item_add.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", itemVO.getItem_photo1());
			model.addAttribute("filename", itemVO.getItem_photo1name());
		}
	}

	// 상품 등록 요청 처리
	@PostMapping("/item/itemWrite.do")
	public String itemWrite(@ModelAttribute("itemVO") ItemVO itemVO,HttpServletRequest request,Model model) {
		// 상품 등록 로직 호출
		itemService.insertItem(itemVO);

		model.addAttribute("message", "상품을 등록했습니다");
		model.addAttribute("url", request.getContextPath()+"/item/itemAdminList.do");
		
		return "common/resultView";
	}
	
	//=========상품등록 끝============
	
	//=========상품 상세 시작============
	@RequestMapping("/item/itemDetail.do")
	public ModelAndView getDetail(@RequestParam int item_num) {
		//상품상세
		ItemVO item = itemService.selectItem(item_num);
		
		return new ModelAndView("itemDetail","item",item);
	}
	//=========상품 상세 끝============
	
	
	//=========상품 수정 시작============
	//수정폼 호출
	@GetMapping("/item/itemModify.do")
	public String formUpdate(@RequestParam int item_num, Model model) {
		
		ItemVO itemVO = itemService.selectItem(item_num);
		model.addAttribute("itemVO",itemVO);
		
		return "itemModify";
	}
	//전송된 데이터 처리
	@PostMapping("/item/itemModify.do")
	public String submitModify(@Valid ItemVO itemVO, BindingResult result, 
									HttpServletRequest request, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "itemModify";
		}
		
		//글수정
		itemService.updateItem(itemVO);
		
		model.addAttribute("message", "상품 수정 완료!");
		model.addAttribute("url", request.getContextPath()+"/item/itemDetail.do?item_num="+itemVO.getItem_num());
		
		return "common/resultView";
		
	}
	//=========상품 수정 끝============
	
	//=========상품 삭제 시작============
	@RequestMapping("/item/itemDelete.do")
	public String submitDelete(@RequestParam int item_num) {
		
		itemService.deleteItem(item_num);
		
		return "redirect:/item/itemAdminList.do";
	}
	//=========상품 삭제 끝============
	
	//=========관심 상품(좋아요) 시작============
	@RequestMapping("/item/getFav.do")
	@ResponseBody
	public Map<String, Object> getFav(ItemFavVO fav, HttpSession session){
		
		//세션에 로그인 여부 확인
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않았을 때
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			ItemFavVO itemFav = itemService.selectFav(fav);
			
			if(itemFav!=null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", itemService.selectFavCount(fav.getItem_num()));
		
		return mapJson;
	}
	
	//좋아요 등록/삭제
	@RequestMapping("/item/writeFav.do")
	@ResponseBody
	public Map<String, Object> writeFav(ItemFavVO fav,HttpSession session){
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			ItemFavVO itemFav = itemService.selectFav(fav);
			if(itemFav!=null) {
				itemService.deleteFav(itemFav.getItem_favNum());
				
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			}else {//등록한 좋아요가 없으면 등록
				itemService.insertFav(fav);
				
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", itemService.selectFavCount(fav.getItem_num()));
		}
		
		return mapJson;
	}
	//=========관심 상품(좋아요) 끝============
	
	//=========후기 등록 시작============
	//폼호출
	@GetMapping("/item/itemReview.do")
	public String itemReview(@RequestParam int item_num, Model model) {
		
		ItemVO item = itemService.selectItem(item_num);
		
		model.addAttribute("item",item);
		
		return "itemReviewWrite";
	}

	//후기 등록
	@PostMapping("/item/itemReview.do")
	public String itemReview(@Valid ItemReviewVO itemReviewVO,BindingResult result,
								@RequestParam int item_num,
								HttpSession session, Model model,HttpServletRequest request) {
		
		itemReviewVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		
		itemService.insertReview(itemReviewVO);
		
		model.addAttribute("message", "리뷰 작성 완료");
		model.addAttribute("url", request.getContextPath()+"/item/itemAdminList.do");
		
		return "common/resultView";
	}
	//=========후기 등록 끝============
	
	//=========후기 목록 시작============
	@RequestMapping("/item/listReview.do")
	@ResponseBody
	public Map<String, Object> getReviewList(
					@RequestParam(value="pageNum",defaultValue="1") int currentPage,
					@RequestParam(value="rowCount",defaultValue="10") int rowCount,
					@RequestParam int item_num, HttpSession session){
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item_num", item_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//전체 레코드 수
		int count = itemService.selectRowCountReview(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 1, null);
		
		List<ItemReviewVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = itemService.selectListReview(map);
		}else {
			list=Collections.emptyList();
		}
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		return mapJson;
	}
	//=========후기 목록 끝============
}

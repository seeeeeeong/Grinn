package kr.spring.item.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
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
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "itemList.do","&order="+order);
		
		List<ItemVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = itemService.selectList(map);
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("item/itemList");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	// ===========상품 등록시작(관리자)===========
	// 등록폼
	@GetMapping("/item/write.do")
	public String form() {
		return "item/itemWrite";
	}

	// ========상품 사진 출력==========
	// 상품 사진 출력(로그인 전용)
	@RequestMapping("/item/photoView.do")
	public void viewProfile(@RequestParam("file") MultipartFile file, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			if (file.isEmpty()) {
				// 기본 이미지 읽기
				byte[] readByte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
				response.setContentType("image/png");
				OutputStream out = response.getOutputStream();
				out.write(readByte);
				out.close();
			} else {
				// 업로드한 상품 사진이 있는 경우
				ItemVO itemVO = new ItemVO();
				itemVO.setUpload(file); // MultipartFile 객체를 사용하여 ItemVO에 이미지 저장

				// 여기서 itemVO에서 item_photo1 또는 item_photo2에 해당하는 이미지 데이터를 가져와서 response에 출력합니다.
				// 아래 코드는 itemVO의 item_photo1 데이터를 response에 출력하는 예시입니다.
				byte[] imageData = itemVO.getItem_photo1();
				if (imageData != null && imageData.length > 0) {
					response.setContentType("image/png"); // 이미지 타입에 맞게 Content-Type 설정
					OutputStream out = response.getOutputStream();
					out.write(imageData);
					out.close();
				} else {
					// 이미지가 없을 경우에 대한 처리 (예를 들어 기본 이미지를 보여주는 등)
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 상품 사진 출력(회원번호 지정)
	@RequestMapping("/item/viewProfile.do")
	public String getProfileByItem_num(@RequestParam int item_num, HttpServletRequest request, Model model) {
		ItemVO itemVO = itemService.selectItem(item_num);
		if (itemVO == null || itemVO.getItem_photo1name() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", itemVO.getItem_photo1());
			model.addAttribute("filename", itemVO.getItem_photo1name());
		}
		System.out.println("1");
		return "imageView";
	}

	// 상품 사진 처리를 위한 공통 코드
	public void viewProfile(ItemVO itemVO, HttpServletRequest request, Model model) {
		if (itemVO == null || itemVO.getItem_photo1name() == null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		} else {
			// 업로드한 상품 사진이 있는 경우
			model.addAttribute("imageFile", itemVO.getItem_photo1());
			model.addAttribute("filename", itemVO.getItem_photo1name());
		}
		System.out.println("2");
	}

	// 상품 등록 요청 처리
	@PostMapping("/item/itemWrite.do")
	public String itemWrite(@ModelAttribute("itemVO") ItemVO itemVO,Model model) {
		// 상품 등록 로직 호출
		itemService.insertItem(itemVO);

		model.addAttribute("accessMsg", "상품등록이 완료되었습니다.");
		// 상품 등록 후 이동할 페이지 지정 (원하는 대로 변경)
		return "common/notice";
	}
	
	//=========상품등록 끝============

}

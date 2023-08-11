<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
	//사진 슬라이드
    const slides = $('.slides'); // 전체 슬라이드 컨테이너
    const slideImg = $('.slides li'); // 모든 슬라이드들
    let currentIdx = 0; // 현재 슬라이드 index
    const slideCount = slideImg.length; // 슬라이드 개수
    const prev = $('.prev'); // 이전 버튼
    const next = $('.next'); // 다음 버튼
    const slideWidth = 400; // 한 개의 슬라이드 넓이
    const slideMargin = 300; // 슬라이드 간의 margin 값

    // 전체 슬라이드 컨테이너 넓이 설정
    slides.width((slideWidth + slideMargin) * slideCount);

    function moveSlide(num) {
      slides.css('left', -num * 600 + 'px');
      currentIdx = num;
    }

    prev.on('click', function() {
      /* 첫 번째 슬라이드로 표시 됐을 때는
      이전 버튼 눌러도 아무런 반응 없게 하기 위해
      currentIdx !==0일 때만 moveSlide 함수 불러옴 */
      if (currentIdx !== 0) moveSlide(currentIdx - 1);
    });

    next.on('click', function() {
      /* 마지막 슬라이드로 표시 됐을 때는
      다음 버튼 눌러도 아무런 반응 없게 하기 위해
      currentIdx !==slideCount - 1 일 때만
      moveSlide 함수 불러옴 */
      if (currentIdx !== slideCount - 1) {
        moveSlide(currentIdx + 1);
      }
    });
  	//사진 슬라이드
  	
  	//댓글 팝업
  	const btn = document.getElementById('popupBtn');
	const modal = document.getElementById('modalWrap');
	const closeBtn = document.getElementById('closeBtn');
	
	btn.onclick = function() {
	  modal.style.display = 'block';
	  $(".fixed").css({
		    "position":"static"
	  });
	  $("#main_body").css({
		  "padding": "0 0 30px 0"
	  });
	}
	closeBtn.onclick = function() {
	  modal.style.display = 'none';
	  $(".fixed").css({
		    "position":"fixed"
	  });
	  $("#main_body").css({
		  "padding": "144px 0 30px 0"
	  });
	}
	
	  const optionBtn = document.getElementById('more-btn');
	  const optionModal = document.getElementById('optionWrap');
	  const optionCloseBtn = document.getElementById('closeOption');

	  optionBtn.onclick = function() {
		optionModal.style.display = 'block';
		$(".fixed").css({
		    "position":"static"
	  	});
	  	$("#main_body").css({
		  "padding": "0 0 30px 0"
	  	});
	  }
	  optionCloseBtn.onclick = function() {
		optionModal.style.display = 'none';
		  $(".fixed").css({
			    "position":"fixed"
		  });
		  $("#main_body").css({
			  "padding": "144px 0 30px 0"
		  });
	  }

	  window.onclick = function(event) {
	    if (event.target == optionModal) {
	    	optionModal.style.display = "none";
		  	  $(".fixed").css({
				    "position":"fixed"
			  });
			  $("#main_body").css({
				  "padding": "144px 0 30px 0"
			  });
	    }
	  }
	 
  });
  


</script>
<!-- 챗봇 상세 -->
<div class="page-main" id="styleDetail">
	<div class="user-div">
		<div class="user-profile">
			<img src="${pageContext.request.contextPath}/style/viewProfile.do?st_num=${style.st_num}" class="profile-photo">
			<div class="nameAndDate">
				<span class="username">${style.mem_id}</span>
				<div class="post-date">
					<span class="posted-date"><small>${style.st_regdate}</small></span>
					<c:if test="${!empty style.st_mdate}">
						<span class="modified-date"><small>${style.st_mdate}</small></span>
					</c:if>
				</div>
			</div>
		</div>
		<!-- 옵션 팝업 버튼 -->
		<c:if test="${!empty user}">
			<div class="more-option">
				<span id="more-btn">•••</span>
			</div>
		</c:if>
		<div id="optionWrap" style="display:none;">
		  <div id="optionContent">
		    <div id="optionBody">
		      <span id="closeOption">&times;</span> 
		      <div class="options">
		      	<ul>
		      		<li>
		      			<c:if test="${!empty user && user.mem_num == style.mem_num}">
		      				<span>수정</span>
		      			</c:if>
		      			<c:if test="${!empty user && user.mem_num != style.mem_num}">
		      				<span>팔로우</span>
		      			</c:if>		      			
		      		</li>
		      		<li>
		      			<c:if test="${!empty user && user.mem_num == style.mem_num}">
		      				<span id="delete_btn" style="color:red;">삭제</span>
							<script type="text/javascript">
								let delete_btn = document.getElementById('delete_btn');
								delete_btn.onclick=function(){
									let choice = confirm('삭제하시겠습니까?');
									if(choice){
										location.replace('delete.do?st_num=${style.st_num}');
									}
								};
							</script>        		      				
		      			</c:if>
		      			<c:if test="${!empty user && user.mem_num != style.mem_num}">
		      				<span style="color:red;">신고</span>
		      			</c:if>	
		      		</li>
		      		<li>
		      			<span><a href="/user/userStyle.do?mem_num=${style.mem_num}">이 계정 정보</a></span>
		      		</li>
		      	</ul>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
    <div class="style-photos">
	    <div id="slideShow">
	    <ul class="slides">
	    	<li>
		  		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo1n}" width="500" height="500">
		    </li>
		    <c:if test="${!empty style.st_photo2n}">
		    <li>
		    	
		    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo2n}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty style.st_photo3n}">
		    <li>
		    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo3n}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty style.st_photo4n}">
		    <li>
		    		<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo4n}" width="500" height="500">
		    </li>
		    </c:if>
	    </ul>
	    <c:if test="${!empty style.st_photo2n && !empty style.st_photo3n && !empty style.st_photo4n}">
	    <p class="controller">
	      
	      <!-- &lang: 왼쪽 방향 화살표
	      &rang: 오른쪽 방향 화살표 -->
	      <span class="prev">&lang;</span>  
	      <span class="next">&rang;</span>
	    </p>
	    </c:if>
	  	</div><p>
  	</div>
    
    <div class="style-content">
    	<div class="item-tag">
    		<div class=tag-title>
				상품 태그
			</div>
			<div class="item-tag-box">
				<img src="${pageContext.request.contextPath}/image_upload/${style.item_photo1name}" width="100" height="100"><br>
				<span class="item-name" style="width:100px;">${style.item_name}</span>
			</div>
		
		</div><p>	
		<div id="btnWrap">
			<img id="output_fav" data-num="${style.st_num}" src="${pageContext.request.contextPath}/images/no_like.png" width="30" height="30">
			<img id="popupBtn" src="${pageContext.request.contextPath}/images/comm_icon.png" width="33" height="33">
		</div><p>
		<span id="output_fcount"></span>
	    <div class="post-caption">
	      <p>${style.st_phrase}</p>
	    </div><p>
    </div>
    <!-- 댓글 팝업창 -->
	<div id="modalWrap" style="display:none;">
	  <div id="modalContent">
	  	<div id="modalBody">
	      <span id="closeBtn">&times;</span><!-- 닫기 버튼 -->
	      <br>
	      <div id="comment_title">
	      	<h2>댓글</h2>
	      </div>
	      	<div class="comment-user-profile">
				<img src="${pageContext.request.contextPath}/style/viewProfile.do?st_num=${style.st_num}" class="profile-photo">
				<div class="nameAndDate">
					<span class="username">${style.mem_id}</span>
					<div class="post-date">
				      <span class="posted-date"><small>${style.st_regdate}</small></span>
				      <c:if test="${!empty style.st_mdate}">
				        <span class="modified-date"><small>${style.st_mdate}</small></span>
				      </c:if>
					</div>
			    </div>
		    </div>
	      <div class="comment-post-caption">
	      	${style.st_phrase}<br>
	   	  </div>
	   	  <hr width="100%" color="#f4f4f4">
	   	  <!-- 댓글폼 -->
	   	  <div class="comment-form">
	   	  	<img src="${pageContext.request.contextPath}/style/viewProfileByMem_num.do" class="comment-login-photo">
	   	  	<form id="com_form">
	   	  		<input type="hidden" name="st_num" value="${style.st_num}" id="st_num">
	   	  		<textarea rows="1" cols="28" name="com_comment" id="com_comment"
	   	  		<c:if test="${empty user}">disabled="disabled" placeholder="로그인 후 이용 가능합니다."</c:if>
	   	  		<c:if test="${!empty user}">placeholder="댓글을 입력하세요..."</c:if>></textarea>
	   	  		<c:if test="${!empty user}">
	   	  			<input type="submit" value="등록" class="comment-submit">
	   	  		</c:if>
	   	  	</form>
	   	  </div>
	   	  <!-- 댓글폼 -->
	   	  <hr width="100%" color="#f4f4f4">
	   	  <!-- 댓글 목록 출력 -->
			<div id="output"></div>
			<div class="paging-button" style="display:none;">
				<input type="button" value="더보기">
			</div>
			<!-- 댓글 끝 -->
	  	</div>
	  	
	  </div>
	</div>
</div>
<!-- 챗봇 상세 -->
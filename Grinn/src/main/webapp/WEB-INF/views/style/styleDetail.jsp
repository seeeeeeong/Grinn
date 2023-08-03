<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
    <style>
    #yijunesok_st{
    	align-items: stretch;
    	padding: 0;
    }
    .user-profile{
    	padding:0 335px 0 335px;
    }
    .user-profile .username{
    	font-size:15pt;
    }
    .style-content{
    	padding:0 335px 0 335px;
    }
    .item-tag .tag-title{
    	font-size:15pt;
    }
    #output_fcount{
	    box-sizing: border-box;
	    width:100px;
	    color: black;
	    text-decoration: none;
	    font-size: 15px;
	    letter-spacing: -.33px;
	    line-height: 22px;
    }
	.post-caption{
	    color: #222;
	    box-sizing: border-box;
	    margin: 0;
	    padding: 0;
	    font-size: 15px;
	}

	/* 사진 슬라이드 */
	li{
	  list-style-type: none;
	}
	
	/* 보여줄 구간의 높이와 넓이 설정 */
	#slideShow{
	  width: 700px;
	  height: 500px;
	  position: relative;
	  margin: 10px auto;
	  overflow: hidden;   
	  /*리스트 형식으로 이미지를 일렬로 
	  정렬할 것이기 때문에, 500px 밖으로 튀어 나간 이미지들은
	  hidden으로 숨겨줘야됨*/
	}
	
	
	.slides{
	  position: absolute;
	  left: 0;
	  top: 0;
	  padding:0;
	  width: 3400px; /* 슬라이드할 사진과 마진 총 넓이 */
	  transition: left 0.3s ease-out; 
	  /*ease-out: 처음에는 느렸다가 점점 빨라짐*/
	}
	
	/* 첫 번째 슬라이드 가운데에 정렬하기위해
	첫번째 슬라이드만 margin-left조정 */
	.slides li:first-child{
	  margin-left: 100px;
	}
	
	/* 슬라이드들 옆으로 정렬 */
	.slides li:not(:last-child){
	  float: left;
	  margin-right: 100px;
	}
	
	.slides li{
	  float: left;
	}
	
	.controller span{
	  position:absolute;
	  background-color: transparent;
	  color: black;
	  text-align: center;
	  border-radius: 50%;
	  padding: 10px 20px;
	  top: 50%;
	  font-size: 1.3em;
	  cursor: pointer;
	}
	
	/* 이전, 다음 화살표에 마우스 커서가 올라가 있을때 */
	.controller span:hover{
	  background-color: rgba(128, 128, 128, 0.11);
	}
	
	.prev{
	  left: 10px;
	}
	
	/* 이전 화살표에 마우스 커서가 올라가 있을때 
	이전 화살표가 살짝 왼쪽으로 이동하는 효과*/
	.prev:hover{
	  transform: translateX(-10px);
	}
	
	.next{
	  right: 10px;
	}
	
	/* 다음 화살표에 마우스 커서가 올라가 있을때 
	이전 화살표가 살짝 오른쪽으로 이동하는 효과*/
	.next:hover{
	  transform: translateX(10px);
	}
	
	/* 댓글 팝업 */
	/*버튼을 감싸는 영역*/
	#btnWrap {
	  
	}
	
	/*버튼 디자인*/
	#popupBtn {
	  
	}
	
	/*모달팝업을 감싸고 있는 최상위 부모*/
	#modalWrap {
	  position: fixed; /* Stay in place */
	  z-index: 1; /* Sit on top */
	  
	  left: 0;
	  top: 0;
	  width: 100%; /* Full width */
	  height: 100%; /* Full height */
	  overflow: auto; /* Enable scroll if needed */
	  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
	
	#modalContent{
		float:right;
	}
	
	/*모달 팝업창*/
	#modalBody {
	  width: 400px;
	  height: 829px;
	  padding: 30px 30px;
	  margin: 0 auto;
	  
	  background-color: #fff;
	}
	
	/*닫기 버튼*/
	#closeBtn {
	  float:left;
	  font-size:40px;
	  cursor: pointer;
	  padding-top:7px;
	}
	#comment_title h2{
		margin:0;
		padding-left:30px;
	}
	</style>
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
	}
	closeBtn.onclick = function() {
	  modal.style.display = 'none';
	}
	
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
  });
  
  

</script>
<!-- 스타일 상세 -->
<div class="page-main" id="yijunesok_st">
	<div class="user-profile">
		<img src="profile_picture.png" class="profile-photo">
		<span class="username">${style.mem_id}</span>
		<div class="post-date">
	      <span class="posted-date"><small>${style.st_regdate}</small></span>
	      <c:if test="${!empty style.st_mdate}">
	        <span class="modified-date"><small>${style.st_mdate}</small></span>
	      </c:if>
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
			<span class="item-tag-box">
				<img src="${pageContext.request.contextPath}/image_upload/${style.item_photo1name}" width="100" height="100"><br>
				<span class="item-name">${style.item_name}</span>
			</span>
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
	      
	      <p>modal-popup 입니다.</p> <!-- 팝업창 내 글귀 -->
	    </div>
	  </div>
	</div>
</div>
<!-- 스타일 상세 -->
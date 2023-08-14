<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.comment.js"></script>
    <style>
    #styleDetail{
    	align-items: stretch;
    	padding: 0;
    }
    
    .profile-photo{
    	width:35px;
    	height:35px;
    	border-radius:70%;
    }
	.user-div{
		padding:0 335px 0 335px;
	}
    .user-profile{
    	display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:65%;
        float:left;
    }
    .user-profile .username{
    	font-size:15pt;
    }
    .nameAndDate{
    	margin-left:5px;
    }
    .posted-date{
    	font-size:10pt;
    	color:#9d9d9d;
    }
    .modified-date{
    	font-size:10pt;
    	color:#9d9d9d;
    	padding-left:20px;
    }
    .comment-posted-date{
    	font-size:10pt;
    	color:#9d9d9d;
    }
    .comment-modified-date{
    	font-size:10pt;
    	color:#9d9d9d;
    }
    .style-content{
    	padding:0 335px 0 335px;
    }
    .item-tag .tag-title{
    	font-size:15pt;
    }
    .item-tag-box{
    	width:100px;
    }
    .item-name{
    	width:100px;
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
	
	/* 더보기 */
	#more-btn{
		float:right;
		width:7%;
		margin-top:5px;
	}
	#optionWrap {
	  position: fixed; /* Stay in place */
	  z-index: 1; /* Sit on top */
	  padding-top: 100px; /* Location of the box */
	  left: 0;
	  top: 0;
	  width: 100%; /* Full width */
	  height: 100%; /* Full height */
	  overflow: auto; /* Enable scroll if needed */
	  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
	
	#optionBody {
	  width: 100px;
	  height: 100px;
	  padding: 30px 30px;
	  margin: 0 auto;
	  border: none;
	  border-radius:5%;
	  background-color: #fff;
	}
	
	#closeOption {
	  float:left;
	  font-size:20px;
	  cursor: pointer;
	}
	
	.options{
		margin-top:30px;
		text-align:center;
		font-size:12pt;
	}
	.options ul{
		padding:0;
		margin:5px auto;
	}
	.options li{
		margin-bottom:5px;
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
	  margin:0;
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
	  padding-left:10px;
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
		height:887px;
		background-color:white;
	}
	
	/*모달 팝업창*/
	#modalBody {
	  width: 400px;
	  height: auto;
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
	.comment-user-profile{
		font-size:15pt;
		margin:20px 0 0 0;
    	display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        padding-left:0;
	}
	.comment-post-caption{
		padding-top:20px;
		padding-left:15px;
		magin-top:10px;
	}
	.comment-form{
		display: flex;
		width:500px;
	}
	#com_form{
		border-style:hidden;
		padding:3px 0 0 10px;
		width:500px;
		display:flex;
	}
	.comment-login-photo{
		width:30px;
		height:30px;
		border-radius: 70%;
	}
	#com_comment{
		font-size:13pt;
		box-sizing: border-box;
		border: solid 2px #dedede;
		border-radius: 5px;
	}
	.comment-submit{
		magin-left:10px;
	}
	.sub-item .com_btn{
		text-align:right;
	}
	#mre_form{
		padding:0;
		margin:0;
		width:400px;
	}
	#mre_content{
		font-size:13pt;
		box-sizing: border-box;
		border: solid 2px #dedede;
		border-radius: 5px;
		
	}
	#mre_second.com_btn{
		width:400px;
		text-align:right;
		align-items: stretch;
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
<!-- 스타일 상세 -->
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
		      				<span><a href="/style/styleReport.do?st_num=${style.st_num}" style="color:red;">신고</a></span>
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
		  		<img src="${pageContext.request.contextPath}/style/viewPhoto1.do?st_num=${style.st_num}" width="500" height="500">
		    </li>
		    <c:if test="${!empty style.st_photo2n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto2.do?st_num=${style.st_num}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty style.st_photo3n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto3.do?st_num=${style.st_num}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty style.st_photo4n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto4.do?st_num=${style.st_num}" width="500" height="500">
		    </li>
		    </c:if>
	    </ul>
	    <c:if test="${!empty style.st_photo2n}">
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
    	<c:if test="${style.item_photo1name != null}">
    	<div class="item-tag">
    		<div class=tag-title>
				상품 태그
			</div>
			<div class="item-tag-box">
				<img src="${pageContext.request.contextPath}/image_upload/${style.item_photo1name}" width="100" height="100"><br>
				<span class="item-name" style="width:100px;">${style.item_name}</span>
			</div>
		</div>
		</c:if><p>	
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
<!-- 스타일 상세 -->
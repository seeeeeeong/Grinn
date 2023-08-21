<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 게시물 신고 작성 -->
<style>
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
	/* 사진 슬라이드 */
	
.style-title {
	margin: 0 auto;
	width: 500px;
	text-align: center;
}

.tag-title {
	margin: 0 auto;
	width: 500px;	
	font-size: 15pt;
}
    .user-profile{
    	display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:500px;
        float:left;
        margin-left:350px;
        margin-top:10px;
    }
    .profile-photo{
    	width:35px;
    	height:35px;
    	border-radius:70%;
    }

	.style-report{
		width: 500px;
		margin: 0 auto;
		padding:0;
		border: none;
	}
	.style-info{
		display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:500px;
	}
	.except-photo{
		width:500px;
	}
	.except-photo p{
		margin-top:0;
		margin-bottom:20px;
	}
	.date-format{
		text-align:right;
		float:right;
	}
	.reps{
		width:500px;
		border:none;
		padding:0;
		margin-bottom:10px;
	}
	.rep-com{
	}
	#rep_com_label{
		
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
    $('#submit_btn').click(function() {
        if ($(".rep-type").is(':checked')) {

        }
        else {
            alert('신고 사유를 선택해주세요.');
            return false;
        }
    })
});
</script>
<div class="page-main">
	<div class="style-title"><h2>신고하기</h2></div>
	<div class="tag-title">게시글 정보</div>
	<div class="user-profile">
		<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${style.mem_num}">
			<img src="${pageContext.request.contextPath}/style/viewProfile.do?st_num=${style.st_num}" class="profile-photo">
		</a>
		<div class="nameAndDate">
			<a href="${pageContext.request.contextPath}/user/userStyle.do?mem_num=${style.mem_num}">
				<span class="username">${style.mem_id}</span>
			</a>
			<div class="post-date">
				<c:if test="${empty style.st_mdate}">
					<span class="posted-date"><small>${style.st_regdate}</small></span>
				</c:if>
				<c:if test="${!empty style.st_mdate}">
					<span class="modified-date"><small>${style.st_mdate}</small></span>
				</c:if>
			</div>
		</div>
	</div>
	<div id="slideShow">
		<ul class="slides">
			<li><img
				src="${pageContext.request.contextPath}/style/viewPhoto1.do?st_num=${style.st_num}"
				width="500" height="500"></li>
			<c:if test="${!empty style.st_photo2n}">
				<li><img
					src="${pageContext.request.contextPath}/style/viewPhoto2.do?st_num=${style.st_num}"
					width="500" height="500"></li>
			</c:if>
			<c:if test="${!empty style.st_photo3n}">
				<li><img
					src="${pageContext.request.contextPath}/style/viewPhoto3.do?st_num=${style.st_num}"
					width="500" height="500"></li>
			</c:if>
			<c:if test="${!empty style.st_photo4n}">
				<li><img
					src="${pageContext.request.contextPath}/style/viewPhoto4.do?st_num=${style.st_num}"
					width="500" height="500"></li>
			</c:if>
		</ul>
		<c:if test="${!empty style.st_photo2n}">
			<p class="controller">
				<!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 -->
				<span class="prev" id="prev">&lang;</span> <span class="next"
					id="next">&rang;</span>
			</p>
		</c:if>
	</div>
	<div class="style-report">
		<form action="styleReport.do" method="post" class="style-report">
			<div class="style-info">
				<div class="except-photo">
					<p style="font-size:12pt;">${style.st_phrase}</p>
					
				</div>
			</div>		
			<div class="tag-title">신고 사유</div>	
			<fieldset class="reps">
				<input type="hidden" name="st_num" value="${style.st_num}">
				<input type="hidden" name="reported_mem" value="${style.mem_num}">
				<div>
					<input type="radio" id="rep_1" class="rep-type" name="rep_type" value="1">
					선정적인 게시물			
				</div>
				<div>
					<input type="radio" id="rep_2" class="rep-type" name="rep_type" value="2">
					관련 없는 상품 태그 또는 해시태그			
				</div>
				<div>
					<input type="radio" id="rep_3" class="rep-type" name="rep_type" value="3">
					영리목적/홍보성 게시물		
				</div>			
				<div>
					<input type="radio" id="rep_4" class="rep-type" name="rep_type" value="4">
					비방성 게시물			
				</div>			
			</fieldset>
			<div class="tag-title">신고 내용</div>	
			<div class="rep-com">
			<textarea rows="4" cols="59" name="rep_com" id="rep_com" placeholder="구체적인 신고 사유를 작성해주세요."></textarea>
			</div>
			<div class="align-center">
				<input type="submit" value="등록" id="submit_btn">
				<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/detail.do?st_num=${style.st_num}'">
			</div>
		</form>
	</div>
</div>
<!-- 게시물 신고 작성 -->
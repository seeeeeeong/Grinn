<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 스타일 수정 시작 -->
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
	
	.style-title{
		margin:0 auto;
		width:500px;
		text-align:center;
	}
	.style_form{
		width:500px;
		margin:0 auto;
		border:none;
	}
	.style_form ul{
		padding: 0;
	}
	.item-tag{
		width:500px;
		margin-top:5px;
	}
	.item-span{
		display: flex;
        flex-wrap: wrap;
		width:375px;
	}
	.item-span span{
		margin-left:5px;
		width:319px;
		overflow:hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		font-size:14pt;
		padding-top:10px;
	}
	.tag-boxes{
    	display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:504px;
        margin-bottom:15px;
    }
    .tag-title{
    	font-size:15pt;
    }
    .item-tag-box{
    	width:100px;
    	margin-right:15px;
    }
    .item-name{
    	width:100px;
    }
    .delete-tag{
    	font-size:10pt;
    	cursor: pointer;
    	
    }
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/st_itemTag.js"></script>
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
  });
</script>
<div class="page-main">
	<div><h2 class="style-title">스타일 수정</h2></div>
	<div class="style-photos">
	    <div id="slideShow">
	    <ul class="slides">
	    	<li>
		  		<img src="${pageContext.request.contextPath}/style/viewPhoto1.do?st_num=${styleVO.st_num}" width="500" height="500">
		    </li>
		    <c:if test="${!empty styleVO.st_photo2n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto2.do?st_num=${styleVO.st_num}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty styleVO.st_photo3n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto3.do?st_num=${styleVO.st_num}" width="500" height="500">
		    </li>
		    </c:if>
		    <c:if test="${!empty styleVO.st_photo4n}">
		    <li>
		    	<img src="${pageContext.request.contextPath}/style/viewPhoto4.do?st_num=${styleVO.st_num}" width="500" height="500">
		    </li>
		    </c:if>
	    </ul>
	    <c:if test="${!empty styleVO.st_photo2n}">
	    <p class="controller">
	      
	      <!-- &lang: 왼쪽 방향 화살표
	      &rang: 오른쪽 방향 화살표 -->
	      <span class="prev">&lang;</span>  
	      <span class="next">&rang;</span>
	    </p>
	    </c:if>
	  	</div>
  	</div>
	<form:form modelAttribute="styleVO" action="update.do" enctype="multipart/form-data" class="style_form">
		<input type="hidden" name="st_num" value="${styleVO.st_num}">
		<input type="hidden" name="st_photo1" value="${styleVO.st_photo1}">
		<input type="hidden" name="st_photo1n" value="${styleVO.st_photo1n}">
		<ul>
			<li>
				<div class="tag-title">문구 입력</div>
				<form:textarea path="st_phrase" rows="4" cols="60" placeholder="스타일을 자랑해보세요."/>
			</li>
			<li>
				<div class="tag-title">상품 태그</div>
				<div class="item-tag">
					
					<div class="tag-boxes">
						<c:if test="${styleVO.item_num1 != 0}">
						<div class="item-tag-box" id="box1" data-name="${styleVO.item_name1}">
							<div class="delete-tag" id="del1">&#x2716</div>
							<img 
							src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num1}"
							width="100" height="100" data-num="${styleVO.item_num1}">
							<br>
							<span class="item-name1" style="width: 100px;">${styleVO.item_name1}</span>
						</div>
						</c:if>
						<c:if test="${styleVO.item_num2 != 0}">
						<div class="item-tag-box" id="box2" data-name="${styleVO.item_name2}">
							<div class="delete-tag" id="del2">&#x2716</div>
							<img 
							src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num2}" 
							width="100" height="100" data-num="${styleVO.item_num2}">
							<br>
							<span class="item-name2" style="width: 100px;">${styleVO.item_name2}</span>
						</div>
						</c:if>
						<c:if test="${styleVO.item_num3 != 0}">
						<div class="item-tag-box" id="box3" data-name="${styleVO.item_name3}">
							<div class="delete-tag" id="del3">&#x2716</div>
							<img 
							src="${pageContext.request.contextPath}/style/viewPhotoByItem_num.do?item_num=${styleVO.item_num3}" 
							width="100" height="100" data-num="${styleVO.item_num3}">
							<br>
							<span class="item-name3" style="width: 100px;">${styleVO.item_name3}</span>
						</div>
						</c:if>
					</div>
					<input type="text" id="item_search" autocomplete="off" placeholder="상품 태그를 추가해보세요.">
					<ul id="search_area"></ul>
					<div id="item_tag"></div>
				</div>
				<div>
					<input type="hidden" name="item_num1" id="item_num1" value="${styleVO.item_num1}">
					<input type="hidden" name="item_num2" id="item_num2" value="${styleVO.item_num2}">
					<input type="hidden" name="item_num3" id="item_num3" value="${styleVO.item_num3}">
				</div>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="modify-style">수정</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
		</div>
	</form:form>
</div>
<!-- 스타일 수정 끝 -->
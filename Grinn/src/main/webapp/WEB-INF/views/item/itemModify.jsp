<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품등록 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<div class="page-main">
    <h2>상품수정</h2>
    <form:form modelAttribute="itemVO" action="itemModify.do" id="updateItem" method="post" enctype="multipart/form-data">
    <form:hidden path="item_num"/>
        <!-- 사진 등록 시작 -->
        <div>
            <ul>
                <li>
                    <!-- 이미지를 나타낼 <img> 요소 -->
                    <img src="${pageContext.request.contextPath}/item/photoView.do?item_num=${itemVO.item_num}" width="200" height="200" class="item-photo">
                    <div class="camera" id="photo_btn">
                        <img src="${pageContext.request.contextPath}/images/camera.png" width="35">
                    </div>
                </li>
                <li>
                	<div id="photo_choice" style="display:none;">
                    <!-- 파일 업로드 입력 폼 -->
                    	<input type="file" id="upload" name="upload" accept="image/gif,image/png,image/jpeg"><br>
                    </div>
                </li>
            </ul>
        </div>
        <!-- 사진 등록 끝 -->
		<ul>
			<li>
				<form:label path="item_brand">브랜드명</form:label>
				<form:input path="item_brand" placeholder="브랜드명을 입력하세요" autocomplete="off"/>
				<form:errors path="item_brand" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_name">이름</form:label>
				<form:input path="item_name" placeholder="상품명을 입력하세요" autocomplete="off"/>
				<form:errors path="item_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_detail">설명</form:label>
				<form:input path="item_detail" placeholder="상품 설명을 입력하세요" autocomplete="off"/>
			</li>
			<li>
				<form:label path="item_model">모델명</form:label>
				<form:input path="item_model" placeholder="모델명을 입력하세요" autocomplete="off"/>
				<form:errors path="item_model" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_date">출시일</form:label>
				<form:input path="item_date" placeholder="상품 출시일을 입력하세요" autocomplete="off"/>
				<form:errors path="item_date" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_price">정가</form:label>
				<form:input path="item_price" placeholder="상품정가를 입력하세요" autocomplete="off"/>
				<form:errors path="item_price" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_keyword1">키워드1</form:label>
				<form:input path="item_keyword1" placeholder="상품키워드를 입력하세요" autocomplete="off"/>
				<form:errors path="item_keyword1" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_keyword2">키워드2</form:label>
				<form:input path="item_keyword2" placeholder="상품키워드를 입력하세요" autocomplete="off"/>
				<form:errors path="item_keyword2" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_keyword3">키워드3</form:label>
				<form:input path="item_keyword3" placeholder="상품키워드를 입력하세요" autocomplete="off"/>
				<form:errors path="item_keyword3" cssClass="error-color"/>
			</li>
			<li>
   				<form:label path="item_cate">상품분류</form:label>
    			<form:radiobutton path="item_cate" value="1"/>신발
    			<form:radiobutton path="item_cate" value="2"/>상의
    			<form:radiobutton path="item_cate" value="3"/>하의
    			<form:radiobutton path="item_cate" value="4"/>기타
			</li>
			<li>
    			<form:label path="item_gender">분류</form:label>
    			<form:radiobutton path="item_gender" value="1"/>남성
    			<form:radiobutton path="item_gender" value="2"/>여성
    			<form:radiobutton path="item_gender" value="3"/>럭셔리
			</li>
			<li>
    			<form:label path="item_status">상품표시여부</form:label>
    			<form:radiobutton path="item_status" value="1"/>미표시
    			<form:radiobutton path="item_status" value="2"/>표시
			</li>
		</ul>
		
        <div class="align-center">
            <input type="submit" value="전송" class="default-btn">
            <input type="button" value="홈으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/item/itemAdminList.do'">
            <input type="button" value="삭제" id="delete_btn" class="default-btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('itemDelete.do?item_num=${item.item_num}');
					}
				}
			</script>
        </div>
    </form:form>
</div>
<!-- 상품등록 끝 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript">
	$(function(){
		$('#status1').click(function(){
			$('#category').css('display','none');
		});
		$('#status2').click(function(){
			$('#category').css('display','block');
		});
		$('#status3').click(function(){
			$('#category').css('display','none');
		});
		$('#status1').click(function(){
			$('#policy').css('display','none');
		});
		$('#status2').click(function(){
			$('#policy').css('display','none');
		});
		$('#status3').click(function(){
			$('#policy').css('display','block');
		});
	});
</script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<!-- 고객센터 글 수정 시작 -->
<div id="page-main">
	<h2 id="ha">글 수정</h2>
	<form:form modelAttribute="noticeVO" action="update.do" class="noticeForm">
		<form:hidden path="no_num" />
		<form:errors element="div" cssClass="error-color"/>
		<ul class="noticeSelect">
			<li>
				<form:label path="no_status" class="no_status">공지사항 선택</form:label>
				<form:radiobutton path="no_status" value="1" id="status1" class="line"/>공지사항
				<form:radiobutton path="no_status" value="2" id="status2" class="line"/>자주묻는질문
				<form:radiobutton path="no_status" value="3" id="status3" class="line"/>검수기준
				<form:errors path="no_status" cssClass="error-color"/>
			</li>
			<li id="category" class="noticeCategory">
				<form:label path="no_category" class="no_category">자주묻는질문 카테고리 선택</form:label>
				<form:radiobutton path="no_category" value="2" class="line"/>이용정책
				<form:radiobutton path="no_category" value="3" class="line"/>공통
				<form:radiobutton path="no_category" value="4" class="line"/>구매
				<form:radiobutton path="no_category" value="5" class="line"/>판매
				<form:radiobutton path="no_category" value="6" class="line"/>기타
				<form:errors path="no_category" cssClass="error-color"/>
			</li>
			<li id="policy" class="noticeCategory">
				<form:label path="no_policy" class="no_policy">검수기준 카테고리 선택</form:label>
				<form:radiobutton path="no_policy" value="1" class="line"/>신발
				<form:radiobutton path="no_policy" value="2" class="line"/>상의
				<form:radiobutton path="no_policy" value="3" class="line"/>하의
				<form:radiobutton path="no_policy" value="4" class="line"/>패션잡화
				<form:radiobutton path="no_policy" value="5" class="line"/>프리미엄 시계
				<form:radiobutton path="no_policy" value="6" class="line"/>프리미엄 가방
				<form:errors path="no_policy" cssClass="error-color"/>
			</li><p>
			<li>
				<form:label path="no_title" class="no_title">제목</form:label>
				<form:input path="no_title"/>
				<form:errors path="no_title" cssClass="error-color"/>
			</li><p>
			<li>
				<form:label path="no_content" class="no_content">내용</form:label>
				<form:textarea path="no_content"/>
				<form:errors path="no_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#no_content'),{
						           extraPlugins:[MyCustomUploadAdapterPlugin]
					             })
					             .then(editor => {
					            	 window.editor = editor;
					             })
					             .catch(error => {
					            	 console.error(error);
					             });
				</script>
			</li>
		</ul>
		<div class="btn_list">
			<form:button class="btn_auth">수정</form:button>
			<input type="button" class="btn_auth" value="취소" onclick="location.href='noticeList.do'">
		</div>
	</form:form>
</div>
<!-- 고객센터 글 수정 끝 -->
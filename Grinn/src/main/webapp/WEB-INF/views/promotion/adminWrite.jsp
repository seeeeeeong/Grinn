<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 프로모션 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<!-- include libraries (jquery,bootstrap) -->
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
<div class="page-main">
	<h2>프로모션 등록</h2>
	<form:form modelAttribute="promotionVO" action="adminWrite.do" id="promotion_register" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class="register-label">
			<li>
				<label>공개 여부</label>
				<form:radiobutton path="pro_hide" value="1" id="pro_hide1" checked="checked"/>숨김
				<form:radiobutton path="pro_hide" value="2" id="pro_hide2" checked="checked"/>공개
			</li>
			<li>
				<label>진행 유형</label>
				<form:radiobutton path="pro_ing" value="1" id="pro_ing1" checked="checked"/>예정
				<form:radiobutton path="pro_ing" value="2" id="pro_ing2" checked="checked"/>진행중
				<form:radiobutton path="pro_ing" value="3" id="pro_ing3" checked="checked"/>종료
			</li>
			<li>
				<form:label path="pro_name">제목</form:label>
				<form:input path="pro_name"/>
				<form:errors path="pro_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pro_openDate">시작일</form:label>
				<form:input path="pro_openDate" type="date"/>
				<form:errors path="pro_openDate" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="pro_cloDate">종료일</form:label>
				<form:input path="pro_cloDate" type="date"/>
				<form:errors path="pro_cloDate" cssClass="error-color"/>
			</li>
			<li>
				<label for="upload1">게시용 사진</label>
				<input type="file" name="upload1" id="upload1" accept="image/gif,image/png,image/jpeg">
				<form:errors path="pro_photo1" cssClass="error-color"/>
			</li>
			<li><b>상세내용</b></li>
			<li>
				<form:textarea path="pro_content"/>
				<form:errors path="pro_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#pro_content'),{
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
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="목록" onclick="location.href='adminList.do'">
		</div>
	</form:form>
</div>
<!-- 프로모션 등록 끝 -->
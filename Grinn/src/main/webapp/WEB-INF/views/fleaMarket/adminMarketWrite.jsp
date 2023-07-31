<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 마켓 등록 시작 -->
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
	<h2>플리마켓 등록</h2>
	<form:form modelAttribute="marketVO" action="marketWrite.do" id="register_form">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul>
			<li>
				<form:label path="market_title">제목</form:label>
				<form:input path="market_title"/>
				<form:errors path="market_title" cssClass="error-color"/>
			</li>
			<li>상세내용</li>
			<li>
				<form:textarea path="market_detail"/>
				<form:errors path="market_detail" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#content'), {
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
			<form:button>전송</form:button>
			<input type="button" value="목록" onclick="location.href='adminMarketList.do'">
		</div>
	</form:form>
</div>
<!-- 마켓 등록 끝 -->
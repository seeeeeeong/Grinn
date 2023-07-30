<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 고객센터 글 등록 시작 -->
<div>
	<h2>글 작성</h2>
	<form:form modelAttribute="noticeVO" action="write.do">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="no_title">제목</form:label>
				<form:input path="no_title"/>
				<form:errors path="no_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="no_content">내용</form:label>
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
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="취소" onclick="location.href='list.do'">
		</div>
	</form:form>
</div>
<!-- 고객센터 글 등록 끝 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	});
</script>
<!-- 고객센터 글 등록 시작 -->
<div>
	<h2>글 작성</h2>
	<form:form modelAttribute="noticeVO" action="write.do">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="no_status">공지사항 선택</form:label>
				<form:radiobutton path="no_status" value="1" id="status1"/>공지사항
				<form:radiobutton path="no_status" value="2" id="status2"/>자주묻는질문
				<form:radiobutton path="no_status" value="3" id="status3"/>검수기준
				<form:errors path="no_status" cssClass="error-color"/>
			</li>
			<li id="category" style="display:none;">
				<form:label path="no_category">자주묻는질문 카테고리 선택</form:label>
				<form:radiobutton path="no_category" value="1"/>이용정책
				<form:radiobutton path="no_category" value="2"/>공통
				<form:radiobutton path="no_category" value="3"/>구매
				<form:radiobutton path="no_category" value="4"/>판매
				<form:errors path="no_category" cssClass="error-color"/>
			</li>
			
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
			<input type="button" value="취소" onclick="location.href='noticeList.do'">
		</div>
	</form:form>
</div>
<!-- 고객센터 글 등록 끝 -->
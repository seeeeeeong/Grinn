<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 부스 등록 시작 -->
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
	<h2>부스 등록</h2>
	<form:form modelAttribute="marketVO" action="adminBoothWrite.do" id="market_register" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class=register-label>
			<li>
				<label>예약 유형</label>
				<form:radiobutton path="market_type" value="1" id="market_type1" checked="checked"/>부스 예약
			</li>
			<li>
				<form:label path="market_title">제목</form:label>
				<form:input path="market_title"/>
				<form:errors path="market_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="market_startDate">시작일</form:label>
				<form:input path="market_startDate" type="date"/>
				<form:errors path="market_startDate" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="market_endDate">종료일</form:label>
				<form:input path="market_endDate" type="date"/>
				<form:errors path="market_endDate" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="place_name">장소명</form:label>
				<form:input path="place_name"/>
				<form:errors path="place_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="booth_count">부스 수</form:label>
				<form:input path="booth_count" type="number"/>
				<form:errors path="booth_count" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="user_count">시간당 인원수</form:label>
				<form:input path="user_count" type="number"/>
				<form:errors path="user_count" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="booth_fee">부스 입점 비용</form:label>
				<form:input path="booth_fee" type="mumber"/>
				<form:errors path="booth_fee" cssClass="error-color"/>
			</li>
			<li>
				<label for="upload1">포스터</label>
				<input type="file" name="upload1" id="upload1" accept="image/gif,image/png,image/jpeg">
				<form:errors path="market_poster" cssClass="error-color"/>
			</li>
			<li>
				<label for="upload2">썸네일</label>
				<input type="file" name="upload2" id="upload2" accept="image/gif,image/png,image/jpeg">
				<form:errors path="market_thumbNail" cssClass="error-color"/>
			</li>
			<li><b>상세내용</b></li>
			<li>
				<form:textarea path="market_detail"/>
				<form:errors path="market_detail" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#market_detail'),{
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
			<input type="button" value="목록" onclick="location.href='adminBoothList.do'">
		</div>
	</form:form>
</div>
<!-- 부스 등록 끝 -->
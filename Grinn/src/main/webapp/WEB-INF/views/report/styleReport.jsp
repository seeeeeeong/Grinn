<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 게시물 신고 작성 -->
<style>
	.style-report{
		width: 600px;
		margin: 0 auto;
		border: none;
	}
	.style-info{
		display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:300px;
       	margin: 0 auto;
	}
	.except-photo{
		margin: 15px 0 10px 60px;
	}
	.date-format{
		text-align:right;
	}
	.reps{
		width:300px;
		margin:0 auto;
	}
	.rep-com{
		margin-top:10px;
		margin-bottom:10px;
	}
	#rep_com_label{
		margin-left:16px;
	}
</style>
<script type="text/javascript">

</script>
<div class="page-main">
	<div class="style-report">
		<form action="styleReport.do" method="post" class="style-report">
			<div class="style-info">
				<img src="${pageContext.request.contextPath}/image_upload/${style.st_photo1n}" width="300" height="300">
				<div class="except-photo">
					<span style="font-size:15pt;"><b>${style.mem_id}</b></span><br>
					<p style="font-size:12pt;">${style.st_phrase}</p>
					<div class="date-format">
					<c:if test="${empty style.st_mdate}">
						<span class="date-format">${style.st_regdate}</span>
					</c:if>
					<c:if test="${!empty style.st_mdate}">
						<span class="date-format">${style.st_mdate}</span>
					</c:if>
					</div>
				</div>
			</div>			
			<fieldset class="reps">
				<input type="hidden" name="st_num" value="${style.st_num}">
				<input type="hidden" name="reported_mem" value="${style.mem_num}">
				<legend>신고 사유</legend>
				<div>
					<input type="checkbox" id="rep_1" class="rep-type" name="rep_type" value="1">
					<label for="rep_1">선정적인 게시물</label>			
				</div>
				<div>
					<input type="checkbox" id="rep_2" class="rep-type" name="rep_type" value="2">
					<label for="rep_2">관련 없는 상품 태그 또는 해시태그</label>			
				</div>
				<div>
					<input type="checkbox" id="rep_3" class="rep-type" name="rep_type" value="3">
					<label for="rep_3">영리목적/홍보성 게시물</label>			
				</div>			
				<div>
					<input type="checkbox" id="rep_4" class="rep-type" name="rep_type" value="4">
					<label for="rep_4">비방성 게시물</label>			
				</div>			
			</fieldset>
			<div class="rep-com">
			<label for="rep_com" id="rep_com_label">신고 내용</label>
			<textarea rows="4" cols="72" name="rep_com" id="rep_com"></textarea>
			</div>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/detail.do?st_num=${style.st_num}'">
			</div>
		</form>
	</div>
</div>
<!-- 게시물 신고 작성 -->
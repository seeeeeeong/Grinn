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
		<form action="commentReport.do" method="post" class="style-report">
			<fieldset class="reps">
				<input type="hidden" name="com_num" value="${comment.com_num}">
				<input type="hidden" name="reported_mem" value="${comment.mem_num}">
				<legend>신고 사유</legend>
				<div>
					<input type="checkbox" id="rep_1" class="rep-type" name="rep_type" value="1">
					<label for="rep_1">선정적인 댓글</label>			
				</div>
				<div>
					<input type="checkbox" id="rep_2" class="rep-type" name="rep_type" value="2">
					<label for="rep_2">비방성 댓글</label>			
				</div>
				<div>
					<input type="checkbox" id="rep_3" class="rep-type" name="rep_type" value="3">
					<label for="rep_3">영리목적/홍보성 댓글</label>			
				</div>			
				<div>
					<input type="checkbox" id="rep_4" class="rep-type" name="rep_type" value="4">
					<label for="rep_4">기타</label>			
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
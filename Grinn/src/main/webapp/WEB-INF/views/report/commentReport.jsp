<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 게시물 신고 작성 -->
<style>
.style-title {
	margin: 0 auto;
	width: 500px;
	text-align: center;
}
.tag-title {
	margin: 0 auto;
	width: 500px;	
	font-size: 15pt;
}
    .user-profile{
    	display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:500px;
        float:left;
        margin-top:5px;
        margin-left:445px;
        margin-bottom:5px;
    }
    .posted-date{
    	font-size:10pt;
    	color:#9d9d9d;
    }
    .profile-photo{
    	width:35px;
    	height:35px;
    	border-radius:70%;
    }
	.posted-date{
    	font-size:10pt;
    	color:#9d9d9d;
    }
	.style-report{
		width: 500px;
		margin: 0 auto;
		padding:0;
		border: none;
	}
	.style-info{
		display: flex;
        flex-wrap: wrap; /* 아이템들을 여러 줄에 걸쳐 표시할 수 있도록 설정 */
        width:300px;
       	margin: 0 auto;
	}
	.except-photo{
		width:300px;
		margin:0 auto;
	}
	.except-photo p{
		margin-top:10px;
		margin-bottom:20px;
		font-size:12pt;
	}
	
	.date-format{
		text-align:right;
	}
	.reps{
		width:500px;
		margin:0 auto;
		margin-bottom:10px;
		border:none;
		padding:0;
	}
	.rep-com{
		margin:0 auto;
		margin-top:10px;
		margin-bottom:10px;
		width:500px;
	}
	#rep_com_label{
		margin-left:16px;
	}
</style>
<script type="text/javascript">
$(document).ready(function() {
    $('#submit_btn').click(function() {
        if ($(".rep-type").is(':checked')) {

        }
        else {
            alert('신고 사유를 선택해주세요.');
            return false;
        }
    })
});
</script>
<div class="page-main">
	<div class="style-title"><h2>신고하기</h2></div>
	<div class="tag-title">댓글 정보</div>
	<div class="user-profile">
		<img src="${pageContext.request.contextPath}/style/viewProfileByCom_num.do?com_num=${comment.com_num}" class="profile-photo">
		<div class="nameAndDate">
			<span class="username">${comment.mem_id}</span>
			<div class="post-date">
				<span class="posted-date"> <c:if
						test="${empty comment.formatted_mdate}">
						<small>${comment.formatted_regdate}</small>
					</c:if> <c:if test="${!empty comment.formatted_mdate}">
						<small>${comment.formatted_mdate}</small>
					</c:if>
				</span>
			</div>			
		</div>
	</div>
	<div class="style-report">
		<form action="commentReport.do" method="post" class="style-report" id="commentReportForm">
			<div class="com-info">
				<div class="except-photo">
					<p>${comment.com_comment}</p>
				</div>
			</div>
			<div class="tag-title">신고 사유</div>
			<fieldset class="reps">
				<input type="hidden" name="com_num" value="${comment.com_num}">
				<input type="hidden" name="reported_mem" value="${comment.mem_num}">
				<div>
					<input type="radio" id="rep_1" class="rep-type" name="rep_type" value="1">
					<label for="rep_1">선정적인 댓글</label>			
				</div>
				<div>
					<input type="radio" id="rep_2" class="rep-type" name="rep_type" value="2">
					<label for="rep_2">비방성 댓글</label>			
				</div>
				<div>
					<input type="radio" id="rep_3" class="rep-type" name="rep_type" value="3">
					<label for="rep_3">영리목적/홍보성 댓글</label>			
				</div>			
				<div>
					<input type="radio" id="rep_4" class="rep-type" name="rep_type" value="4">
					<label for="rep_4">기타</label>			
				</div>			
			</fieldset>
			<div class="tag-title">신고 내용</div>
			<div class="rep-com">
			<textarea rows="4" cols="50" name="rep_com" id="rep_com" placeholder="구체적인 신고 사유를 작성해주세요."></textarea>
			</div>
			<div class="align-center">
				<input type="submit" value="등록" id="submit_btn">
				<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/style/list.do'">
			</div>
		</form>
	</div>
</div>
<!-- 게시물 신고 작성 -->
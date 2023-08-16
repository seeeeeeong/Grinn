<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- (관리자) 댓글 신고 상세 -->
<style>
	.report-title{
	    margin: 50px 20px 0 20px;
	}
	.report-box{
    		margin: 0 20px 20px 20px;
    		box-shadow: 2px 2px 4px 2px rgba(0, 0, 0, 0.1);
    		padding: 0 20px 0 10px;
	}
	.report-info{
		    margin: 0 20px 20px 20px;
		    padding: 0 20px 0 10px;
	}
	.report-detail{
		    width: 70%;
		    margin: 0 auto;
		    padding: 10px;
		    border:none;
	}
	.report-type{
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 15px;
	}
	.report-com{
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 15px;
	}
	.report-com dt{
		width:20%;
	}
	.report-com dd{
		margin: 0 auto;
	}
	.report-com p{
		margin: 0 auto;
	}
	.report-report{
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 15px;	
	}

</style>
<script type="text/javascript">
$(document).ready(function() {
    $('#submit_btn').click(function() {
        if ($(".rep-hide").is(':checked')) {
			alert('신고 처리되었습니다.');
        }
        else {
            alert('댓글 공개 여부를 선택해주세요.');
            return false;
        }
    })
});
</script>
<div class="page-main">
	<div class="report-title">
		<h2>댓글 신고</h2>
	</div>
	<div class="report-box">
		<div class="report-info">
			<div class="report-detail">
				<dl class="report-type">
					<dt>신고사유</dt>
					<dd>
						<b>
							<c:if test="${com.rep_type == 1}">선정적인 댓글</c:if>
							<c:if test="${com.rep_type == 2}">비방성 댓글</c:if>
							<c:if test="${com.rep_type == 3}">영리목적/홍보성</c:if>
							<c:if test="${com.rep_type == 4}">기타</c:if>
						</b>
					</dd>
				</dl>
				<dl class="report-report">
					<dt>신고자</dt>
					<dd><b>${com.report_id}</b></dd>
				</dl>
				<dl class="report-report">
					<dt>피신고자</dt>
					<dd><b>${com.reported_id}</b></dd>
				</dl>				
				<dl class="report-com">
					<dt>추가내용</dt>
					<dd>
						<p>
							<b>${com.rep_com}</b>
						</p>
					</dd>
				</dl>
			</div>
		</div>
	</div>
	<div class="form-handleReport">
		<form action="comReportDetail.do" method="post">
			<input type="hidden" value="${com.rcom_num}" name="rcom_num">
			<fieldset class="reps">
				<span>
					<input type="radio" class="rep-hide" name="rep_hide" value="1" <c:if test="${com.rep_hide == 1}">checked</c:if>>
					공개 처리
				</span>
				<span>
					<input type="radio" class="rep-hide" name="rep_hide" value="2" <c:if test="${com.rep_hide == 2}">checked</c:if>>
					비공개 처리
				</span>
			</fieldset>
			<div class="align-center">
				<input type="submit" value="등록" id="submit_btn">
				<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/report/comReportList.do'">
			</div>			
		</form>
	</div>
</div>
<!-- (관리자) 댓글 신고 상세 -->
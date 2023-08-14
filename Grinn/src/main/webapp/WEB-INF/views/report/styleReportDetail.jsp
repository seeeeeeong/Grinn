<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- (관리자) 스타일 신고 상세 -->
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

	dd{
			
	}
</style>
<div class="page-main">
	<div class="report-title">
		<h2>스타일 신고</h2>
	</div>
	<div class="report-box">
		<div class="report-info">
			<div class="report-detail">
				<dl class="report-type">
					<dt>신고사유</dt>
					<dd>
						<b>
							<c:if test="${style.rep_type == 1}">선정적인 게시물</c:if>
							<c:if test="${style.rep_type == 2}">관련 없는 태그</c:if>
							<c:if test="${style.rep_type == 3}">영리목적/홍보성</c:if>
							<c:if test="${style.rep_type == 4}">비방성 게시물</c:if>
						</b>
					</dd>
				</dl>
				<dl class="report-report">
					<dt>신고자</dt>
					<dd><b>${style.report_id}</b></dd>
				</dl>
				<dl class="report-report">
					<dt>피신고자</dt>
					<dd><b>${style.reported_id}</b></dd>
				</dl>				
				<dl class="report-com">
					<dt>추가내용</dt>
					<dd>
						<p>
							<b>${style.rep_com}</b>
						</p>
					</dd>
				</dl>
			</div>
		</div>
	</div>
</div>
<!-- (관리자) 스타일 신고 상세 -->
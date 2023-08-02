<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<div class="side-bar">
<h3>관리자 페이지</h3>
	<ul>
		<li>
			<h4>회원 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/member/admin_list.do">회원 목록</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/penalty/admin_list.do">회원 패널티 관리</a>
				</li>
			</ul>
		</li>
		<li>
			<h4>상품 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/item/admin_list.do">상품 목록</a>
				</li>
			</ul>
		</li>
		<li>
			<h4>배송 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/trade/admin_list.do">거래 상태 확인</a>
				</li>
			</ul>
		</li>
		<li>
			<h4>공지 및 신고 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/notice/admin_list.do">공지사항 목록</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/report/admin_list.do">게시물 신고 목록</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/report/admin_list.do">댓글 신고 목록</a>
				</li>
			</ul>
		</li>
		<li>
			<h4>플리마켓 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/fleamarket/admin_list.do">플리마켓 목록</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/fleamarket/admin_resList.do">플리마켓 예약 내역</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/booth/admin_list.do">부스 목록</a>
				</li>
				<li>
					<a href = "${pageContext.request.contextPath}/booth/admin_resList.do">부스 예약 내역</a>
				</li>
			</ul>
		</li>
		<li>
			<h4>프로모션 관리</h4>
			<ul>
				<li>
					<a href = "${pageContext.request.contextPath}/promotion/admin_list.do">프로모션 목록</a>
				</li>
			</ul>
		</li>
	</ul>
</div>
<!-- Admin 메뉴 끝 -->






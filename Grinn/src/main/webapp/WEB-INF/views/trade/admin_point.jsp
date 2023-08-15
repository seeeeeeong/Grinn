<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/admin_point.css">
<script type="text/javascript">

</script>
<div class="page_body">
	<div class="page-main">
		<h2 id="ha">[관리자] 포인트 정보</h2>
		<div class="trade-content">
			<div class="trade-content-detail">
				<dl>
					<dt>포인트</dt>
					<dd><fmt:formatNumber value="${point}"/></dd>
				</dl>
			</div>
		</div>
	</div>
</div>









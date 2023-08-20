<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/user_point.css">

<script type="text/javascript">
	$(function(){
		$('#add_point').click(function(){
			$('.input-point').css('display','block');
			$(this).hide();
		});
		
		$('.input-point-form input[type="text"]').keyup(function(){
			let number = $(this).val().replace(/[^0-9]/g,'');
			number = Number(number);
			
			number = number.toLocaleString('ko-KR');
			
			$(this).val(number);
			
			if($(this).val().replaceAll(',','') > 5000000){
				alert('최대 5,000,000 포인트까지 충전할 수 있습니다.');
				$(this).val('').focus();
			}
		});
		$('.input-point-form input[type="text"]').change(function(){
			let number = $(this).val().replaceAll(',','');
			number = Math.ceil(number / 10) * 10;
			$(this).val(number.toLocaleString('ko-KR'));
			$('#point').val(number);
		});
	});
</script>

<div class="page-main">
	<h2 class="bordered-heading" style="font-size: 24px;">포인트</h2>
	<div class="point-content">
		<div class="point-content-detail">
			<dl>
				<dt>포인트</dt>
				<dd><fmt:formatNumber value="${member.mem_point}"/>원</dd>
			</dl>
		</div>
		<div class="btn-point">
			<a id="add_point">충전하기</a>
		</div>
		<div class="input-point" style="display:none;">
			<form action="addUserPoint.do" class="input-point-form" method="post">
				<input type="text" placeholder="충전 금액을 입력해 주세요.">
				<input type="hidden" name="point" id="point">	
				<input type="submit" value="충전">
			</form>
``		</div>
	</div>
</div>
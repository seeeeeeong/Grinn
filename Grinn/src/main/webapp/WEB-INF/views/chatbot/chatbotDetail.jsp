<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_yeom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/style.fav.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
	//댓글 팝업
  	const btn = document.getElementById('popupBtn');
	const modal = document.getElementById('modalWrap');
	const closeBtn = document.getElementById('closeBtn');
	
	btn.onclick = function() {
	  modal.style.display = 'block';
	  $(".fixed").css({
		    "position":"static"
	  });
	  $("#main_body").css({
		  "padding": "0 0 30px 0"
	  });
	}
	closeBtn.onclick = function() {
	  modal.style.display = 'none';
	  $(".fixed").css({
		    "position":"fixed"
	  });
	  $("#main_body").css({
		  "padding": "144px 0 30px 0"
	  });
	}
	
	  const optionBtn = document.getElementById('more-btn');
	  const optionModal = document.getElementById('optionWrap');
	  const optionCloseBtn = document.getElementById('closeOption');

	  optionBtn.onclick = function() {
		optionModal.style.display = 'block';
		$(".fixed").css({
		    "position":"static"
	  	});
	  	$("#main_body").css({
		  "padding": "0 0 30px 0"
	  	});
	  }
	  optionCloseBtn.onclick = function() {
		optionModal.style.display = 'none';
		  $(".fixed").css({
			    "position":"fixed"
		  });
		  $("#main_body").css({
			  "padding": "144px 0 30px 0"
		  });
	  }

	  window.onclick = function(event) {
	    if (event.target == optionModal) {
	    	optionModal.style.display = "none";
		  	  $(".fixed").css({
				    "position":"fixed"
			  });
			  $("#main_body").css({
				  "padding": "144px 0 30px 0"
			  });
	    }
	  }
	 
  });
</script>
<!-- 챗봇 상세 -->
<div class="page-main" id="styleDetail">
	안녕하세요
</div>
<div class="optionWrap" style="display:none;">
	<div class="optionContent">
		<div class="optionBody">
		<span id="closeOption">&times;</span> 
			모달테스트
		</div>
	</div>
</div>
<!-- 챗봇 상세 -->
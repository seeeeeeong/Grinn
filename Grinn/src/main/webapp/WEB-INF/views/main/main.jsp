<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sys/main.css">
<!-- 내용 시작 -->
<div class="page-main">
	main 화면입니다.
	<div class = "container">
		<div style = "display:none;"></div>
		<div class = "home">
			<div class = "home_card_list">
				<div class = "banner_slide">
					<div class = "flicking-viewport">
						<div class = "flicking-camera">
							<!-- banner -->
							<div class = "banner">
								<div class = "banner_item">
									<div class = "item_inner">
										<div class = "img-box">
											<img alt = "banner" class = "banner_img">
										</div>
									</div>
								</div>
							</div>
							<!-- banner -->
						</div>
						<span class = "arrow-prev"></span>
						<span class = "arrow-next"></span>
						<div class = "pagination">
							<span class = "bullet"></span>
							<span class = "bullet"></span>
							<span class = "bullet"></span>
						</div>
					</div>
				</div>
				<div class = "collection">
					<div class = "collection_items">
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">그린드로우</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">7월 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">SUMMER 이벤트</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">신상품</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">남성 추천</p>
						</div>
						<div class = "collection_item">
							<div class = "item_img"></div>
							<p class = "item_title">여성 추천</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="w3-container">
	  <h2>W3.CSS Modal</h2>
	  <p>In this example we demonstrate how to close the modal by clicking outside of the modal box.</p>
	
	  <button onclick="document.getElementById('id01').style.display='block'" class="w3-button w3-black">Open Modal</button>
	
	  <div id="id01" class="w3-modal">
	    <div class="w3-modal-content w3-card-4">
	      <header class="w3-container w3-teal"> 
	        <span onclick="document.getElementById('id01').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h2>Modal Header</h2>
	      </header>
	      <div class="w3-container">
	        <p>You have two options to close this modal:</p>
	        <p>Click on the "x" or click anywhere outside of the modal!</p>
	      </div>
	      <footer class="w3-container w3-teal">
	        <p>Modal Footer</p>
	      </footer>
	    </div>
	  </div>
	</div>
	
	<script>
	// Get the modal
	var modal = document.getElementById('id01');
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
	</script>
	
	
</div>
<!-- 내용 끝 -->
















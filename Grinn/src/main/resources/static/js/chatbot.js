$(function(){
	const btn_chatbot = document.getElementById('btn_chatbot');
	const modal = document.getElementById('modalWrap');
	const closeBtn = document.getElementById('closeBtn');
	
	btn_chatbot.onclick = function() {
	  modal.style.display = 'block';
	}
	closeBtn.onclick = function() {
	  modal.style.display = 'none';
	}
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
	
	/* 챗봇메세지 */
	let message_socket;
	let member_list = []; //채팅 회원 저장 -> 로그인한 회원과 챗봇
	
	
});









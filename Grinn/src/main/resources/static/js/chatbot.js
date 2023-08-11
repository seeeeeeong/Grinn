$(function(){
	const btn_talk = document.getElementById('btn_talk');
	const modal = document.getElementById('modalWrap');
	const closeBtn = document.getElementById('closeBtn');
	
	btn_talk.onclick = function() {
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
});
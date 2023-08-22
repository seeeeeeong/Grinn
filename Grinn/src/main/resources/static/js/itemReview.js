$(function(){

	//리뷰 사진 클릭시 사진 확대
	const modal = document.querySelector(".modal");
	const divImg = document.querySelector(".divImg");
	const img = document.querySelector(".reviewImg");
	const modal_img = document.querySelector(".modal_content");
	const span = document.querySelector(".close");
	if(divImg){
		divImg.addEventListener('click', () => {
			modalDisplay("block");
			modal_img.src = img.src;
		});
		span.addEventListener('click', () => {
			modalDisplay("none");
		});
		modal.addEventListener('click', () => {
			modalDisplay("none");
		});
		function modalDisplay(text) {
			modal.style.display = text;
		}
	}
});
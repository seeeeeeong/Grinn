function showDiv(element) {
	var tag = document.getElementsByClassName("polling-item");
	
	for(var i=0; i<tag.length; i++) {
		// className이 box인 요소(poll1Box, poll2Box, poll3Box, poll4Box가 하나의 배열로 생성)를 찾아
		// tag라는 변수에 대입. 이것을 반복문으로 돌려서 tag의 길이만큼 4번 반복.
		// 전달받은 버튼 요소 객체의 아이디값 중에 Box라는 문자열을 붙였을 때의 값이 
		// tag의 i번째 아이디와 동일하다면 
		// i번째 태그 스타일을 display 속성에 접근해서 block으로 변경.
		// 그렇지 않으면 none으로 변경
		if(element.id + "Box" == tag[i].id)
			tag[i].style.display = "block";
		else
			tag[i].style.display = "none";
	}
}

document.addEventListener("DOMContentLoaded", function () {
    const pollingItems = document.querySelectorAll(".polling-item");

    pollingItems.forEach((item) => {
      item.addEventListener("click", function () {
        // 라디오 버튼을 클릭하는 동작 구현
        const radioButton = item.querySelector("input[type='radio']");
        if (radioButton) {
          radioButton.checked = true;
          // 투표 결과에 대한 동작을 구현하는 곳
          // 투표 결과를 표시하는 코드를 추가..?
          output = "<<polling>>";
       }
     });
   });
 });
 
 document.addEventListener("DOMContentLoaded", function () {
    const pollingItems = document.querySelectorAll(".polling-item");

    pollingItems.forEach((item) => {
      item.addEventListener("click", function () {
        // 클래스 토글을 사용하여 선택된 상태를 변경합니다.
        this.classList.toggle("selected");

        // 선택된 버튼을 제외한 나머지 버튼의 클래스를 초기화합니다.
        pollingItems.forEach((otherItem) => {
          if (otherItem !== this) {
            otherItem.classList.remove("selected");
          }
        });
      });
    });
  });
 

 
function showResult() {
    var resultContainer = document.getElementById("result");
    var radios = document.getElementsByName("polling-option");

    for (var i = 0; i < radios.length; i++) {
        if (radios[i].checked) {
            resultContainer.innerHTML = "투표수: " + radios[i].value;
            break;
        }
    }   
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
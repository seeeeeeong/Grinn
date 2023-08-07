// DOM 요소 가져오기
var gnbItems = document.querySelectorAll('.gnb_item');

// gnb_item 클릭 이벤트 처리
gnbItems.forEach(function(item) {
    item.addEventListener('click', function() {
        // 기존 active 클래스 제거
        gnbItems.forEach(function(gnb) {
            gnb.classList.remove('active');
        });

        // 현재 클릭한 gnb_item에 active 클래스 추가
        item.classList.add('active');
    });
});
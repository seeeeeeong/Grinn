# GRINN

경매 시스템을 도입한 웹 쇼핑몰 프로그램

"Kream" 웹 사이트를 벤치마킹하여 제작한 웹 프로젝트입니다.
경매 시스템, 스타일 게시판, 플리마켓 예약, 상품 관리, 회원 관리, 챗봇, 채팅 시스템, 투표 시스템 기능이 존재합니다.



# Description

- 개발 기간: 2023.07.10 ~ 2020.08.25

- 참여 인원: Frontend & Backend 7명

- 사용 기술

  - Java, HTML, CSS, Javascript, SQL, JSP
  - Oracle
  - Spring Framework, Github, Notion, Google Drive, SQL Developer
  - Apache Tomcat v9.0

- 담당 구현 파트

  - 프로젝트 개발환경 구축, 설계 참여

  - 마이페이지 구현 (회원정보, 구매 및 판매 내역 조회, 좋아요한 게시물 및 관심 상품 조회, 회원정보 수정)

  - 스타일 페이지 구현(팔로우 및 언팔로우 기능 구현, 작성한 게시물 조회, 팔로워 및 팔로잉 조회) 

  - 알림 페이지 구현(작성한 게시물 좋아요 및 댓글, 팔로워 확인, 거래 상태 조회)





# 담당 구현 파트 View
## mypage

- **마이페이지**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage2.png?raw=true"/></p>

- myPage(HttpSession session, Model model)
  - 로그인 상태 확인 후 사용자 정보, 구매 및 판매, 관심 상품과 관련된 정보를 모델에 추가하여 마이페이지 표시
------  
- **관심 상품** 

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage3.png?raw=true"/></p>

- favoriteItemsPage(HttpSession session, Model model, @RequestParam(name = "pageNum", defaultValue = "1") int pageNum)
    - 로그인 상태 확인 후, 관심 상품 목록을 페이징하여 모델에 추가하고, 관심 상품 페이지 표시

------  
- **좋아요**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage4.png?raw=true"/></p>


- getFav

  - /user.getFav.do 로 들어오는 GET 요청 처리
  - 클라이언트에서 스타일 관련 정보를 받아온다.
  - 로그인 상태를 확인 후, 로그인이 안 된 경우 "noFav" 상태를 반환하고, 로그인한 경우 해당 스타일의 좋아요 상태와 좋아요 개수를 반환한다.
 
- writeFav

  - /user/writeFav.do로 들어오는 POST 요청 처리
  - 클라이언트에서 스타일 좋아요 등록 또는 삭제 처리
  - 로그인 상태를 확인 후, 로그인이 안 된 경우 "logout" 상태를 반환하고, 로그인한 경우 해당 스타일의 좋아요 상태와 좋아요 개수를 반환한다.

- JavaScript (jQuery)

  - 클라이언트에서 jQuery를 사용하여 서버로 요청을 보내고 응답을 받아 처리
  - selectFav 함수는 스타일의 좋아요 상태와 개수를 서버로부터 받아와 화면에 표시
  - displayFav 함수는 받아온 정보에 따라 좋아요 아이콘과 개수를 화면에 업데이트
  - 초기 데이터는 페이지 로딩시 selectFav를 호출하여 화면에 표시

------  
- **회원정보 수정**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage5.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage6.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage7.png?raw=true"/></p>

------  
## userstyle

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/userstyle1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/userstyle2.png?raw=true"/></p>


- @GetMapping("/user/getFollowStatus)
  - /user/getFollowStatus로 들어오는 GET 요청을 처리
- @PostMapping("/user/follow")
  - /user/follow로 들어오는 POST 요청 처리
- userStyleService.isFollowing(toUser, fromUser)
  - isFollowing 메서드를 사용하여 현재 사용자기 대상 사용자를 팔로우 하고 있는지 확인
- userStyleService.deleteFollow(toUser, fromUser)
  - 이미 팔로우 한 경우, deleteFollow 메서드를 호출하여 팔로우 취소
- userStyleService.insertFollow(toUser, fromUser)
  - 팔로우 하지 않은 경우, insertFollow 메서드를 호출하여 팔로우를 추가    

------  
## alert

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/alert1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/alert2.png?raw=true"/></p>

- /user/alert.do
- 로그인한 경우, 다음과 같은 알림 정보를 검색하여 모델에 추가
  - commentList: 새 댓글 알림 목록
  - favList: 새 좋아요 알림 목록
  - followInfo: 팔로우한 사용자 목록
  - purchaseList: 구매 알림 목록
  - saleList: 사용자의 판매 알림 목록


------
- # 회고

- 개선사항
  - 예외 처리, 현재 네트워크 오류에 대한 알림만 존재한다.
  - RESTful API의 URL가 명확하게 설계되지 못 한 부분이 있다, HTTP 상태 코드를 사용하여 요청의 결과를 전달하지 않았다.
  - 단위 테스트를 통해 예상치 못한 문제를 방지하지 않았다.
  - API 문서화의 필요성을 느꼈다.
  
- 느낀점
  - 정해진 틀에 맞추어 프로젝트를 진행하다 보니 어떤 방법이 효율적인지 보다는 구현을 하는것에만 초점을 맞추었던 것 같다.
    JSP가 아닌 Thymeleaf같은 뷰 템플릿 엔진을 사용했으면?, MyBatis가 아닌 JAP나 QueryDsl 같은 데이터 접근 기술을 사용했으면? 이라는 생각이 들었다.
  - 이 경험을 바탕으로 부족한 부분에 대한 학습의 필요성을 알게 되었고 어떤 방향으로 프로젝트를 진행해야 할지에 대해 고민할 수 있었다.
    올바른 API 설계에 대한 공부의 필요성을 느꼈고 기능 프로젝트 시연 과정에서 발생하는 오류를 보며 구현 만큼 중요한 것이 테스트라는 생각이 들었다.

------
- #### 요구사항 정의서

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/req1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/req2.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/req3.png?raw=true"/></p>



------
- #### ERD

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/erd.png?raw=true"/></p>




  
------ 
- #### Usecase Diagram

    <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/usecase.png?raw=true"/></p>





------
- #### 일정계획 (WBS)

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/wbs1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/wbs2.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/8d8e707ce3b86526fe9388e9b23f37236220b9e1/Grinn/src/main/webapp/file/wbs3.png?raw=true"/></p>




------

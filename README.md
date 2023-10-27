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



# Views

## mypage

- **마이페이지**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage2.png?raw=true"/></p>




  
- **관심 상품** 

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage3.png?raw=true"/></p>




  
- **좋아요**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage4.png?raw=true"/></p>




  
- **회원정보 수정**

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage5.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage6.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/mypage7.png?raw=true"/></p>




  
## userstyle

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/userstyle1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/userstyle2.png?raw=true"/></p>




  
## alert

  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/alert1.png?raw=true"/></p>
  <p align="center"><img src="https://github.com/seeeeeeong/Grinn/blob/bb9ffe3d06898e3f2259b4874d05e98f597b6532/Grinn/src/main/webapp/file/alert2.png?raw=true"/></p>



------



- #### 요구사항 정의서

  
 

------

- #### ERD

  

- #### Class Diagram

  <p align="center"><img src="https://github.com/77kkyu/Style_Is_You/blob/master/src/main/webapp/file/%EB%94%94%ED%85%8C%EC%9D%BC2.png?raw=true"/></p>

  - **상품 문의 기능**
    1. JsonView를 설정해 Json형태로 데이터를 가져와 Ajax 통신으로 리스트 구성.
    2. Toggle을 사용하여 제목을 클릭 시 보이기, 숨기기 기능 구성.
  - **Review 기능**
    1. JsonView를 설정해 Json형태로 데이터를 가져와 Ajax 통신으로 리스트 구성.
    2. Toggle을 사용하여 제목을 클릭 시 보이기, 숨기기 기능 구성. 
    3. 리뷰를 등록할 때 CkEditor를 사용하여 DataBase에 저장된 이미지와 내용 출력.
    4. Ajax 및 Jquery로 페이징 구성.

 



- # Sequence Diagram

 
- # Usecase Diagram


- # 일정계획 (WBS)


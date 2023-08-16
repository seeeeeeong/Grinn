<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 일자 선택 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/market.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/booking.js"></script>
<script type="text/javascript">
$(function(){
	var dateFormat = "yy-mm-dd",
    from = $( "#from-to" )
      .datepicker({
        showMonthAfterYear: true, //연도,달 순서로 지정
		  yearSuffix: "년",
        changeMonth: true,//달 변경 지정
        dateFormat:"yy-mm-dd",//날짜 포맷
        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토" ],//요일 이름 지정
        monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],//월 이름 지정
        minDate:new Date('${market.market_startDate}'), //오늘 이전 날짜를 선택할 수 없음
        maxDate:new Date('${market.market_endDate}')
      })
      .on( "change", function() {
        to.datepicker( "option", "minDate", getDate(this) );//종료일의 minDate 지정
      }),
    to = $( "#from-to2" ).datepicker({
   	showMonthAfterYear: true,  
		yearSuffix: "년",
      changeMonth: true,
      dateFormat:"yy-mm-dd",
      dayNamesMin: ["일", "월", "화", "수", "목", "금", "토" ],
      monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
      minDate:'+1D', //내일부터 선택가능, 지정형식 예(+1D +1M +1Y)
      maxDate:new Date('${market.market_endDate}')
    })
    .on( "change", function() {
      from.datepicker( "option", "maxDate", getDate(this) );//시작일의 maxDate 지정
    });

  function getDate(element) {
    var date;
    try {
      date = $.datepicker.parseDate( dateFormat, element.value );
      if(element.id == 'from-to'){
      date.setDate(date.getDate()+1);//종료일은 시작보다 하루 이후부터 지정할 수 있도록 설정
      }else{
       date.setDate(date.getDate()-1);//시작일은 종료일보다 하루 전부터 지정할 수 있도록 설정
      }
    } catch( error ) {
      date = null;
    }
    return date;
  }
});
</script>
<style>
/*input 롤오버 시 커서 표시*/
.hasDatepicker{cursor: pointer;}
</style>

<div class="page-main">
	<h2>예약 날짜 선택</h2>
	<div>
	</div>
	<form:form id="select_date" action="booking.do" method="post" modelAttribute="bookingVO">
		<input type="hidden" name="market_num" value="${market.market_num}"/>
		<input type="hidden" name="market_startDate" value="${market.market_startDate}"/>
		<input type="hidden" name="market_endDate" value="${market.market_endDate}"/>
		<input type="hidden" name="booth_count" value="${market.booth_count}"/>
		<input type="hidden" name="booth_fee" value="${market.booth_fee}"/>
		<form:errors element="div" cssClass="error-color"></form:errors>
		<ul class="date-form">
			<li class="book-flea-title">${market.market_title}</li>
			<li class="book-flea-date align-right">${market.market_startDate} ~ ${market.market_endDate}</li>
			<li class="choose-date book-flea-detail">
				<label for="from-to"><b>예약 일정</b></label>
				<form:input path="book_date1" type="text" id="from-to" autocomplete="off" placeholder="희망 시작 일자"/> ~ <form:input path="book_date2" type="text" id="from-to2" autocomplete="off" placeholder="희망 종료 일자"/>
			</li>
			<li class="book-flea-detail">
				<form:label path="get_count"><b>예약 부스 수</b></form:label>
				<form:input type="number" path="get_count" min="0" max="1" id="get_count"/>
			</li>
			<li class="book-flea-detail">
				<label><b>남은 부스 수</b></label>
				${market.booth_count}개
			</li>
			<li class="book-flea-detail">
				<label for="booth_fee"><b>비용</b></label>
				<c:if test="${market.booth_fee == 0}"><span>무료</span></c:if>
				<c:if test="${market.booth_fee > 0}">
				<fmt:formatNumber value="${market.booth_fee}"/>원
				</c:if>
			</li>
			<li class="book-total align-right">
				<span id="booth_total_txt">총 금액 0원</span>
			</li>
		</ul>
		<div class="btn-area align-right">
			<input type="button" value="목록" class="book-btn1" onclick="location.href='boothList.do'">
			<form:button class="book-btn2" id="book_btn">예약</form:button>
		</div>
	</form:form>
</div>

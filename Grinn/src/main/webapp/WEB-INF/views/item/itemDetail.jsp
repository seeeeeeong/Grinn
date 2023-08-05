<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/itemWrite.js"></script>
<!-- 게시글 상세 시작 -->
<div class="page-main">
	<c:if test="${item.item_status == 1}">
		<div class="result-display">
			<div class="align-center">
				본 상품은 판매 중지되었습니다.
				<input type="button" value="판매상품보기" onclick="location.href='itemList.do'">
			</div>
		</div>
	</c:if>
	<c:if test="${item.item_status == 2}">
		<div class="itemDetailPage">
			<!-- 사진 -->
			<div class="left">
				<img
					src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}"
					width="100%" height="400">
			</div>
			<div class="divider"></div>
			<div class="right">
				<!-- 브랜드, 이름, 설명, 사이즈, 최근 거래가, 구매/판매버튼, 관심상품 -->
				<div class="itemInfo">
					<div class="title_box">
						<p class="a">${item.item_brand}</p>
						<p class="b">${item.item_name}</p>
						<p class="c">${item.item_detail}</p>
					</div>
					<div class="details">
						<div>사이즈</div>
					</div>
					<div class="details">
						<div>최근 거래가</div>
					</div>
					<div>
						<div class="buttons">
							<button class="a"
								onclick="location.href='${pageContext.request.contextPath}/purchase/selectSize.do?item_num=${item.item_num}'">구매</button>
							<button class="b"
								onclick="location.href='${pageContext.request.contextPath}/sale/selectSize.do?item_num=${item.item_num}'">판매</button>
						</div>
						<br> <span class="output_fav" data-num="${item.item_num}"
							id="output-fav"> <span> <img class="output_fav"
								data-num="${item.item_num}"
								src="${pageContext.request.contextPath}/images/save_blank.png"
								width="15" height="15"> <span>관심상품</span> <span
								class="output_fcount" data-num="${item.item_num}"></span>
						</span>
						</span>
					</div>
				</div>
				<div>
					<h3>상품정보</h3>
					<div class="detail_wrap">
						<dl>
							<div class="detail_wrap_one">
								<dt>모델번호</dt>
								<dd>${item.item_model}</dd>
							</div>
							<div class="detail_wrap_two">
								<dt>출시일</dt>
								<dd>${item.item_date}</dd>
							</div>
							<div class="detail_wrap_two">
								<dt>발매가</dt>
								<dd>
									<fmt:formatNumber>${item.item_price}</fmt:formatNumber>
									원
								</dd>
							</div>
						</dl>
					</div>
				</div>
				<div>
					<h3>추가 혜택</h3>
					<div class="detail_wrap2">
						<div class="addbnf">
							<p>
								<b>포인트</b>
							</p>
							<p>
								구매 후 배송완료 시 수수료의 최대 100% 적립<br> 판매 후 정산완료 시 수수료의 50% 적립<br>
								계좌 간편결제 시 1% 적립
							</p>
						</div>
						<div class="addbnf">
							<p>
								<b>결제</b>
							</p>
							<p>
								우리카드 15만원 이상 결제 시 즉시할인 5%<br> 카카오페이 최대 4만원 즉시할인<br>
								KB국민카드 18개월 특별 할부 혜택<br> 토스 매일 오전 9시 선착순 1만원 즉시할인
							</p>
						</div>
					</div>
				</div>
				<div class="detail_wrap2">
					<h3>배송 정보</h3>
					<div class="deliveryinfo">
						<img src="${pageContext.request.contextPath}/images/thunder.png"
							width="40" height="40">
						<div>
							<b>빠른배송  5,000원</b> <br> 지금 결제시 3일 뒤 도착 예정
						</div>
					</div>
					<div class="deliveryinfo">
						<img src="${pageContext.request.contextPath}/images/postbox.png"
							width="40" height="40">
						<div>
							<b>일반배송  3,000원</b><br> 검수 후 배송 • 5-7일 내 도착 예정
						</div>
					</div>
				</div>
				<div>
					<h3>
						<b>구매 전 확인해주세요!</b>
					</h3>
					<button class="accordion">배송 기간 안내</button>
					<div class="panel">
						<p>
							<b>GRINN은 최대한 빠르게 모든 상품을 배송하기 위해 노력하고 있습니다. 배송 시간은 판매자가 검수를
								위하여 상품을 검수센터로 보내는 속도에 따라 차이가 있습니다.</b><br>
							<br> [빠른배송 구매]<br> - 판매자가 보관 신청한 상품 중<br> 검수에 합격한
							상품을 GRINN의 전용 창고에 보관합니다. 보관 상품에 한하여 바로 구매와 95점 구매가 가능합니다.<br>
							- 오늘(오후 11:59까지) 결제하면 내일 바로 출고되어 빠른 배송이 가능합니다. (연휴 및 공휴일, 천재지변,
							택배사 사유 등 예외적으로 출고일이 변경될 수 있습니다.<br>
							<br> [일반 구매]<br> - 거래가 체결된 시점부터 48시간(일요일•공휴일 제외) 내에
							판매자가 상품을 발송해야 하며, 통상적으로 발송 후 1-2일 내에 GRINN 검수센터에 도착합니다.<br>
							- 검수센터에 도착한 상품은 입고 완료 후 3영업일 이내에 검수를 진행합니다. 검수 합격시 배송을 준비합니다. *
							상품 종류 및 상태에 따라 검수 소요 시간은 상이할 수 있으며, 구매의사 확인에 해당할 경우 구매자와 상담 진행으로
							인해 지연이 발생할 수 있습니다.<br> - 검수센터 출고는 매 영업일에 진행하고 있으며, 출고 마감시간은
							오후 5시입니다. 출고 마감시간 이후 검수 완료건은 운송장번호는 입력되지만 다음 영업일에 출고됩니다.<br>
						</p>
					</div>
					<button class="accordion">검수 안내</button>
					<div class="panel">
						<p>
							<b>판매자의 상품이 검수센터에 도착하면 전담 검수팀이 철저한 분석과 검사로 정가품 확인을 진행합니다.</b><br>
							- 검수센터에서는 정가품 여부를 확인하기 위하여, 지속적으로 데이터를 쌓고 분석하여 기록하고 있습니다.<br>
							- 업계 전문가로 구성된 검수팀은 박스와 상품의 라벨에서 바느질, 접착, 소재 등 모든 것을 검수합니다.<br>
							<br> <b>검수 결과는 불합격•검수 보류•합격의 세가지 상태로 결과가 변경됩니다.</b><br>
							* 검수 합격: GRINN 검수택(Tag)이 부착되어 배송을 준비함<br> * 검수 보류: 앱에서 사진으로
							상품의 상태 확인 및 구매 여부를 선택. (24시간 이후 자동 검수 합격)<br> * 검수 불합격: 즉시
							거래가 취소되고 구매하신 금액을 환불 처리함.(환불 수단은 결제 수단과 동일)<br>
						</p>
					</div>
					<button class="accordion">구매 환불/취소/교환 안내</button>
					<div class="panel">
						<p>
							<b>GRINN은 익명 거래를 기반으로 판매자가 판매하는 상품을 구매자가 실시간으로 구매하여 거래를
								체결합니다.</b><br> - 체결 후 15분 이내에 구매 결정 또는 구매 거부를 선택할 수 있습니다. 구매 결정
							이후에는 취소/교환/반품이 불가능합니다.<br> - 상품 수령 후, 이상이 있는 경우 GRINN 고객센터로
							문의해주시기 바랍니다.
						</p>
					</div>
				</div>
				<div class="detail_wrap2">
					<h3></h3>
					<div class="deliveryinfo">
						<img src="${pageContext.request.contextPath}/images/item_3x.png"
							width="40" height="40">
						<div>
							<b>100% 정품 보증</b><br> GRINN에서 검수한 상품이 정품이 아닐 경우, 구매가의 3배를
							보상합니다.
						</div>
					</div>
					<div class="deliveryinfo">
						<img
							src="${pageContext.request.contextPath}/images/item_check.png"
							width="40" height="40">
						<div>
							<b>엄격한 다중 검수</b><br> 모든 상품은 검수센터에 도착한 후, 상품별 전문가 그룹의 체계적인
							시스템을 거쳐 검수를 진행합니다.
						</div>
					</div>
					<div class="deliveryinfo">
						<img src="${pageContext.request.contextPath}/images/item_pack.png"
							width="40" height="40">
						<div>
							<b>정품 인증 패키지</b><br> 검수에 합격한 경우에 한하여 GRINN의 정품 인증 패키지가 포함된
							상품이 배송됩니다
						</div>
					</div>
				</div>
				<div class="Grinninfo">
					<div>Grinn(주)는 통신판매 중개자로서 통신판매의 당사자가 아닙니다. 본 상품은 개별판매자가 등록한 상품으로
						상품, 상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다. 단, 이용약관 및 정책, 기타 거래 체결 과정에서
						고지하는 내용 등에 따라 검수하고 보증하는 내용에 대한 책임은 Grinn(주)에 있습니다.</div>
				</div>
			</div>
		</div><!-- 상품 좌우안내 끝 -->
		<hr>
		<div>
			
		
		</div>
	</c:if>
</div>
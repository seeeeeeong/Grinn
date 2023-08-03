<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="page-main">
	<h1>판매 동의</h1>	
	<div>
		아이템 정보가 들어가는 곳
	</div>
	
	<hr size="1" noshade width="100%">
	
	<div class="align-center">
		<ul>
			<li>
				<a>
					<div>
						<p>
							판매하려는 상품이 맞습니다.
						</p>
						<p>
							상품 이미지, 모델번호, 출시일, 상품명, 사이즈를 한 번 더 확인했습니다.
						</p>
					</div>
					<div>
						<input type="checkbox" id="check1">	
					</div>
				</a>
			</li>
			<li>
				<a>
					<div>
						<p>
							국내/해외에서 발매한 정품 · 새상품입니다.
						</p>
						<p>
							모든 구성품이 그대로이며, 한 번도 착용하지 않은 정품・새상품입니다. 국내 발매 상품 여부는 확인드리지 않습니다.
						</p>
					</div>
					<div>
						<input type="checkbox" id="check1">	
					</div>
				</a>
			</li>
			<li>
				<a>
					<div>
						<p>
							박스/패키지의 상태를 확인합니다.
						</p>
						<p>
							박스/패키지 상태에 따른 검수 기준을 확인했습니다.
						</p>
					</div>
					<div>
						<a>검수기준 보기</a>
					</div>
					<div>
						<input type="checkbox" id="check1">	
					</div>
				</a>
			</li>
			<li>
				<a>
					<div>
						<p>
							KREAM의 최신 이용정책을 모두 확인하였으며, 구매를 계속합니다.
						</p>
						<p>
							건전하고 안전한 거래를 위해 반드시 숙지해야 할 미입고, 페널티, 부정거래 등의 이용정책을 확인했습니다.
						</p>
					</div>
					<div>
						<a>이용정책 보기</a>
					</div>
					<div>
						<input type="checkbox" id="check1">	
					</div>
				</a>
			</li>
		</ul>
		<div>
			<input type="button" value="판매 계속" onclick="location.href='saleDetail.do?item_num=${item_num}&item_size=${item_size}&item_sizenum=${item_sizenum}'">
		</div>
	</div>
</div>
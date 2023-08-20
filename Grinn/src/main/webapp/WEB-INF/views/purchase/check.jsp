<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script type="text/javascript">
	$(function(){
		let c = false;
		checking();
		$('.check-a').each(function(index, item){
			$(this).click(function(){
				let id = 'check' + (index+1);
				if($('input[id='+id+']').is(':checked')){
					$('input[id='+id+']').prop('checked',false);
				}else{
					$('input[id='+id+']').prop('checked',true);	
				}
				checking();
			});
		});
		
		function checking(){
			if($('#check1').is(':checked') && $('#check2').is(':checked') && $('#check4').is(':checked') && $('#check3').is(':checked')){
				$('#btn_purchase').prop('disabled',false);
				$('#btn_purchase').css('background-color','#fa7070');
				$('#btn_purchase').css('color','white');
			}else{
				$('#btn_purchase').css('background-color','#ebebeb');
				$('#btn_purchase').css('color','black');
				$('#btn_purchase').prop('disabled',true);
				$('#btn_purchase').removeAttr('cursor');	
			}
		}
	});
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssk/check.css">    
<h1 class="align-center">구매 동의</h1>	
<div class="page-size-main">
	<div class="page-check">
		<div class="page-check-inner">
			<div class="check-title">
				<h2><b style="color:red;">구매</b>하시기 전에 꼭 확인하세요.</h2>	
			</div>
			<div class="item">
				<div class="item-profile">
					<img src="${pageContext.request.contextPath}/item/viewProfile.do?item_num=${item.item_num}" width="130" height="130">
				</div>
				<div class="item-info">
					<p class="a">${item.item_brand}</p>
					<p class="b">${item.item_name}</p>
					<p class="c">${item.item_detail}</p>
					<c:if test="${empty item_size }">
						<p class="d">ONS SIZE</p>
					</c:if>
					<c:if test="${!empty item_size }">
						<p class="d">${item_size}</p>
					</c:if>
				</div>
			</div>
			<div class="check-purchase">
				<ul class="check-list">
					<li class="check-item" style="border-top:none;">
						<a class="check-a">
							<div class="check-group">
								<p class="check-main">
									구매하려는 상품이 맞습니다.
								</p>
								<p class="check-sub">
									상품 이미지, 모델번호, 출시일, 상품명, 사이즈를 한 번 더 확인했습니다. 단, 상품의 이미지는 촬영 환경에 따라 실제와 다를 수 있습니다.
								</p>
							</div>
							<div class="checkbox-item">
								<input type="checkbox" id="check1">	
								<label for="check1"></label>
							</div>
						</a>
					</li>
					<li class="check-item">
						<a class="check-a">
							<div class="check-group">
								<p class="check-main">
									국내/해외에서 발매한 정품 · 새상품입니다.
								</p>
								<p class="check-sub">
									모든 구성품이 그대로이며, 한 번도 착용하지 않은 정품・새상품입니다. 국내 발매 상품 여부는 확인드리지 않습니다.
								</p>
							</div>
							<div class="checkbox-item">
								<input type="checkbox" id="check2">	
								<label for="check2"></label>
							</div>
						</a>
					</li>
					<li class="check-item">
						<a class="check-a">
							<div class="check-group">
								<p class="check-main">
									제조사에서 불량으로 인정하지 않는 기준은 하자로 판단하지 않습니다.
								</p>
								<p class="check-sub">
									박스/패키지와 상품 컨디션에 민감하시다면 검수 기준을 반드시 확인하시기 바랍니다.<br>
									이용안내 탭 검수 기준을 눌러 확인해주세요.
								</p>
							</div>
							<div class="checkbox-item">
								<input type="checkbox" id="check3">
								<label for="check3"></label>	
							</div>
						</a>
					</li>
					<li class="check-item">
						<a class="check-a">
							<div class="check-group">
								<p class="check-main">
									KREAM의 최신 이용정책을 모두 확인하였으며, 구매를 계속합니다.
								</p>
								<p class="check-sub">
									건전하고 안전한 거래를 위해 반드시 숙지해야 할 미입고, 페널티, 부정거래 등의 이용정책을 확인했습니다.<br>
									이용안내 탭 이용 정책을 눌럭 확인해주세요.
								</p>
							</div>
							<div class="checkbox-item">
								<input type="checkbox" id="check4">	
								<label for="check4"></label>
							</div>
						</a>
					</li>
				</ul>
				<div class="check-button">
					<input type="button" class="btn-continue" id="btn_purchase"value="구매 계속" onclick="location.href='purchaseDetail.do?item_num=${item_num}&item_size=${item_size}&item_sizenum=${item_sizenum}'">
				</div>
			</div>
		</div>
	</div>
</div>
$(function(){
	/* 챗봇메세지 */
	let msg_socket;
	let member_list = []; //채팅 회원 저장 -> 로그인한 회원과 챗봇

	//챗봇방 멤버를 저장하는 배열에 회원을 저장
	if($('#user').length > 0){//챗봇방 생성
		member_list = [$('#user').attr('data-id')];
	}else if($('#chat_member').length > 0){//챗봇 채팅
		member_list = $('#chat_member').text();
	}
	
	/* 웹 소켓 연결 */
	function al_connect(){
		msg_socket = new WebSocket("ws://localhost:8000/message-ws.do");
		msg_socket.onopen=function(evt){
			//채팅 페이지에 진입하면 채팅 메시지 발송
			if($('#chatbotDetail').length==1){
				msg_socket.send("msg:");
			}
			console.log('채팅페이지 접속');
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		msg_socket.onmessage=function(evt){
			let data = evt.data;
			if($('#chatbotDetail').length == 1 &&
			    data.substring(0,4) == 'msg:'){
				selectMsg();
			}
		};
		msg_socket.onclose=function(evt){
			//소켓이 종료된 후 부가적인 작업이 있을 경우 명시
			console.log('채팅 종료');
		};
	}
	al_connect();
	
	/* 챗봇방 생성하기 */
	//채팅방 생성을 위한 데이터 전송
	/*$('#chatbot_form').submit(function(){
		//이미 배열에 현재 로그인한 유저가 기본 등록되어 있어서
		//로그인한 유저 포함 최소 2명이 되어야 채팅 가능
		if(member_list.length<=1){
			alert('채팅에 참여할 회원을 검색하세요!');
			$('#member_search').focus();
			return false;
		}
	});*/
	
	/* 챗봇방에서 문의하기 */
	function selectMsg(){
		//서버와 통신
		$.ajax({
			url:'../chatbot/chatbotDetailAjax.do',
			type:'post',
			data:{croom_num:$('#croom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					msg_socket.close();
				}else if(param.result == 'success'){
					//메시지 표시 UI 초기화
					$('#chatbot_message').empty();
					
					
					let croom_regdate = '';//chatbot 테이블에 있는 croom_regdate / 채팅이 시작된 날짜
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출 / 채팅이 시작된 날짜
						if(croom_regdate != item.croom_regdate.split(' ')[0]){
							croom_regdate = item.croom_regdate.split(' ')[0];
							output += '<div class="date"><span>'+croom_regdate+'</span></div>';
						}
						if(item.message.indexOf('@{welcome}@')>=0){//챗봇시작 메시지 처리
							output += '<div class="welcome_msg">';
							output += item.message.substring(0,item.message.indexOf('@{welcome}@'));
							output += '</div>';
						}else{
							if(item.mem_num == param.user_num){//내가 보낸 메세지
								output += '<div class="inner_talk">';
								output += '<div class="bubble">';
								output += '<div class="talk_info">';
								output += '<span>'+item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>')+'</span>';
								output += '<input type="hidden" value="'+item.c_num+'">';
								output += '</div>';//talk_info 끝
								output += '</div>';//bubble 끝
								//시간 추출
								output += '<div class="desc">'+item.croom_regdate.split(' ')[1]+'</div>';
								output += '</div>';//inner_talk 끝
								//하나의 메세지를 끝내기 위해 clear
								output += '<div class="space-clear"></div>';
								
								//output += 답변 넣기
								output += '<div class="to_inner_talk">';
								output += '<div class="to_bubble">';
								output += '<div class="to_talk_info">';
								if(item.message.includes("배송중")){
									output += '구매자에게 발송하는 운송장번호가 택배사에 접수되었습니다. 운송장조회는 택배사 수거 이후에 가능하게 됩니다.';
								}else if(item.message.includes("대기중")){
									output += '판매자의 상품 발송을 기다립니다. 판매자는 거래 체결 후 48시간(일요일・공휴일 제외) 이내에 운송장 정보를 입력하여야 합니다.';
								}else if(item.message.includes("발송완료")){
									output += '판매자가 GRINN으로 상품을 발송하여, 택배가 이동중입니다';
								}else if(item.message.includes("입고완료")){
									output += '검수센터 도착 후, 판매자가 입력한 정보 기준으로 택배를 확인했다는 의미입니다.'
									output += '<br>포장된 택배상자로 입고처리를 진행하며, 주문하신 상품의 확인은 해당 단계에서 진행되지 않습니다.';
								}else if(item.message.includes("배송")){
									output += '구매하신 상품의 배송은 결제완료 이후 영업일 기준 7-10일 소요되며, 택배사 사정에 따라 변경될 수 있습니다.';
									output += '<br>배송에 관련된 세부내용이 궁금하시다면 입력해주세요';
									output += '<br>ex) 대기중 / 배송중 / 발송완료 / 입고완료 / 검수중';
								}else if(item.message.includes("검수중")){
									output += '전문 검수팀에서 검수를 진행합니다. 이때 택배상자를 열어, 주문내역과 다른 상품은 바로 검수 불합격 처리됩니다.<br>상품에 따라 검수소요시간은 상이합니다.';
								}else if(item.message.includes("검수")){
									output += '발송시 주의사항1 > ✔️ 착불 발송 시, 정산 금액에서 차감';
									output += '<br>발송시 주의사항2 > ✔️ 카테고리 혼합/교차 등 오배송 주의';
									output += '<br>발송시 주의사항3 > ✔️ 파손 방지를 위한 이중 포장 필수';
									output += '<br>검수센터의 주소와 연락처를 알려드립니다.<br>찾으려는 검수센터명을 입력하세요.';
									output += '<br>ex) 스니커즈 / 패션잡화 / 의류 / 시계,가방';
								}else if(item.message.includes("스니커즈")){
									output += '📦 (12345) 서울 왕왕구 왕왕이로12길 34, 5층 (와왕타워)<br>📞 1588-1234 ';
								}else if(item.message.includes("패션잡화")){
									output += '📦 (6789) 서울 홍홍구 호호홍로1길 23, B32층 (호홍시티빌딩)<br>📞 1588-5678 ';
								}else if(item.message.includes("의류")){
									output += '📦 (6789) 서울 홍홍구 호호홍로1길 23, B32층 (호홍시티빌딩)<br>📞 1588-5678 ';
								}else if(item.message.includes("시계")){
									output += '📦 (1011121) 서울 히히구 히히산로 12길 3, 히히빌딩 2층<br>📞 1588-9101 ';
								}else if(item.message.includes("가방")){
									output += '📦 (1011121) 서울 히히구 히히산로 12길 3, 히히빌딩 2층<br>📞 1588-9101 ';
								}else if(item.message.includes("구매")){
									output += '💵 구매 입찰 > 원하는 가격을 적고 판매자 입찰을 기다립니다.';
									output += '<br>💵 즉시 구매 > 판매 입찰 가격 중에 최저가로 바로 구매합니다.';
									output += '<br>구매방법이 궁금하시다면 구매방법이라고 입력해주세요.';
								}else if(item.message.includes("판매방법")){
									output += '판매는 5단계로 이루어집니다.<br>1)판매할 상품 등록<br>2)거래 체결<br>3)상품 배송<br>4)GRINN검수<br>5)정산 완료';
								}else if(item.message.includes("판매취소")){
									output += '즉시 판매는 취소할 수 없습니다.';
									output += '<br>거래 체결 전인 경우에는 취소가 가능합니다.';
									output += '<br>해당 주문내역 상세보기에서 오른쪽 상단 휴지통 모양의 "입찰지우기"를 선택하시면 취소가 가능합니다.';
									output += '<br>즉시 판매한 경우 또는 입찰 후 거래가 체결된 경우에는 원칙적으로 취소가 불가능합니다.';
								}else if(item.message.includes("환불")){
									output += '환불은 배송완료 후 7일 이내로 신청 가능하며 상품 회수 후 영업일 기준 3-5일 소요됩니다.';
								}else if(item.message.includes("고객센터")){
									output += '고객센터 운영시간은 평일 09:00 ~ 18:00 (토,일,공휴일 휴무)이며 휴게시간은 평일 12:50 ~ 14:00입니다.';
								}else{
									output += '안녕하세요. 그린봇입니다. 무엇을 도와드릴까요?';
								}
								output += '</div>';//to_talk_info 끝
								output += '</div>';//to_bubble 끝
								//시간 추출
								output += '<div class="to_desc">'+item.croom_regdate.split(' ')[1]+'</div>';
								output += '</div>';//to_inner_talk 끝
								//하나의 메세지를 끝내기 위해 clear
								output += '<div class="space-clear"></div>';
							}
						}
						//문서 객체에 추가
						$('#chatbot_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatbotDetail').scrollTop($('#chatbot_message')[0].scrollHeight);
						
					});
					//여기서부터
					$(param.list2).each(function(index,item){
						output += ''+item.list2.an_answer;
					});
					
				}else{
					alert('채팅 메시지 읽기 오류 발생');
					msg_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				msg_socket.close();
			}
		});/* ajax통신 끝 */
	}
	
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
			$('#c_detail_form').trigger('submit');
		}
	});
	
	//채팅 등록
	$('#c_detail_form').submit(function(event){
		if($('#message').val().trim()==''){
			alert('메시지를 입력하세요!');
			$('#message').val('').focus();
			return false;
		}
		if($('#message').val().length>1333){
			alert('메시지를 1333자까지만 입력 가능합니다.');
			return false;
		}
		//여기까진 됨
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'../chatbot/writeChatbot.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
					msg_socket.close();
				}else if(param.result == 'success'){
					//폼 초기화
					$('#message').val('').focus();
					//메시지가 저장되었다고 소켓에 신호를 보냄
					msg_socket.send('msg:');
				}else{
					alert('채팅 등록 오류 발생');
					msg_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				msg_socket.close();
			}
		});
		//기본이벤트 제거
		event.preventDefault();
	});
	
	/* 챗봇문의방 나가기 */
	$('#delete_chatbotRoom').click(function(){
		let choice = confirm('채팅방을 나가길 원하시나요?');
		if(!choice){
			return;
		}
		
		//서버와 통신
		$.ajax({
			url:'../chatbot/deleteChatBotRoomMemberAjax.do',
			type:'post',
			data:{croom_num:$('#croom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 사용할 수 있습니다.');
					msg_socket.close();
				}else if(param.result == 'success'){
					alert('정상적으로 채팅방을 나갔습니다.');
					//메시지가 저장되었다고 소켓에 신호를 보냄
					msg_socket.send('msg:');
					location.href='../chatbot/chatbotList.do';
				}else{
					alert('채팅방 나가기 처리 오류 발생');
					msg_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				msg_socket.close();
			}
		});
	});
	
});









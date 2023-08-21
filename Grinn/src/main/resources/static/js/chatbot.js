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
							output += '<div class="desc"><span>'+croom_regdate+'</span></div>';
						}
						//일반 메시지 전송
						if(item.mem_num == param.user_num){//내가 보낸 메세지
							output += '<div class="bubble">';
							output += '<div class="inner_talk">';
							output += '<div class="talk_info">';
							output += '<span>'+item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>')+'</span>';
							output += '</div>';//talk_info 끝
							output += '</div>';//inner_talk 끝
							output += '<div class="space-clear"></div>';
							//시간 추출
							output += '<div class="desc">'+item.croom_regdate.split(' ')[1]+'</div>';
							output += '</div>';
						}else{//답변 메세지
							output += '<div class="bubble">';
							output += '<div class="inner_talk">';
							output += '<div class="talk_info">';
							output += '<img src="../images/how_to_question.jpg" width="40" height="40" class="my-photo">';
							
							output += '</div>';//talk_info 끝
							output += '</div>';//inner_talk 끝
							output += '<div class="space-clear"></div>';
							//시간 추출
							output += '<div class="desc">'+item.croom_regdate.split(' ')[1]+'</div>';
							output += '</div>';
						}
						
						
						/* 삭제예정
						if(item.mem_num == param.user_num){
							//output += '<div class="form-position">' + item.mem_id + '</div>'; //발신자 아이디
						}else{
							output += '<div class="to-position">';
							output += '<div class="space-photo">';
							output += '<img src="../images/how_to_question.jpg" width="40" height="40" class="my-photo">';
							output += '</div><div class="space-message">';
							output += item.mem_id+'ChatBot'; //상대방 아이디?->챗봇으로 떠야하나
						}
						output += '<div class="item">';
						output += ' <span>'+item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>')+'</span>';
						//시간 추출
						output += '<div class="align-right">'+item.croom_regdate.split(' ')[1]+'</div>';
						output += '</div>'; //end of item
						output += '</div>'; //end of space-message
						output += '<div class="space-clear"></div>';
						output += '</div>'; //end of to-position
						*/
						//문서 객체에 추가
						$('#chatbot_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatbot_message').scrollTop($('#chatbot_message')[0].scrollHeight);
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









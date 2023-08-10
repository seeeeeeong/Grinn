package kr.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.websocket.ws.AlarmHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig 
                     implements WebSocketConfigurer{

	private final AlarmHandler alarmHander = new AlarmHandler();
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(alarmHander, "message-ws.do").setAllowedOrigins("*");
	}

}






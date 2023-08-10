package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AdminCheckInterceptor;
import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;

//자바 코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	private AutoLoginCheckInterceptor autoLoginCheck;
	private AdminCheckInterceptor adminCheck;
	private LoginCheckInterceptor loginCheck;
	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLoginCheck = new AutoLoginCheckInterceptor();
		return autoLoginCheck;
	}
	
	@Bean
	public AdminCheckInterceptor interceptor3() {
		adminCheck = new AdminCheckInterceptor();
		return adminCheck;
	}
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//AutoLoginCheckInterceptor 설정
		registry.addInterceptor(autoLoginCheck)
		        .addPathPatterns("/**")
		        .excludePathPatterns("/member/login.do")
		        .excludePathPatterns("/member/logout.do");
		//AdminCheckInterceptor 설정
		registry.addInterceptor(adminCheck)
		        .addPathPatterns("/main/admin.do")
		        .addPathPatterns("/member/admin_list.do")
		        .addPathPatterns("/member/admin_update.do");
		//LoginInterceptor 설정
		registry.addInterceptor(loginCheck)
				.addPathPatterns("/style/write.do")
				.addPathPatterns("/talk/talkList.do");
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = new TilesConfigurer();
		//해당 경로에 xml 설정 파일을 넣음
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/hmj.xml",
				"/WEB-INF/tiles-def/lss.xml",
				"/WEB-INF/tiles-def/phj.xml",
				"/WEB-INF/tiles-def/ssk.xml",
				"/WEB-INF/tiles-def/sys.xml",
				"/WEB-INF/tiles-def/yjs.xml",
				"/WEB-INF/tiles-def/yyj.xml"
		});
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				                    new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
}




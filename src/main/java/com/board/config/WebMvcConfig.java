package com.board.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.board.interceptor.AuthInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Autowired
	private AuthInterceptor authInterceptor;

	// 로그인이 필요한 주소를 등록한다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// authInterceptor를 동작시킬때 특정페이지를 대상으로 한다.
		// 모든 /** : http://localhost:9090아래의 모든 페이지
		// 제외 : "/css/**","/img/**","/js/**" 경로는 interceptor의 대상이 아님
		// .addPathPatterns("/Board/**") => http://localhost:9090/Board/** (루트 밑에 모든파일)  
		
		// 전체를 주석처리 하면 로그인 로직을 중지 할 수 있다. --시작.
		registry.addInterceptor(authInterceptor)
		//		.addPathPatterns("/**"); 모든 페이지 로그인
				.addPathPatterns("/Board/**","/BoardPaging/**") // 로그인 대상
				.excludePathPatterns("/css/**","/img/**","/js/**");
		
		WebMvcConfigurer.super.addInterceptors(registry);
		// 전체를 주석처리 하면 로그인 로직을 중지 할 수 있다. --끝.
	}
	
}

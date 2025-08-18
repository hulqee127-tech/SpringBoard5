package com.board.interceptor;

import java.text.MessageFormat;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AuthInterceptor implements HandlerInterceptor {
	// Interceptor :페이지가 이동할 때 Controller 앞에서 가로채기 하는 클래스
	// 전처리(로그인)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String requestURI = request.getRequestURI();
		String menu_id = request.getParameter("menu_id");
		String nowpage = request.getParameter("nowpage");
		
		log.info("uri : ",requestURI);
		// 없으면 : 무한반복 호출
		// /Users/LoginForm, /Users/login을 제외
		if( requestURI.contains("/Users/LoginForm")) {
			return true;
		}
		
		if( requestURI.contains("/Users/Login")) {
			return true;
		}
		
		String uri = requestURI.split("/")[1];
		
		HttpSession session = request.getSession();	
		Object login = session.getAttribute("login");
		
		if(login == null) {
			// 로그인 되어 있지 않다면, 로그인 페이지로 이동
			String fmt = "/Users/LoginForm?uri={0}&menu_id={1}&nowpage{2}";
			String loc = MessageFormat.format(fmt,uri, menu_id, nowpage);
			response.sendRedirect(loc);
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

	// 후처리
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	
}

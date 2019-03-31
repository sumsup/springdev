package com.example.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

// 접근 권한 거부시 처리 핸들러.
public class CustomAccessDeniedHandler implements AccessDeniedHandler { // AccessDeniedHandler 구현.
	
	private static final Logger log = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);

	@Override
	// AccessDenied 가 발생했을때 여기서 로직을 처리한다.
	public void handle(HttpServletRequest request, HttpServletResponse response, // ServletRequest. ServletResponse를 직접적으로
																				// 이용 할 수 있다.
			AccessDeniedException accessDeniedException) throws IOException, ServletException { 
		
		log.error("Access Denied Handler");
		log.error("Redirect.......");
		
		response.sendRedirect("/accessError"); // 접근 제한에 걸리는 경우 redirect로 처리.
		
	}
	
	
	

}

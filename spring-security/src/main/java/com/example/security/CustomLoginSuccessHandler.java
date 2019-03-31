package com.example.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

// 로그인 성공시 처리를 위한 핸들러.
// security-context.xml 에서 명시한 내용에 따라 컨트롤러로 가지 않고
// 여기서 처리한다.
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Override
	// 인증 성공시 처리하기 위한 인터페이스 구현.
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {

		log.warn("Login Success");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> { // 사용자가 가진 모든 권한을 List에 저장.
													// auth.getAuthorities() 리스트의 개개의 개체를 authority로 명명.
			
			log.warn("받아온 권한들 : " + authority.getAuthority());
			roleNames.add(authority.getAuthority());
			
		});
		
		log.warn("ROLE NAMES: " + roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) { // ADMIN을 포함하고 있으면
			response.sendRedirect("/test/sample/admin"); // 관리자 페이지로 리다이렉트.
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) { // MEMBER를 포함하고 있으면
			response.sendRedirect("/test/sample/member"); // 회원 페이지로 리다이렉트.
			return;
		}
		
		// 아무 권한이 없으면 그냥 루트 페이지로.
		response.sendRedirect("/test/");
		
	}
	
}
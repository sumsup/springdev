package com.example.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.example.domain.MemberVO;

// CustomUserDetailsService 클래스에서 memberVO 객체를 처리할 수 있게
// memberVO 객체 -> SimpleGrantedAuthority 객체로 변환해 주는 역할.
public class CustomUser extends User { 
	// 부모인 User를 상속하기 때문에.
	// 부모 클래스의 생성자가 있어야 객체를 생성 가능.
	// super() 로.
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public MemberVO getMember() {
		return member;
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()) );
		
		// stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())) : 리스트의 객체들을 꺼내서 반복문으로 처리할 수 있다.
		// 여기서 map은 어떤 요소를 연산하는데 쓰인다.
		// 여기서는 auth객체의 값을 SimpleGrantedAuthority 객체로 생성하는 작업을 했음.

		// Collectors.toList() : 해당스트림을 다시 컬렉션 값으로 바꿔준다. 여기서 toList() 했으니 리스트 컬렉션으로 바꿔줌.
		
		this.member = vo;
	}

}
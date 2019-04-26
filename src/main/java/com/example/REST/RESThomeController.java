package com.example.REST;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.VO.MemberVO;

@RestController
@RequestMapping("/rest")
public class RESThomeController {

	@PostMapping("/register")
	public void registerMember(MemberVO memberVO) {
		
		System.out.println("***************** MemberVO : " + memberVO);
		
	}
	
}

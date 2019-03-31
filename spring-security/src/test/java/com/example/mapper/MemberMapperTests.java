package com.example.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.domain.MemberVO;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberMapperTests {
	
	private static final Logger log = LoggerFactory.getLogger(MemberMapperTests.class);
	
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testRead() {
		// result Map을 반환하는 vo 객체를 얻어서.
		MemberVO vo = mapper.read("admin95");
		
		vo.getAuthList().forEach(authVO -> log.info("authVO : " +authVO));
	}
	
}
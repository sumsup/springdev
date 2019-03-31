package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	// 테스트 하기전에 해당 번호의 게시물이 존재하는지 반드시 확인할 것
	private Long[] bnoArr = { 4325422L , 4325401L, 4325393L, 4325390L , 4325386L }; 
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper	mapper;
	
	
	@Test
	public void testList2()	{

		Criteria cri = new Criteria(2, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 4325393L);
		replies.forEach(reply -> log.info(reply));

	}
	
	/*@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
		
	}*/
	
	
	/*@Test
	public void testUpdate() {
		Long targetRno = 10L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update Reply ");
		int count = mapper.update(vo);
		log.info("update count: "+ count);
	}*/
	
	/*@Test
	public void testRead() {
		
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
		
	}*/
	
	/*@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> { // i를 넣어서 각자 실행하는 것인가 봄.
			
			ReplyVO vo = new ReplyVO();
			
			// 게시물 번호
			vo.setBno(bnoArr[i % 5]); 
			// 반복은 1~10 까지하는데 게시물은 
			// 5개 밖에 없으니까 2번 반복하게 하려는 것.
			
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("댓글쓴이 " + i);
			
			mapper.insert(vo);
			
		});
	}*/
	
	/*@Test
	public void testMapper() {
		
		log.info(mapper);
		
	}*/
	
}

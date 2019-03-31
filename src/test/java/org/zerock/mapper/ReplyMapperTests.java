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
	
	// �׽�Ʈ �ϱ����� �ش� ��ȣ�� �Խù��� �����ϴ��� �ݵ�� Ȯ���� ��
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
		IntStream.rangeClosed(1, 10).forEach(i -> { // i�� �־ ���� �����ϴ� ���ΰ� ��.
			
			ReplyVO vo = new ReplyVO();
			
			// �Խù� ��ȣ
			vo.setBno(bnoArr[i % 5]); 
			// �ݺ��� 1~10 �����ϴµ� �Խù��� 
			// 5�� �ۿ� �����ϱ� 2�� �ݺ��ϰ� �Ϸ��� ��.
			
			vo.setReply("��� �׽�Ʈ " + i);
			vo.setReplyer("��۾��� " + i);
			
			mapper.insert(vo);
			
		});
	}*/
	
	/*@Test
	public void testMapper() {
		
		log.info(mapper);
		
	}*/
	
}

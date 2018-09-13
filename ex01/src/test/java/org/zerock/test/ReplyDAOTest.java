package org.zerock.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;
import org.zerock.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReplyDAOTest {
		
	@Inject
	private ReplyDAO dao;
	private static Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class);
	
	/*@Test
	public void TestReplyCreate() throws Exception {
		ReplyVO vo = new ReplyVO();
		
		vo.setBno(20);
		vo.setReplytext("리플 테스트 용");
		vo.setReplyer("리플단 사람");
		vo.setRno(1);
		
		dao.create(vo);
		
		logger.info("====  ReplyDAO TEST now  ====");
	}*/
	
	@Test
	public void TestReplyRead() throws Exception {
		logger.info(dao.list(20).toString());
	}
	
}

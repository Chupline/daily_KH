package org.zerock.persistence;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// @ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
@Log4j
public class BoardMapperTests {

	//@Setter(onMethod_ = @Autowired)
	@Inject
	private BoardMapper boardMapper;

	@Test
	public void selectBoardList() throws Exception {
		System.out.println("*** before");
		log.info("/* "+boardMapper.getClass().getName());
		log.info("/* boardMapper.selectBoardList()="+boardMapper.selectBoardList());
		System.out.println("*** after");
		
	}

}

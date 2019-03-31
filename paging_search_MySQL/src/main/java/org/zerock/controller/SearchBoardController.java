package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.PageMaker;
import org.zerock.domain.SearchCriteria;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);

	@Inject
	private BoardService service;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		logger.info(cri.toString());

		// model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		// pageMaker.setTotalCount(service.listCountCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		logger.info("**********/list model is ************\n"+model.toString());
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception { 
		// @RequestParam은 URL에있는 bno의 값을 가져와서 bno에 넣는다.
		// @ModelAttribute("cri") : Model 객체의 속성에 cri 라는 이름으로 SearchCriteria의 인스턴스를 add 한다.
		// 둘다 애노테이션의 영어를 해석해보면 어떤 기능인지 직관적으로 알 수 있다.

		model.addAttribute(service.read(bno));
		logger.info("******** /readPage Model is ********\n" + model.toString());
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		service.remove(bno);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/sboard/list";
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modifyPagingGET(int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPagingPOST(BoardVO board, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		logger.info(cri.toString());
		service.modify(board);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		rttr.addFlashAttribute("msg", "SUCCESS");

		logger.info(rttr.toString());

		return "redirect:/sboard/list";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registGET() throws Exception {

		logger.info("regist get ...........");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr) throws Exception {

		logger.info("regist post ...........");
		logger.info(board.toString());

		service.regist(board);

		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/sboard/list";
	}

	// @RequestMapping(value = "/list", method = RequestMethod.GET)
	// public void listPage(@ModelAttribute("cri") SearchCriteria cri,
	// Model model) throws Exception {
	//
	// logger.info(cri.toString());
	//
	// model.addAttribute("list", service.listCriteria(cri));
	//
	// PageMaker pageMaker = new PageMaker();
	// pageMaker.setCri(cri);
	//
	// pageMaker.setTotalCount(service.listCountCriteria(cri));
	//
	// model.addAttribute("pageMaker", pageMaker);
	// }
}

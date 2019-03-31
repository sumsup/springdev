package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		// 기본값을 가지는 별도의 클래스를 가지고 파라미터에서 선언해주고 있고..
	
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total : " + total);
		log.info("************* list model" + model);
		
		// 패이징을 만들어주는 클래스를 아래의 PageDTO에서 cri랑 total을 받아가지고 만들고 있다.
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만이 아래 메서드를 사용하게.
	public void register(@ModelAttribute("cri") Criteria cri, Model model) 
	{
		log.info("***************** register model : " + model);
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) 
	{
		log.info("************* register: " + board);
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) 
	{
		log.info("/get, /modify");
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer") // 권한보유자와 글쓴이가 같을때만 수정 가능.
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
			log.info("************* modify: "+board);
			
			if(service.modify(board)) {
				rttr.addFlashAttribute("result", "success");
			}
					
			return "redirect:/board/list"+cri.getListLink();
		
	}

	@PreAuthorize("principal.username == #writer") // 권한 보유자와 글쓴이가 같을때만 삭제 가능.
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) 
	{

			log.info("************* remove... " + bno);
			if(service.remove(bno)) {
				rttr.addFlashAttribute("result", "success");
			}
				
			return "redirect:/board/list"+cri.getListLink();
	}
	
	
	
}















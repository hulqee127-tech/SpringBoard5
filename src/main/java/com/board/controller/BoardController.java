package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.board.domain.BoardDTO;
import com.board.mapper.BoardMapper;
import com.board.menus.domain.MenuDTO;
import com.board.menus.mapper.MenuMapper;

@Controller
public class BoardController {

	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private BoardMapper boardMapper;
	
	@RequestMapping("/Board/boardList")
	public ModelAndView list(MenuDTO menuDto) {
		// 메뉴 리스트
		List<MenuDTO> menuList = menuMapper.getMenuList();
		
		// 게시물 리스트
		List<BoardDTO> boardList = boardMapper.getBoardList(menuDto);
		
		menuDto = menuMapper.getUpdateData(menuDto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList",menuList);
		mv.addObject("menuDto",menuDto);
//		mv.addObject("menu_id",menu_id);
		mv.addObject("boardList",boardList);
		mv.setViewName("board/boardList");
		return mv;
	}
	
	@RequestMapping("/Board/WriteForm")
	public ModelAndView writeForm(MenuDTO menuDto, Model model) {
		// 메뉴 리스트
		List<MenuDTO> menuList = menuMapper.getMenuList();
		menuDto = menuMapper.getUpdateData(menuDto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList",menuList);
		mv.addObject("menuDto",menuDto);
		mv.setViewName("board/writeForm");
		return mv;
		//List<BoardDTO> categoryData = boardMapper.getCategoryData();
		//model.addAttribute("categoryData", categoryData);
		//return "board/writeForm";	//WEB-INF/views/board/writeForm.jsp
	}
	
	@RequestMapping("/Board/Write")
	public ModelAndView write(BoardDTO boardDto) {
		boardMapper.insertBoard(boardDto);
		
		String menu_id = boardDto.getMenu_id();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/boardList?menu_id="+menu_id);
		return mv;
	}
	
	@RequestMapping("/Board/boardView")
	public ModelAndView boardView(BoardDTO boardDto, MenuDTO menuDto) {
		// 메뉴 리스트
		List<MenuDTO> menuList = menuMapper.getMenuList();
		// 메뉴이름
		menuDto = menuMapper.getUpdateData(menuDto);
		
		//조회수 증가
		boardMapper.incHit(boardDto);
		
		boardDto = boardMapper.getBoardData(boardDto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList",menuList);
		mv.addObject("menuDto",menuDto);
		mv.addObject("boardDto",boardDto);
		mv.setViewName("board/boardView");
		return mv;
	}
	
	@RequestMapping("/Board/updateForm")
	public ModelAndView updateView(BoardDTO boardDto) {
		// 메뉴 리스트
		List<MenuDTO> menuList = menuMapper.getMenuList();
		// 게시물 데이터
		boardDto = boardMapper.getBoardData(boardDto);
		
		//String menu_id = boardDto.getMenu_id();
		//전달
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList",menuList);
		mv.addObject("boardDto",boardDto);
		mv.setViewName("board/updateForm");
		return mv;
		
	}
	
	@RequestMapping("/Board/Update")
	public ModelAndView update(BoardDTO boardDto) {
		boardMapper.updateBoard(boardDto);
		String menu_id = boardDto.getMenu_id();
		int idx = boardDto.getIdx();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/boardView?idx="+idx);
		return mv;
	}
	
	@RequestMapping("/Board/Delete")
	public ModelAndView delete(BoardDTO boardDto) {
		String menu_id = boardDto.getMenu_id();
		System.out.println(menu_id);
		boardMapper.deleteBoard(boardDto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/boardList?menu_id="+menu_id);
		return mv;
	}
	/*
	@RequestMapping("/Board/boardList")
	public String boardList(Model model) {
		
		List<BoardDTO> boardList = boardMapper.getBoardList();
		System.out.println(boardList);

		model.addAttribute("boardList", boardList);
		
		return "board/boardList";	//WEB-INF/views/board/list.jsp
	}
	
	@RequestMapping("/Board/WriteForm")
	public String writeForm(BoardDTO boardDto, Model model) {
		List<BoardDTO> categoryData = boardMapper.getCategoryData();
		model.addAttribute("categoryData", categoryData);
		return "board/writeForm";	//WEB-INF/views/board/writeForm.jsp
	}
	
	@RequestMapping("/Menus/Write")
	//1. public String write(HttpServletRequest request) {
	//2. public String write(@RequestParam("menu_id") String menu_id, @RequestParam("menu_name") String menu_name, @RequestParam ("menu_seq") int menu_seq) {
	public String write( MenuDTO menuDto, Model model ) {
		//1. String menu_id = request.getParameter("menu_id");
		//System.out.println(menu_id);
		//System.out.println(menu_name);
		//System.out.println(menu_seq);
				
		// 맨유 등록 : DB insert
		//menuMapper.insertMenu(menu_id, menu_name, menu_seq);
		//2. MenuDTO menuDto = new MenuDTO(menu_id, menu_name, menu_seq);
		menuMapper.insertMenu(menuDto);
		
		//List<MenuDTO> menuList = menuMapper.getMenuList();
		//model.addAllAttributes(menuList);
		
		// 목록보기로 이동
		//return "menus/list";	//WEB-INF/views/menus/write.jsp
		return "redirect:/Menus/menuList";
	}
	
	///Menus/Delete?menu_id=${ menu.menu_id   }
	@RequestMapping("/Menus/Delete")
	//public String delete(@RequestParam String menu_id) {
	public String delete(MenuDTO menuDto) {
		menuMapper.deleteMenu(menuDto);
		System.out.println(menuDto);
		return "redirect:/Menus/menuList";
	}
	
	//http://localhost:9090/Menus/UpdateForm?menu_id=MENU12
	@RequestMapping("/Menus/UpdateForm")
	public String updateForm(MenuDTO menuDto, Model model) {
		// 넘어온 정보를 이용하여 수정할 정보를 조회
		MenuDTO updateData = menuMapper.getUpdateData(menuDto);
		System.out.println(updateData);
		// 조회한 정보를 updateForm.jsp 로 넘긴다.
		model.addAttribute("updateData", updateData);
		// munus/updateForm.jsp 로 가랏~!
		return "menus/updateForm";	
		//return "";
	}
	
	//http://localhost:9090/Menus/Update
	@RequestMapping("/Menus/Update")
	public String updateMenu(MenuDTO menuDto, Model model) {
		menuMapper.updateMenu(menuDto);
		return "redirect:/Menus/menuList";
	}
	*/
}

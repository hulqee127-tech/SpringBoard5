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
	public ModelAndView list(String where_str, BoardDTO boardDto, MenuDTO menuDto) {
		// 메뉴 리스트
		List<MenuDTO> menuList = menuMapper.getMenuList();
		
		// 게시물 리스트
		//List<BoardDTO> boardList = boardMapper.getBoardList(menuDto);
		//where_str = "where menu_id=#{menuDto.menu_id}";
		//where_str = "where menu_id=#{menu_id}";
		where_str = "where menu_id='"+menuDto.getMenu_id()+"'";
		System.out.println(where_str);
		System.out.println(menuDto.getMenu_id());
		//boardDto.setWhere_str(where_str);
		List<BoardDTO> boardList = boardMapper.getBoardList1(where_str);
		
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
		System.out.println("menu_id "+boardDto);
		boardMapper.insertBoard(boardDto);
		
		String menu_id = boardDto.getMenu_id();
		//System.out.println("menu_id "+menu_id);
		
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
	
}

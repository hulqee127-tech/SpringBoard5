package com.board.paging.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.board.domain.BoardDTO;
import com.board.mapper.BoardPagingMapper;
import com.board.menus.domain.MenuDTO;
import com.board.menus.mapper.MenuMapper;
import com.board.paging.domain.PageResponse;
import com.board.paging.domain.Pagination;
import com.board.paging.domain.SearchDTO;

@Controller
public class BoardPagingController {
	//menu를 불러 오는 마이바티스
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private BoardPagingMapper boardPagingMapper;

	@RequestMapping("/BoardPaging/boardList")
	public ModelAndView list(int nowpage, MenuDTO menuDto) {
		//메뉴목록
		List<MenuDTO> menuList = menuMapper.getMenuList();
		
		//게시물 목록
		// menu_id = MENU01
		// nowpage : 2
		// 줄번호 11 ~ 20 번까지 자료를 조회
		// 해당 menu_id 의 총 자료수 구하기
		int count = boardPagingMapper.count(menuDto); // menu_id 전달
		System.out.println("자료수 : "+count);
		
		// page로 조회한 결과를 담아놓을 객체
		PageResponse<BoardDTO> response = null;
		if( count < 1 ) {	// menu_id 의 자료가 없다면...
			response = new PageResponse<>(Collections.emptyList(), null);
			// 생성자를 이용해서 초기화 하겠다...
			// Collections.emptyList() : 자료가 없는 빈 리스트를 만들어서 채운다.
		}
		
		// 페이징을 위한 초기 설정
		SearchDTO searchDto = new SearchDTO();
		searchDto.setPage(nowpage);		//현재 페이지 정보
		searchDto.setRecordSize(10);	// 페이지당 10줄
		searchDto.setPageSize(10);	// paging.jsp 에 출력할 페이지 번호 수
		
		// Pagination 설정
		Pagination pagination = new Pagination(count, searchDto);
		searchDto.setPagination(pagination);
		
		////////////////////////////////////////////////////////
		int offset = searchDto.getOffset();			// 30
		int recordSize = searchDto.getRecordSize();		// 10;
		
		List<BoardDTO> list = BoardPagingMapper.getBoardPagingList(offset, recordSize);
		response = new PageResponse<>(list, pagination);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList",menuList);

		mv.addObject("response",response);
		mv.setViewName("boardpaging/boardList");
		return mv;
	}
}

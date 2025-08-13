package com.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

//import com.board.controller.boardDTO;
import com.board.domain.BoardDTO;
import com.board.menus.domain.MenuDTO;

@Mapper
public interface BoardMapper {
	// 게시물 리스트
	List<BoardDTO> getBoardList(MenuDTO menuDto);

	// 게시물 등록
	void insertBoard(BoardDTO boardDto);

	// 업데이트 대상 데이터
	BoardDTO getBoardData(BoardDTO boardDto);

	// 게시물 업데이트
	void updateBoard(BoardDTO boardDto);
	
	// 게시물 삭제
	void deleteBoard(BoardDTO boardDto);

	//HIT +1 만들기
	void incHit(BoardDTO boardDto);

//	List<BoardDTO> getCategoryData();

}

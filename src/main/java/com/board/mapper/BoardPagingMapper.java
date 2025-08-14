package com.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.domain.BoardDTO;
import com.board.menus.domain.MenuDTO;

@Mapper
public interface BoardPagingMapper {

	int count(MenuDTO menuDto);

	List<BoardDTO> getBoardPagingList(String menu_id, int offset, int recordSize);

}

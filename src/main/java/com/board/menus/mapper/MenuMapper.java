package com.board.menus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.domain.BoardDTO;
import com.board.menus.domain.MenuDTO;

@Mapper
public interface MenuMapper {

	//void insertMenu(@Param("menu_id") String menu_id,@Param("menu_name") String menu_name,@Param("menu_seq") int menu_seq);
	void insertMenu(MenuDTO menuDto);

	MenuDTO getInsertData(MenuDTO menuDto);
	
	List<MenuDTO> getMenuList();
	
	//void deleteMenu(String menu_id);
	void deleteMenu(MenuDTO menuDto);

	MenuDTO getUpdateData(MenuDTO menuDto);

	void updateMenu(MenuDTO menuDto);

	void deleteBoard(BoardDTO boardDto);

	//MenuDTO getMenu(MenuDTO menuDto);
	
}

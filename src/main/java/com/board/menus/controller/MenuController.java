package com.board.menus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.menus.domain.MenuDTO;
import com.board.menus.mapper.MenuMapper;

@Controller
public class MenuController {

	@Autowired
	private MenuMapper menuMapper;
	
	@RequestMapping("/Menus/menuList")
	public String list(Model model) {
		
		List<MenuDTO> menuList = menuMapper.getMenuList();
		System.out.println(menuList);

		model.addAttribute("menuList", menuList);
		
		return "menus/menuList";	//WEB-INF/views/menus/list.jsp
	}
	
	
	@RequestMapping("/Menus/WriteForm")
	public String writeForm(MenuDTO menuDto, Model model) {
		MenuDTO insertData = menuMapper.getInsertData(menuDto);
		model.addAttribute("insertData", insertData);
		return "menus/writeForm";	//WEB-INF/views/menus/writeForm.jsp
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
}

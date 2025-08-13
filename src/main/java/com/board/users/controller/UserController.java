package com.board.users.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.users.domain.UserDTO;
import com.board.users.mapper.UserMapper;

@Controller
public class UserController {

	@Autowired
	private UserMapper userMapper;
	
	@RequestMapping("/Users/userList")
	public String list(Model model) {
		
		List<UserDTO> userList = userMapper.getUserList();
		//System.out.println(userList);

		model.addAttribute("userList", userList);
		
		return "users/userList";	//WEB-INF/views/menus/list.jsp
	}
	
	
	@RequestMapping("/Users/WriteForm")
	public String writeForm(UserDTO userDto, Model model) {
		//UserDTO insertData = userMapper.getInsertData(userDto);
		//model.addAttribute("insertData", insertData);
		return "users/writeForm";	//WEB-INF/views/menus/writeForm.jsp
	}
	
	@RequestMapping("/Users/Write")
	public String write( UserDTO userDto, Model model ) {
		userMapper.insertUser(userDto);
		
		// 목록보기로 이동
		return "redirect:/Users/userList";
	}
	
	@RequestMapping("/Users/Delete")
	public String delete(UserDTO userDto) {
		userMapper.deleteUser(userDto);
		//System.out.println(userDto);
		return "redirect:/Users/userList";
	}
	
	@RequestMapping("/Users/UpdateForm")
	public String updateForm(UserDTO userDto, Model model) {
		// 넘어온 정보를 이용하여 수정할 정보를 조회
		UserDTO updateData = userMapper.getUpdateData(userDto);
		//System.out.println(updateData);
		// 조회한 정보를 updateForm.jsp 로 넘긴다.
		model.addAttribute("updateData", updateData);
		// users/updateForm.jsp 로 가랏~!
		return "users/updateForm";	
		//return "";
	}
	
	@RequestMapping("/Users/Update")
	public String updateUser(UserDTO userDto, Model model) {
		userMapper.updateUser(userDto);
		return "redirect:/Users/userList";
		//return "";
	}
	
	@PostMapping("/Users/LogIn")
	public String login(@RequestParam("uid")String uid, @RequestParam("pwd") String pwd) {
	//public String login(UserDTO userDto) {
		List<UserDTO> udata = userMapper.login(uid,pwd);
		System.out.println(udata);
		
		
		
		return"/";
	}
	
}

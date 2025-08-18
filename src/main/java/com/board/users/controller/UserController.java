package com.board.users.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.users.domain.UserDTO;
import com.board.users.mapper.UserMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
	//////////////////////////////////////////////////
	// 로그인
	// /Users/LoginForm
	// response.sendRedirect() - Get 방식 호출
	// GetMapping 으로 처리 : 로그인 페이지로 이동
	// postMapping 사용안됨
	@GetMapping("/LoginForm")
	public String loginForm(String uri, String menu_id, String nowpage, Model model) {
		model.addAttribute("uri",uri);
		model.addAttribute("menu_id",menu_id);
		model.addAttribute("nowpage",nowpage);
		return "users/login";
	}
	
	// /Users/Login
	@PostMapping("/Login")
	public String Login(HttpServletRequest request, HttpServletResponse response) {
		// 넘어온 로그인 정보 처리
		String userid = request.getParameter("userid");
		String passwd = request.getParameter("passwd");
		String uri = request.getParameter("uri");
		String menu_id = request.getParameter("menu_id");
		String nowpage = request.getParameter("nowpage");
		
		// db 조회
		UserDTO user = userMapper.login(userid, passwd);
		System.out.println(user);
		
		// 다른 페이지에서 볼 수 있도록 session 에 저장
		HttpSession session = request.getSession();
		session.setAttribute("login", user);
		
		// 돌아갈 주소 설정
		return "redirect:/"+uri+"/List"+"?menu_id"+menu_id+"&nowpage="+nowpage;
	}
	
	// /Users/Logout
	@PostMapping("/Logout")
	@RequestMapping(value="/Logout",method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		session.invalidate(); 	// session 을 초기화.
		
		//Object url = session.getAttribute("URL");
		//return "redirect:/"+(String url);
		return "redirect:/";
	}
	
}

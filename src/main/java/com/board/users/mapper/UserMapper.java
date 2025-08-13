package com.board.users.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.board.users.domain.UserDTO;

@Mapper
public interface UserMapper {

	//void insertMenu(@Param("menu_id") String menu_id,@Param("menu_name") String menu_name,@Param("menu_seq") int menu_seq);
	void insertUser(UserDTO userDto);

	UserDTO getInsertData(UserDTO userDto);
	
	List<UserDTO> getUserList();
	
	void deleteUser(UserDTO userDto);

	UserDTO getUpdateData(UserDTO userDto);

	void updateUser(UserDTO userDto);

	List<UserDTO> login(@Param("uid") String uid,@Param("pwd") String pwd);
	
	
}

package com.capstone.user.service;

import com.capstone.user.dto.LoginDTO;
import com.capstone.user.dto.UserDTO;
import com.capstone.user.entity.User;
import java.util.List;

public interface UserService {

    String registerUser(UserDTO userDTO);

    User loginUser(LoginDTO loginDTO);

    List<User> getAllUsers();

    List<User> getPendingUsers();

    String activateUser(Long userId);

    String deactivateUser(Long userId);

    User getUserById(Long userId);
}
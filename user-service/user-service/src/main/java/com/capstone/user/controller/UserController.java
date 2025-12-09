package com.capstone.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.capstone.user.dto.LoginDTO;
import com.capstone.user.dto.LoginResponse;
import com.capstone.user.dto.UserDTO;
import com.capstone.user.entity.User;
import com.capstone.user.security.JwtUtil;
import com.capstone.user.service.UserService;
import java.util.List;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody UserDTO userDTO) {
        String result = userService.registerUser(userDTO);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginDTO loginDTO) {
        User user = userService.loginUser(loginDTO);
        if (user != null) {
            if (!"ACTIVE".equals(user.getStatus())) {
                return ResponseEntity.badRequest().body("Account is not active. Please wait for activation.");
            }

            String token = jwtUtil.generateToken(user.getUserName());
            LoginResponse response = new LoginResponse(
                    token,
                    "Login successful!",
                    user.getUserId(),
                    user.getUserName(),
                    user.getFirstName(),
                    user.getLastName(),
                    user.getEmail());
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.badRequest().body("Invalid Username or Password");
    }

    @GetMapping("/all")
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @GetMapping("/pending")
    public ResponseEntity<List<User>> getPendingUsers() {
        return ResponseEntity.ok(userService.getPendingUsers());
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        return ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/activate")
    public ResponseEntity<String> activateUser(@PathVariable Long id) {
        String result = userService.activateUser(id);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PutMapping("/{id}/deactivate")
    public ResponseEntity<String> deactivateUser(@PathVariable Long id) {
        String result = userService.deactivateUser(id);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }
}
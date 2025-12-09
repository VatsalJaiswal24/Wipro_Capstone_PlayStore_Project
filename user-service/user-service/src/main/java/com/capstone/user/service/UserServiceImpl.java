package com.capstone.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.capstone.user.dto.LoginDTO;
import com.capstone.user.dto.UserDTO;
import com.capstone.user.entity.User;
import com.capstone.user.repository.UserRepository;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RestTemplate restTemplate;

    private static final String NOTIFICATION_SERVICE_URL = "http://localhost:8083/api/notification";

    @Override
    public String registerUser(UserDTO userDTO) {
        
        if (userRepository.existsByUserName(userDTO.getUserName())) {
            return "Error: Username is already taken!";
        }

        if (userRepository.existsByEmail(userDTO.getEmail())) {
            return "Error: Email is already registered!";
        }

        User user = new User();
        user.setFirstName(userDTO.getFirstName());
        user.setLastName(userDTO.getLastName());
        user.setUserName(userDTO.getUserName());
        user.setEmail(userDTO.getEmail());
        user.setMobileNo(userDTO.getMobileNo());
        user.setAddress(userDTO.getAddress());
        user.setCity(userDTO.getCity());
        user.setState(userDTO.getState());
        user.setCountry(userDTO.getCountry());
        user.setPassword(passwordEncoder.encode(userDTO.getPassword()));

        userRepository.save(user);
        sendRegistrationEmail(user.getEmail(), user.getFirstName());

        return "Success: Registration submitted! Please wait for account activation.";
    }

    @Override
    public User loginUser(LoginDTO loginDTO) {
        Optional<User> userOptional = userRepository.findByUserName(loginDTO.getUserName());
        
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (passwordEncoder.matches(loginDTO.getPassword(), user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public List<User> getPendingUsers() {
        return userRepository.findByStatus("PENDING");
    }

    @Override
    public String activateUser(Long userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setStatus("ACTIVE");
            userRepository.save(user);
            return "Success: User " + user.getUserName() + " has been activated!";
        }
        return "Error: User not found!";
    }

    @Override
    public String deactivateUser(Long userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setStatus("INACTIVE");
            userRepository.save(user);
            return "Success: User " + user.getUserName() + " has been deactivated!";
        }
        return "Error: User not found!";
    }

    @Override
    public User getUserById(Long userId) {
        return userRepository.findById(userId).orElse(null);
    }

    private void sendRegistrationEmail(String email, String firstName) {
        try {
            Map<String, String> request = new HashMap<>();
            request.put("email", email);
            request.put("firstName", firstName);
            restTemplate.postForObject(NOTIFICATION_SERVICE_URL + "/registration", request, String.class);
        } catch (Exception e) {
            System.err.println("Failed to send registration email: " + e.getMessage());
        }
    }
}
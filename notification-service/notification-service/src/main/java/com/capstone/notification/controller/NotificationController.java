package com.capstone.notification.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.capstone.notification.dto.EmailRequest;
import com.capstone.notification.service.EmailService;

import java.util.Map;

@RestController
@RequestMapping("/api/notification")
@CrossOrigin(origins = "*")
public class NotificationController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/send")
    public String sendEmail(@RequestBody EmailRequest request) {
        return emailService.sendEmail(request);
    }

    @PostMapping("/registration")
    public String sendRegistrationNotification(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String firstName = request.get("firstName");
        return emailService.sendRegistrationEmail(email, firstName);
    }

    @PostMapping("/account-status")
    public String sendAccountStatusNotification(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String firstName = request.get("firstName");
        String status = request.get("status");
        return emailService.sendAccountStatusEmail(email, firstName, status);
    }

    @PostMapping("/app-download")
    public String sendAppDownloadNotification(@RequestBody Map<String, String> request) {
        String ownerEmail = request.get("ownerEmail");
        String ownerName = request.get("ownerName");
        String appName = request.get("appName");
        String userName = request.get("userName");
        return emailService.sendAppDownloadEmail(ownerEmail, ownerName, appName, userName);
    }
}
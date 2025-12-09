package com.capstone.notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.capstone.notification.dto.EmailRequest;
import com.capstone.notification.entity.Notification;
import com.capstone.notification.repository.NotificationRepository;

import java.time.LocalDateTime;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private NotificationRepository notificationRepository;

    private static final String FROM_EMAIL = "wiprovatsal@gmail.com";
    private static final String OWNER_CONTACT = "wiprovatsal@gmail.com";

    public String sendEmail(EmailRequest emailRequest) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(FROM_EMAIL);
            message.setTo(emailRequest.getTo());
            message.setSubject(emailRequest.getSubject());
            message.setText(emailRequest.getBody());
            mailSender.send(message);
            saveNotification(emailRequest.getTo(), emailRequest.getSubject(), emailRequest.getBody(), "SENT");
            return "Success: Email sent to " + emailRequest.getTo();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: Failed to send email. " + e.getMessage();
        }
    }

    public String sendRegistrationEmail(String email, String firstName) {
        String subject = "Welcome to PlayStore - Registration Successful!";
        String body = "Hi " + firstName + ",\n\n" +
                "Thank you for registering with PlayStore!\n\n" +
                "Your account has been created successfully and is currently PENDING APPROVAL.\n" +
                "An administrator will review and activate your account shortly.\n\n" +
                "Once activated, you will receive another email and can start browsing and installing apps.\n\n" +
                "Best regards,\n" +
                "Vatsal Jaiswal";
        return sendEmailInternal(email, subject, body);
    }

    public String sendAccountStatusEmail(String email, String firstName, String status) {
        String subject;
        String body;

        if ("ACTIVE".equalsIgnoreCase(status)) {
            subject = "PlayStore Account Activated!";
            body = "Hi " + firstName + ",\n\n" +
                    "Great news! Your PlayStore account has been ACTIVATED.\n\n" +
                    "You can now:\n" +
                    "- Browse all available apps\n" +
                    "- Install free and paid apps\n" +
                    "- Rate and review apps\n\n" +
                    "Start exploring: http://localhost:8081/store\n\n" +
                    "Best regards,\n" +
                    "Vatsal Jaiswal";
        } else {
            subject = "PlayStore Account Status Update";
            body = "Hi " + firstName + ",\n\n" +
                    "Your PlayStore account has been DEACTIVATED.\n\n" +
                    "If you believe this is a mistake or need assistance, please contact us at:\n" +
                    OWNER_CONTACT + "\n\n" +
                    "Best regards,\n" +
                    "Vatsal Jaiswal";
        }
        return sendEmailInternal(email, subject, body);
    }

    public String sendAppDownloadEmail(String ownerEmail, String ownerName, String appName, String userName) {
        String subject = "New Download: " + appName;
        String body = "Hi " + ownerName + ",\n\n" +
                "Great news! Your app \"" + appName + "\" was just installed!\n\n" +
                "Installed by: " + userName + "\n" +
                "Time: " + LocalDateTime.now().toString() + "\n\n" +
                "Keep up the great work!\n\n" +
                "Best regards,\n" +
                "Vatsal Jaiswal";
        return sendEmailInternal(ownerEmail, subject, body);
    }

    private String sendEmailInternal(String to, String subject, String body) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(FROM_EMAIL);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            mailSender.send(message);
            saveNotification(to, subject, body, "SENT");
            return "Success: Email sent to " + to;
        } catch (Exception e) {
            e.printStackTrace();
            saveNotification(to, subject, body, "FAILED");
            return "Error: Failed to send email. " + e.getMessage();
        }
    }

    private void saveNotification(String recipient, String subject, String message, String status) {
        Notification log = new Notification();
        log.setRecipient(recipient);
        log.setSubject(subject);
        log.setMessage(message);
        log.setSentTime(LocalDateTime.now());
        log.setStatus(status);
        notificationRepository.save(log);
    }
}
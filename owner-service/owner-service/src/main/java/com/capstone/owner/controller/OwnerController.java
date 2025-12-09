package com.capstone.owner.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.capstone.owner.dto.AppDetailsDTO;
import com.capstone.owner.dto.AppOwnerDTO;
import com.capstone.owner.dto.LoginDTO;
import com.capstone.owner.dto.LoginResponse;
import com.capstone.owner.dto.RatingDTO;
import com.capstone.owner.entity.AppDetails;
import com.capstone.owner.entity.AppOwner;
import com.capstone.owner.entity.Rating;
import com.capstone.owner.repository.AppRepository;
import com.capstone.owner.repository.RatingRepository;
import com.capstone.owner.security.JwtUtil;
import com.capstone.owner.service.OwnerService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/owner")
@CrossOrigin(origins = "*")
public class OwnerController {

    @Autowired
    private OwnerService ownerService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private RatingRepository ratingRepository;

    @Autowired
    private AppRepository appRepository;

    private RestTemplate restTemplate = new RestTemplate();

    private static final String USER_SERVICE_URL = "http://localhost:8081/api/users";
    private static final String NOTIFICATION_SERVICE_URL = "http://localhost:8083/api/notification";

    @PostMapping("/register")
    public ResponseEntity<String> registerOwner(@RequestBody AppOwnerDTO ownerDTO) {
        String result = ownerService.registerOwner(ownerDTO);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginOwner(@RequestBody LoginDTO loginDTO) {
        AppOwner owner = ownerService.loginOwner(loginDTO);
        if (owner != null) {
            String token = jwtUtil.generateToken(owner.getUserName());
            LoginResponse response = new LoginResponse(
                    token, "Login successful!",
                    owner.getAppOwnerId(), owner.getUserName(),
                    owner.getFirstName(), owner.getLastName(), owner.getEmail());
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.badRequest().body("Invalid Username or Password");
    }

    @PostMapping("/add-app")
    public ResponseEntity<String> addNewApp(@RequestBody AppDetailsDTO appDTO) {
        String result = ownerService.addNewApp(appDTO);
        if (result.startsWith("Error")) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok(result);
    }

    @GetMapping("/my-apps/{ownerId}")
    public ResponseEntity<List<AppDetails>> getMyApps(@PathVariable Long ownerId) {
        return ResponseEntity.ok(ownerService.getMyApps(ownerId));
    }

    @GetMapping("/apps/all")
    public ResponseEntity<List<AppDetails>> getAllApps() {
        return ResponseEntity.ok(ownerService.getAllApps());
    }

    @GetMapping("/apps/genre/{genre}")
    public ResponseEntity<List<AppDetails>> getAppsByGenre(@PathVariable String genre) {
        return ResponseEntity.ok(ownerService.getAppsByGenre(genre));
    }

    @GetMapping("/apps/{appId}")
    public ResponseEntity<AppDetails> getAppById(@PathVariable Long appId) {
        AppDetails app = ownerService.getAppById(appId);
        if (app != null) {
            return ResponseEntity.ok(app);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/apps/filter")
    public ResponseEntity<List<AppDetails>> filterAppsByRating(@RequestParam(defaultValue = "0") Double minRating) {
        return ResponseEntity.ok(appRepository.findByRatingGreaterThanEqual(minRating));
    }

    @PostMapping("/apps/{appId}/install")
    public ResponseEntity<?> installApp(@PathVariable Long appId, @RequestBody Map<String, Object> request) {
        try {
            Long userId = Long.parseLong(request.get("userId").toString());
            String userName = request.get("userName").toString();

            AppDetails app = ownerService.getAppById(appId);
            if (app == null) {
                return ResponseEntity.badRequest().body("App not found!");
            }

            app.setDownloadCount(app.getDownloadCount() + 1);
            appRepository.save(app);

            AppOwner owner = app.getAppOwner();
            if (owner != null && owner.getEmail() != null) {
                sendAppDownloadNotification(owner.getEmail(), owner.getFirstName(), app.getAppName(), userName);
            }

            return ResponseEntity.ok(Map.of(
                    "message", "App installed successfully!",
                    "downloadCount", app.getDownloadCount()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error installing app: " + e.getMessage());
        }
    }

    @PostMapping("/rate")
    public ResponseEntity<?> rateApp(@RequestBody RatingDTO ratingDTO) {
        try {
            if (ratingDTO.getStars() < 1 || ratingDTO.getStars() > 5) {
                return ResponseEntity.badRequest().body("Rating must be between 1 and 5 stars!");
            }

            Optional<Rating> existingRating = ratingRepository.findByAppIdAndUserId(
                    ratingDTO.getAppId(), ratingDTO.getUserId());

            Rating rating;
            if (existingRating.isPresent()) {
                rating = existingRating.get();
                rating.setStars(ratingDTO.getStars());
            } else {
                rating = new Rating();
                rating.setAppId(ratingDTO.getAppId());
                rating.setUserId(ratingDTO.getUserId());
                rating.setUserName(ratingDTO.getUserName());
                rating.setStars(ratingDTO.getStars());
            }
            ratingRepository.save(rating);

            updateAppAverageRating(ratingDTO.getAppId());

            return ResponseEntity.ok(Map.of(
                    "message", "Rating submitted successfully!",
                    "rating", rating.getStars()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error submitting rating: " + e.getMessage());
        }
    }

    @GetMapping("/ratings/{appId}")
    public ResponseEntity<List<Rating>> getAppRatings(@PathVariable Long appId) {
        return ResponseEntity.ok(ratingRepository.findByAppId(appId));
    }

    @GetMapping("/ratings/{appId}/summary")
    public ResponseEntity<?> getRatingSummary(@PathVariable Long appId) {
        Double avgRating = ratingRepository.getAverageRatingForApp(appId);
        Long ratingCount = ratingRepository.getRatingCountForApp(appId);
        return ResponseEntity.ok(Map.of(
                "appId", appId,
                "averageRating", avgRating != null ? avgRating : 0.0,
                "totalRatings", ratingCount != null ? ratingCount : 0));
    }

    private void updateAppAverageRating(Long appId) {
        Double avgRating = ratingRepository.getAverageRatingForApp(appId);
        if (avgRating != null) {
            AppDetails app = appRepository.findById(appId).orElse(null);
            if (app != null) {
                app.setRating(Math.round(avgRating * 10.0) / 10.0);
                appRepository.save(app);
            }
        }
    }

    @GetMapping("/users/all")
    public ResponseEntity<?> getAllUsers() {
        try {
            Object users = restTemplate.getForObject(USER_SERVICE_URL + "/all", Object.class);
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error fetching users: " + e.getMessage());
        }
    }

    @GetMapping("/users/pending")
    public ResponseEntity<?> getPendingUsers() {
        try {
            Object users = restTemplate.getForObject(USER_SERVICE_URL + "/pending", Object.class);
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error fetching pending users: " + e.getMessage());
        }
    }

    @PostMapping("/users/{userId}/activate")
    public ResponseEntity<?> activateUser(@PathVariable Long userId) {
        try {
            restTemplate.put(USER_SERVICE_URL + "/" + userId + "/activate", null);
            Map user = restTemplate.getForObject(USER_SERVICE_URL + "/" + userId, Map.class);
            if (user != null && user.get("email") != null) {
                sendAccountStatusNotification(
                        user.get("email").toString(),
                        user.get("firstName").toString(),
                        "ACTIVE");
            }
            return ResponseEntity.ok("User activated successfully!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error activating user: " + e.getMessage());
        }
    }

    @PostMapping("/users/{userId}/deactivate")
    public ResponseEntity<?> deactivateUser(@PathVariable Long userId) {
        try {
            Map user = restTemplate.getForObject(USER_SERVICE_URL + "/" + userId, Map.class);
            restTemplate.put(USER_SERVICE_URL + "/" + userId + "/deactivate", null);
            if (user != null && user.get("email") != null) {
                sendAccountStatusNotification(
                        user.get("email").toString(),
                        user.get("firstName").toString(),
                        "INACTIVE");
            }
            return ResponseEntity.ok("User deactivated successfully!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error deactivating user: " + e.getMessage());
        }
    }

    private void sendAccountStatusNotification(String email, String firstName, String status) {
        try {
            Map<String, String> request = new HashMap<>();
            request.put("email", email);
            request.put("firstName", firstName);
            request.put("status", status);
            restTemplate.postForObject(NOTIFICATION_SERVICE_URL + "/account-status", request, String.class);
        } catch (Exception e) {
            System.err.println("Failed to send account status email: " + e.getMessage());
        }
    }

    private void sendAppDownloadNotification(String ownerEmail, String ownerName, String appName, String userName) {
        try {
            Map<String, String> request = new HashMap<>();
            request.put("ownerEmail", ownerEmail);
            request.put("ownerName", ownerName);
            request.put("appName", appName);
            request.put("userName", userName);
            restTemplate.postForObject(NOTIFICATION_SERVICE_URL + "/app-download", request, String.class);
        } catch (Exception e) {
            System.err.println("Failed to send app download notification: " + e.getMessage());
        }
    }
}
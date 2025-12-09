# PlayStore Application - Complete Project Documentation

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture Diagram](#architecture-diagram)
3. [Microservices Overview](#microservices-overview)
4. [Database Schema](#database-schema)
5. [JWT Authentication Flow](#jwt-authentication-flow)
6. [User Service - Deep Dive](#user-service---deep-dive)
7. [Owner Service - Deep Dive](#owner-service---deep-dive)
8. [Notification Service - Deep Dive](#notification-service---deep-dive)
9. [Frontend (JSP) - How It Works](#frontend-jsp---how-it-works)
10. [API Endpoints Reference](#api-endpoints-reference)
11. [Complete User Flow](#complete-user-flow)

---

## 🎯 Project Overview

**PlayStore** is a microservices-based application store platform where:
- **Users** can browse, install, and rate applications
- **Owners (Developers)** can publish apps and manage users
- **Notifications** are sent via email for key events

### Technology Stack
| Layer | Technology |
|-------|-----------|
| Backend | Spring Boot 3.x, Spring Security 6, Spring Data JPA |
| Frontend | JSP (JavaServer Pages), HTML, CSS, JavaScript (Vanilla) |
| Database | MySQL (each service has its own database) |
| Security | JWT (JSON Web Tokens) with BCrypt password encoding |
| Email | JavaMail API with Gmail SMTP |
| Service Discovery | Eureka Server (optional) |

### Services & Ports
| Service | Port | Purpose |
|---------|------|---------|
| User Service | 8081 | User registration, login, profile |
| Owner Service | 8082 | App management, user activation, ratings |
| Notification Service | 8083 | Email notifications |
| Eureka Server | 8761 | Service discovery (optional) |

---

## 🏗️ Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              BROWSER (CLIENT)                                │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐         │
│  │  User Pages     │    │  Owner Pages    │    │  Store Pages    │         │
│  │  - Login        │    │  - Dashboard    │    │  - Browse Apps  │         │
│  │  - Register     │    │  - My Apps      │    │  - Install      │         │
│  │                 │    │  - Add App      │    │  - Rate Apps    │         │
│  │                 │    │  - Users        │    │                 │         │
│  └────────┬────────┘    └────────┬────────┘    └────────┬────────┘         │
│           │ HTTP + JWT           │ HTTP + JWT           │ HTTP              │
└───────────┼──────────────────────┼──────────────────────┼───────────────────┘
            │                      │                      │
            ▼                      ▼                      ▼
┌───────────────────────┐ ┌───────────────────────┐ ┌───────────────────────┐
│   USER SERVICE        │ │   OWNER SERVICE       │ │                       │
│   Port: 8081          │ │   Port: 8082          │ │                       │
│                       │ │                       │ │                       │
│ ┌───────────────────┐ │ │ ┌───────────────────┐ │ │                       │
│ │ UserController    │ │ │ │ OwnerController   │ │ │                       │
│ └─────────┬─────────┘ │ │ └─────────┬─────────┘ │ │                       │
│           ▼           │ │           ▼           │ │                       │
│ ┌───────────────────┐ │ │ ┌───────────────────┐ │ │                       │
│ │ UserServiceImpl   │ │ │ │ OwnerServiceImpl  │ │ │                       │
│ └─────────┬─────────┘ │ │ └─────────┬─────────┘ │ │                       │
│           ▼           │ │           ▼           │ │                       │
│ ┌───────────────────┐ │ │ ┌───────────────────┐ │ │                       │
│ │ UserRepository    │ │ │ │ AppRepository     │ │ │                       │
│ │ InstallationRepo  │ │ │ │ RatingRepository  │ │ │                       │
│ └─────────┬─────────┘ │ │ │ AppOwnerRepository│ │ │                       │
│           ▼           │ │ └─────────┬─────────┘ │ │                       │
│    ┌──────────┐       │ │           ▼           │ │                       │
│    │ MySQL DB │       │ │    ┌──────────┐       │ │                       │
│    │ user_db  │       │ │    │ MySQL DB │       │ │                       │
│    └──────────┘       │ │    │ owner_db │       │ │                       │
└───────────┬───────────┘ │    └──────────┘       │ │                       │
            │             └───────────┬───────────┘ │                       │
            │                         │             │                       │
            │    ┌────────────────────┼─────────────┘                       │
            │    │                    │                                      │
            ▼    ▼                    ▼                                      │
      ┌─────────────────────────────────────────┐                           │
      │       NOTIFICATION SERVICE              │                           │
      │              Port: 8083                 │                           │
      │                                         │                           │
      │  ┌──────────────────────────────────┐   │                           │
      │  │ NotificationController           │   │                           │
      │  │  - /registration                 │   │                           │
      │  │  - /account-status               │   │                           │
      │  │  - /app-download                 │   │                           │
      │  └───────────────┬──────────────────┘   │                           │
      │                  ▼                      │                           │
      │  ┌──────────────────────────────────┐   │                           │
      │  │ EmailService (JavaMailSender)    │   │                           │
      │  └───────────────┬──────────────────┘   │                           │
      │                  ▼                      │                           │
      │           ┌──────────────┐              │                           │
      │           │ Gmail SMTP   │              │                           │
      │           │ Server       │              │                           │
      │           └──────────────┘              │                           │
      └─────────────────────────────────────────┘                           │
```

---

## 🔐 JWT Authentication Flow

### What is JWT?
JWT (JSON Web Token) is a secure way to transmit information between parties. It consists of:
- **Header**: Algorithm used (HS256)
- **Payload**: User data (username, expiration)
- **Signature**: Verification hash

### How JWT Works in This Project:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         JWT AUTHENTICATION FLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

1. LOGIN REQUEST
   ┌──────────┐                              ┌──────────────────┐
   │  Client  │  POST /api/users/login       │   User Service   │
   │ (Browser)│  {username, password}        │                  │
   │          │ ─────────────────────────────▶                  │
   └──────────┘                              └────────┬─────────┘
                                                      │
2. VALIDATE CREDENTIALS                               ▼
   ┌───────────────────────────────────────────────────────────┐
   │ UserServiceImpl.loginUser()                               │
   │   1. Find user by username in database                    │
   │   2. Check password with BCrypt: passwordEncoder.matches()│
   │   3. If valid, return User object                         │
   └───────────────────────────────────────────────────────────┘
                                                      │
3. GENERATE JWT TOKEN                                 ▼
   ┌───────────────────────────────────────────────────────────┐
   │ JwtUtil.generateToken(username)                           │
   │   1. Create claims (empty map)                            │
   │   2. Set subject = username                               │
   │   3. Set issuedAt = now                                   │
   │   4. Set expiration = now + 10 hours                      │
   │   5. Sign with HMAC-SHA256 using secret key               │
   │   6. Return compact JWT string                            │
   └───────────────────────────────────────────────────────────┘
                                                      │
4. RETURN LOGIN RESPONSE                              ▼
   ┌──────────┐                              ┌──────────────────┐
   │  Client  │  RESPONSE:                   │   User Service   │
   │ (Browser)│  {                           │                  │
   │          │    token: "eyJhbG...",       │                  │
   │          │◀───userId: 1,                 │                  │
   │          │    userName: "john",         │                  │
   │          │    firstName: "John",        │                  │
   │          │    ...                       │                  │
   │          │  }                           │                  │
   └────┬─────┘                              └──────────────────┘
        │
5. STORE TOKEN IN BROWSER
   ┌───────────────────────────────────────────────────────────┐
   │ localStorage.setItem('token', response.token);            │
   │ localStorage.setItem('userId', response.userId);          │
   │ localStorage.setItem('userName', response.userName);      │
   └───────────────────────────────────────────────────────────┘
        │
6. SUBSEQUENT API REQUESTS (with JWT)
   ┌──────────┐                              ┌──────────────────┐
   │  Client  │  GET /api/users/all          │   User Service   │
   │ (Browser)│  Headers:                    │                  │
   │          │  Authorization: Bearer eyJ...│                  │
   │          │ ─────────────────────────────▶                  │
   └──────────┘                              └────────┬─────────┘
                                                      │
7. JWT FILTER VALIDATES TOKEN                         ▼
   ┌───────────────────────────────────────────────────────────┐
   │ JwtAuthFilter.doFilterInternal()                          │
   │   1. Extract "Bearer " token from Authorization header    │
   │   2. Call jwtUtil.extractUsername(token)                  │
   │   3. Load UserDetails from database                       │
   │   4. Validate token: jwtUtil.validateToken(token, user)   │
   │   5. If valid, set SecurityContext authentication         │
   │   6. Continue filter chain                                │
   └───────────────────────────────────────────────────────────┘
```

### JWT Code Breakdown:

**JwtUtil.java** - Token generation and validation:
```java
// SECRET KEY - Used to sign tokens (should be in env variable in production)
private static final String SECRET = "PlayStoreCapstoneSecretKeyForJWTTokenGeneration2024!";

// Token expiration - 10 hours
private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 10;

// Generate token for user
public String generateToken(String username) {
    return Jwts.builder()
        .subject(username)                    // Who this token is for
        .issuedAt(new Date())                 // When it was created
        .expiration(new Date(now + 10hrs))    // When it expires
        .signWith(getSigningKey())            // Sign with secret
        .compact();                           // Create string
}

// Validate token
public Boolean validateToken(String token, String username) {
    String extractedUsername = extractUsername(token);
    return extractedUsername.equals(username) && !isTokenExpired(token);
}
```

---

## 👤 User Service - Deep Dive

### Purpose
Handles all user-related operations: registration, login, profile management, and user status.

### Database: `user_db`

**Table: `users`**
| Column | Type | Description |
|--------|------|-------------|
| userId | BIGINT (PK) | Auto-generated ID |
| firstName | VARCHAR | User's first name |
| lastName | VARCHAR | User's last name |
| userName | VARCHAR (UNIQUE) | Login username |
| password | VARCHAR | BCrypt hashed password |
| email | VARCHAR (UNIQUE) | Email address |
| mobileNo | VARCHAR | Phone number |
| address, city, state, country | VARCHAR | Address fields |
| amount | DOUBLE | Wallet balance (default: 0.0) |
| accountType | VARCHAR | FREE or PAID (default: FREE) |
| status | VARCHAR | PENDING, ACTIVE, or INACTIVE |
| dateOfOpen | DATETIME | Registration timestamp |

**Table: `installation`**
| Column | Type | Description |
|--------|------|-------------|
| installationId | BIGINT (PK) | Auto-generated ID |
| userId | BIGINT | Reference to user |
| appId | BIGINT | Reference to app |
| installedAt | DATETIME | Installation timestamp |

### API Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/users/register` | Register new user | No |
| POST | `/api/users/login` | Login and get JWT | No |
| GET | `/api/users/all` | Get all users | No* |
| GET | `/api/users/pending` | Get pending users | No* |
| GET | `/api/users/{id}` | Get user by ID | No* |
| PUT | `/api/users/{id}/activate` | Activate user | No* |
| PUT | `/api/users/{id}/deactivate` | Deactivate user | No* |

*These are public because Owner Service calls them internally.

### Registration Flow:
```
1. User fills registration form (register.jsp)
2. JavaScript sends POST to /api/users/register
3. UserController.registerUser(UserDTO) receives request
4. UserServiceImpl.registerUser():
   a. Check if username exists → Error if yes
   b. Check if email exists → Error if yes
   c. Create User entity
   d. Hash password: passwordEncoder.encode(password)
   e. Set status = "PENDING" (default)
   f. Save to database
   g. Call Notification Service to send welcome email
   h. Return success message
5. User sees "Registration successful, wait for activation"
```

### Login Flow:
```
1. User enters credentials (login.jsp)
2. JavaScript sends POST to /api/users/login
3. UserController.loginUser(LoginDTO):
   a. Call userService.loginUser()
   b. Find user by username
   c. Verify password with BCrypt
   d. Check if status is "ACTIVE"
   e. Generate JWT token
   f. Return LoginResponse with token + user details
4. JavaScript stores token in localStorage
5. Redirect to store page
```

---

## 🏢 Owner Service - Deep Dive

### Purpose
Handles app management, owner authentication, user activation, and the rating system.

### Database: `owner_db`

**Table: `app_owner`**
| Column | Type | Description |
|--------|------|-------------|
| appOwnerId | BIGINT (PK) | Auto-generated ID |
| firstName, lastName | VARCHAR | Owner name |
| userName | VARCHAR (UNIQUE) | Login username |
| password | VARCHAR | BCrypt hashed password |
| email | VARCHAR | Contact email |
| mobileNo | VARCHAR | Phone number |
| address, city, state, country | VARCHAR | Address fields |

**Table: `app_details`**
| Column | Type | Description |
|--------|------|-------------|
| appId | BIGINT (PK) | Auto-generated ID |
| appName | VARCHAR | Application name |
| description | TEXT | App description |
| version | VARCHAR | Version number (e.g., "1.0.0") |
| genre | VARCHAR | Category (Games, Education, etc.) |
| appType | VARCHAR | FREE or PAID |
| price | DOUBLE | Price if paid (default: 0.0) |
| rating | DOUBLE | Average rating (1-5 stars) |
| downloadCount | BIGINT | Total installs |
| releaseDate | DATE | When app was published |
| isActive | BOOLEAN | Visibility flag |
| app_owner_id | BIGINT (FK) | Reference to owner |

**Table: `app_rating`**
| Column | Type | Description |
|--------|------|-------------|
| ratingId | BIGINT (PK) | Auto-generated ID |
| appId | BIGINT | Reference to app |
| userId | BIGINT | Reference to user who rated |
| userName | VARCHAR | User's display name |
| stars | INT | Rating value (1-5) |
| createdAt | DATETIME | When rating was submitted |
| updatedAt | DATETIME | When rating was last changed |

### API Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/owner/register` | Register new owner | No |
| POST | `/api/owner/login` | Login and get JWT | No |
| POST | `/api/owner/add-app` | Publish new app | Yes |
| GET | `/api/owner/my-apps/{ownerId}` | Get owner's apps | No* |
| GET | `/api/owner/apps/all` | Get all apps (store) | No |
| GET | `/api/owner/apps/{appId}` | Get app details | No |
| GET | `/api/owner/apps/genre/{genre}` | Filter by category | No |
| GET | `/api/owner/apps/filter?minRating=X` | Filter by rating | No |
| POST | `/api/owner/apps/{appId}/install` | Install an app | No |
| POST | `/api/owner/rate` | Submit/update rating | No |
| GET | `/api/owner/ratings/{appId}` | Get app ratings | No |
| GET | `/api/owner/ratings/{appId}/summary` | Get avg rating | No |
| GET | `/api/owner/users/all` | Get all users | No* |
| GET | `/api/owner/users/pending` | Get pending users | No* |
| POST | `/api/owner/users/{id}/activate` | Activate user | No* |
| POST | `/api/owner/users/{id}/deactivate` | Deactivate user | No* |

### Add App Flow:
```
1. Owner fills form (add-app.jsp)
2. JavaScript sends POST to /api/owner/add-app
3. OwnerController.addNewApp(AppDetailsDTO):
   a. Find owner by appOwnerId
   b. Create AppDetails entity
   c. Set releaseDate = today
   d. Set rating = 0.0, downloadCount = 0
   e. Link to owner: app.setAppOwner(owner)
   f. Save to database
   g. Return success
```

### Rating System Flow:
```
1. User clicks star rating in store.jsp
2. JavaScript sends POST to /api/owner/rate
   {appId: 1, userId: 5, userName: "John", stars: 4}
3. OwnerController.rateApp(RatingDTO):
   a. Validate stars is 1-5
   b. Check if user already rated this app
   c. If exists: UPDATE existing rating
   d. If not: CREATE new rating
   e. Save rating to database
   f. Call updateAppAverageRating(appId):
      - Calculate AVG(stars) for this app
      - Update app.rating field
      - Save app
   g. Return success
```

### User Activation Flow (Owner activates User):
```
1. Owner sees pending users in dashboard
2. Clicks "Activate" button
3. JavaScript sends POST to /api/owner/users/{id}/activate
4. OwnerController.activateUser(userId):
   a. Call User Service: PUT /api/users/{id}/activate
   b. User Service updates status to "ACTIVE"
   c. Get user details from User Service
   d. Call Notification Service: POST /notification/account-status
   e. User receives "Account Activated" email
   f. Return success to Owner dashboard
```

---

## 📧 Notification Service - Deep Dive

### Purpose
Sends email notifications for key events using Gmail SMTP.

### Database: `notification_db`

**Table: `notifications`** (logs all sent emails)
| Column | Type | Description |
|--------|------|-------------|
| id | BIGINT (PK) | Auto-generated ID |
| recipient | VARCHAR | Email address |
| subject | VARCHAR | Email subject line |
| message | TEXT | Email body content |
| sentTime | DATETIME | When email was sent |
| status | VARCHAR | SENT or FAILED |

### Configuration (application.properties):
```properties
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=wiprovatsal@gmail.com
spring.mail.password= # App password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
```

### API Endpoints

| Method | Endpoint | Triggered By | Description |
|--------|----------|-------------|-------------|
| POST | `/api/notification/registration` | User Service | Welcome email after registration |
| POST | `/api/notification/account-status` | Owner Service | Activation/deactivation email |
| POST | `/api/notification/app-download` | Owner Service | Notify owner when app is installed |

### Email Templates:

**Registration Email:**
```
Subject: Welcome to PlayStore - Registration Successful!

Hi Khushi,

Thank you for registering with PlayStore!

Your account has been created successfully and is currently PENDING APPROVAL.
An administrator will review and activate your account shortly.

Once activated, you will receive another email and can start browsing apps.

Best regards,
Vatsal Jaiswal
```

**Account Activated Email:**
```
Subject: PlayStore Account Activated!

Hi Kanchan,

Great news! Your PlayStore account has been ACTIVATED.

You can now:
- Browse all available apps
- Install free and paid apps
- Rate and review apps

Start exploring: http://localhost:8081/store

Best regards,
Vatsal Jaiswal
```

**App Download Email (to Owner):**
```
Subject: New Download: Angry Birds

Hi Developer,

Great news! Your app "Angry Birds" was just installed!

Installed by: John
Time: 2025-12-08T09:30:00

Keep up the great work!

Best regards,
Vatsal Jaiswal
```

---

## 🖥️ Frontend (JSP) - How It Works

### JSP Page Mapping

| URL | JSP File | Service | Purpose |
|-----|----------|---------|---------|
| `http://localhost:8081/` | index.jsp | User | Landing page |
| `http://localhost:8081/login` | login.jsp | User | User login |
| `http://localhost:8081/register` | register.jsp | User | User registration |
| `http://localhost:8081/store` | store.jsp | User | App store |
| `http://localhost:8082/` | index.jsp | Owner | Owner landing |
| `http://localhost:8082/login` | login.jsp | Owner | Owner login |
| `http://localhost:8082/register` | register.jsp | Owner | Owner registration |
| `http://localhost:8082/dashboard` | dashboard.jsp | Owner | Dashboard |
| `http://localhost:8082/my-apps` | my-apps.jsp | Owner | Manage apps |
| `http://localhost:8082/add-app` | add-app.jsp | Owner | Publish new app |
| `http://localhost:8082/users` | users.jsp | Owner | Manage users |

### How JSP Pages Work:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          JSP PAGE ARCHITECTURE                               │
└─────────────────────────────────────────────────────────────────────────────┘

1. URL REQUEST
   Browser requests: http://localhost:8081/store
                           │
                           ▼
2. SPRING MVC ROUTING
   ┌──────────────────────────────────────────────┐
   │ PageController.java                          │
   │                                              │
   │ @GetMapping("/store")                        │
   │ public String store() {                      │
   │     return "store";  // → store.jsp          │
   │ }                                            │
   └──────────────────────────────────────────────┘
                           │
                           ▼
3. JSP RENDERING
   ┌──────────────────────────────────────────────┐
   │ /WEB-INF/views/store.jsp                     │
   │                                              │
   │ Contains:                                    │
   │ - HTML structure                             │
   │ - CSS styles (embedded)                      │
   │ - JavaScript for API calls                   │
   └──────────────────────────────────────────────┘
                           │
                           ▼
4. PAGE LOADS IN BROWSER
   ┌──────────────────────────────────────────────┐
   │ JavaScript executes:                         │
   │                                              │
   │ // On page load, fetch apps from API         │
   │ fetch('http://localhost:8082/api/owner/apps/all')
   │   .then(res => res.json())                   │
   │   .then(apps => renderApps(apps));           │
   └──────────────────────────────────────────────┘
```

### Button Click → API Call Example (Store Page):

**Install Button:**
```javascript
// HTML (generated by JavaScript)
<button onclick="installApp(1, 'Angry Birds')">Install</button>

// JavaScript function
function installApp(appId, appName) {
    // 1. Check if user is logged in
    var token = localStorage.getItem('token');
    var userId = localStorage.getItem('userId');
    
    if (!token || !userId) {
        showAlert('Please login to install apps!', 'error');
        return;
    }
    
    // 2. Send POST request to Owner Service
    fetch('http://localhost:8082/api/owner/apps/' + appId + '/install', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            userId: userId,
            userName: localStorage.getItem('userName')
        })
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        // 3. Update UI
        showAlert('App installed successfully!', 'success');
        // Button changes to "Installed ✓"
    });
}
```

**Rating Stars:**
```javascript
// HTML (generated by JavaScript)
<span class="star" onclick="rateApp(1, 4)">★</span>

// JavaScript function
function rateApp(appId, stars) {
    var userId = localStorage.getItem('userId');
    var userName = localStorage.getItem('userName');
    
    fetch('http://localhost:8082/api/owner/rate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            appId: appId,
            userId: userId,
            userName: userName,
            stars: stars
        })
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        showAlert('Rated ' + stars + ' stars!', 'success');
        // Reload apps to show updated average
        loadApps();
    });
}
```

### LocalStorage Usage:

After login, these values are stored in browser's localStorage:
```javascript
// User Login stores:
localStorage.setItem('token', 'eyJhbGciOiJIUzI1...');
localStorage.setItem('userId', '5');
localStorage.setItem('userName', 'john123');
localStorage.setItem('firstName', 'John');
localStorage.setItem('userStatus', 'ACTIVE');

// Owner Login stores:
localStorage.setItem('ownerToken', 'eyJhbGciOiJIUzI1...');
localStorage.setItem('ownerId', '1');
localStorage.setItem('ownerFirstName', 'Developer');
```

### Logout Function:
```javascript
function logout() {
    localStorage.clear();  // Remove all stored data
    window.location.href = '/login';  // Redirect to login
}
```

---

## 🔄 Complete User Flow

### Scenario: New User Registers, Gets Activated, Installs and Rates an App

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 1: USER REGISTRATION                                                   │
└─────────────────────────────────────────────────────────────────────────────┘

1. User visits http://localhost:8081/register
2. Fills form: John, Doe, john123, password123, john@email.com...
3. Clicks "Register"
4. Request: POST /api/users/register → User Service
5. User Service:
   - Creates user with status="PENDING"
   - Calls Notification Service
6. Notification Service sends email: "Welcome, account pending..."
7. User sees: "Registration successful! Please wait for activation."


┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 2: OWNER ACTIVATES USER                                                │
└─────────────────────────────────────────────────────────────────────────────┘

1. Owner logs in at http://localhost:8082/login
2. Goes to Dashboard → sees "Pending Users: 1"
3. Clicks "Users" in navigation
4. Sees John in pending list
5. Clicks "Activate" button
6. Request: POST /api/owner/users/5/activate → Owner Service
7. Owner Service:
   - Calls User Service: PUT /api/users/5/activate
   - User Service changes status to "ACTIVE"
   - Calls Notification Service
8. Notification Service sends email: "Your account is activated!"
9. Owner sees: "User activated successfully!"


┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 3: USER LOGS IN                                                        │
└─────────────────────────────────────────────────────────────────────────────┘

1. User visits http://localhost:8081/login
2. Enters: john123, password123
3. Request: POST /api/users/login → User Service
4. User Service:
   - Validates credentials
   - Checks status == "ACTIVE" ✓
   - Generates JWT token
5. Response: {token: "eyJ...", userId: 5, userName: "john123", ...}
6. JavaScript stores in localStorage
7. Redirects to http://localhost:8081/store


┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 4: USER BROWSES AND INSTALLS APP                                       │
└─────────────────────────────────────────────────────────────────────────────┘

1. Store page loads
2. JavaScript calls: GET /api/owner/apps/all → Owner Service
3. Owner Service returns all apps
4. JavaScript renders app cards with Install buttons
5. User clicks "Install" on "Angry Birds"
6. Request: POST /api/owner/apps/1/install → Owner Service
   Body: {userId: 5, userName: "john123"}
7. Owner Service:
   - Increments downloadCount
   - Calls Notification Service: /app-download
8. Notification Service emails owner: "John installed Angry Birds!"
9. User sees: "App installed successfully!"


┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 5: USER RATES APP                                                      │
└─────────────────────────────────────────────────────────────────────────────┘

1. User clicks 4th star on "Angry Birds"
2. Request: POST /api/owner/rate → Owner Service
   Body: {appId: 1, userId: 5, userName: "john123", stars: 4}
3. Owner Service:
   - Creates/updates Rating record
   - Recalculates average: AVG(all ratings for appId=1)
   - Updates app.rating = new average
4. User sees: "Rated 4 stars!"
5. App card updates to show new average rating


┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 6: OWNER VIEWS RATINGS                                                 │
└─────────────────────────────────────────────────────────────────────────────┘

1. Owner logs in and goes to Dashboard
2. Dashboard loads owner's apps
3. For each app, calls: GET /api/owner/ratings/{appId}
4. Displays "Recent Ratings" table:
   | App Name    | User   | Rating | Date       |
   | Angry Birds | john123| ★★★★☆  | 2025-12-08 |
5. Stats card shows: "Avg Rating: 4.0"
```

---

## 📊 Security Configuration

### SecurityConfig.java - What's Permitted vs Protected

```java
.authorizeHttpRequests(auth -> auth
    // PUBLIC - No authentication required
    .requestMatchers("/api/users/register", "/api/users/login").permitAll()
    .requestMatchers("/api/owner/apps/**").permitAll()  // Store browsing
    .requestMatchers("/api/owner/rate", "/api/owner/ratings/**").permitAll()  // Rating
    .requestMatchers("/api/owner/users/**").permitAll()  // User management
    .requestMatchers("/", "/login", "/register", "/store", "/dashboard").permitAll()  // Pages
    
    // PROTECTED - Requires valid JWT
    .anyRequest().authenticated()
)
```

### Password Encoding
```java
// Registration - Hash the password
user.setPassword(passwordEncoder.encode("password123"));
// Stored as: $2a$10$N9qo8uLOickgx2ZMRZoMy...

// Login - Verify the password
if (passwordEncoder.matches("password123", user.getPassword())) {
    // Password correct!
}
```

---

## 🎨 UI Design Philosophy

The application uses a **modern dark theme** with:
- **Gradient backgrounds**: `linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f0f1a 100%)`
- **Glassmorphism effects**: Semi-transparent cards with blur
- **Accent colors**: 
  - Cyan: `#00d9ff` (primary actions)
  - Pink: `#ff2e63` (branding, logout)
  - Yellow: `#ffc107` (ratings/stars)
  - Green: `#00ff88` (success states)
- **Responsive grid**: `grid-template-columns: repeat(auto-fill, minmax(320px, 1fr))`
- **Smooth transitions**: `transition: all 0.3s;`
- **Hover effects**: Cards lift up, buttons scale

---

## 🚀 How to Run the Project

1. **Start Services in Order:**
   ```bash
   # Terminal 1 - Eureka (optional)
   cd Eureka-service/Eureka-service
   mvn spring-boot:run
   
   # Terminal 2 - Notification Service
   cd notification-service/notification-service
   mvn spring-boot:run
   
   # Terminal 3 - User Service
   cd user-service/user-service
   mvn spring-boot:run
   
   # Terminal 4 - Owner Service
   cd owner-service/owner-service
   mvn spring-boot:run
   ```

2. **Access URLs:**
   - User Portal: http://localhost:8081/
   - Owner Portal: http://localhost:8082/
   - Eureka Dashboard: http://localhost:8761/ (if running)

---

## 📝 Summary

This PlayStore application demonstrates:

1. **Microservices Architecture** - Independent services with their own databases
2. **JWT Authentication** - Secure, stateless authentication
3. **Inter-service Communication** - Services calling each other via REST APIs
4. **Email Notifications** - Real email sending with JavaMail
5. **Modern UI** - Responsive, animated, dark-themed interface
6. **CRUD Operations** - Full create/read/update for users, apps, ratings
7. **Role-based Access** - Users browse/install, Owners manage
8. **Spring Security** - Request filtering and authorization

The project follows clean code principles with:
- Layered architecture (Controller → Service → Repository)
- DTOs for data transfer
- Entities for database mapping
- Proper separation of concerns

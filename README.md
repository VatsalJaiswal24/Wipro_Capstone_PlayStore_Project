# 🎮 PlayStore - Microservices Application Store

A full-stack microservices-based application store platform built with **Spring Boot** and **JSP**. Users can browse, install, and rate applications while developers (owners) can publish and manage their apps.

![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![JWT](https://img.shields.io/badge/JWT-Authentication-purple)

---

## 📋 Table of Contents
- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Running the Application](#-running-the-application)
- [API Documentation](#-api-documentation)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Author](#-author)

---

## ✨ Features

### For Users
- 📝 User registration with email verification
- 🔐 Secure login with JWT authentication
- 🏪 Browse all available applications
- 🔍 Filter apps by genre and rating
- ⬇️ Install applications
- ⭐ Rate and review apps (1-5 stars)
- 🚪 Secure logout

### For Developers (Owners)
- 📝 Developer registration
- 🔐 Secure login with JWT authentication
- 📱 Publish new applications
- 📊 Dashboard with statistics (total apps, downloads, ratings)
- 👥 User management (activate/deactivate users)
- 📧 Email notifications for app downloads
- 📈 View ratings and reviews

### Email Notifications
- 📨 Welcome email on registration
- ✅ Account activation notification
- ⬇️ App download notification to developers

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        BROWSER                               │
│     User Pages (8081)  │  Owner Pages (8082)                │
└────────────┬───────────┴────────────┬───────────────────────┘
             │                        │
             ▼                        ▼
┌─────────────────────┐    ┌─────────────────────┐
│   USER SERVICE      │    │   OWNER SERVICE     │
│   Port: 8081        │◄──►│   Port: 8082        │
│   - Registration    │    │   - App Management  │
│   - Login/JWT       │    │   - User Activation │
│   - Profile         │    │   - Ratings         │
└──────────┬──────────┘    └──────────┬──────────┘
           │                          │
           └──────────┬───────────────┘
                      ▼
         ┌─────────────────────┐
         │ NOTIFICATION SERVICE│
         │     Port: 8083      │
         │   - Email Sending   │
         │   - Gmail SMTP      │
         └─────────────────────┘
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Backend** | Spring Boot 3.x, Spring Security 6, Spring Data JPA |
| **Frontend** | JSP, HTML5, CSS3, JavaScript (Vanilla) |
| **Database** | MySQL 8.0 |
| **Security** | JWT (JSON Web Tokens), BCrypt |
| **Email** | JavaMail API, Gmail SMTP |
| **Build Tool** | Maven |
| **Service Discovery** | Netflix Eureka (Optional) |

---

## 📋 Prerequisites

Before running this project, make sure you have:

- ☕ **Java 17** or higher
- 🔧 **Maven 3.6+**
- 🐬 **MySQL 8.0+**
- 📧 **Gmail account** (for email notifications)

---

## 🚀 Installation

### 1. Clone the Repository.
```bash
git clone https://github.com/VatsalJaiswal24/PlayStore-Microservices.git
cd PlayStore-Microservices
```

### 2. Create MySQL Databases
```sql
CREATE DATABASE user_db;
CREATE DATABASE owner_db;
CREATE DATABASE notification_db;
```

### 3. Configure Database Connection

Update `application.properties` in each service:

**user-service/src/main/resources/application.properties:**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/user_db
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

**owner-service/src/main/resources/application.properties:**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/owner_db
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

**notification-service/src/main/resources/application.properties:**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/notification_db
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

# Gmail SMTP Configuration
spring.mail.username=YOUR_EMAIL@gmail.com
spring.mail.password=YOUR_APP_PASSWORD
```

> ⚠️ **Note:** For Gmail, you need to generate an [App Password](https://support.google.com/accounts/answer/185833)

---

## ▶️ Running the Application

### Option 1: Using Maven (Recommended)

Open **4 separate terminals** and run each service:

```bash
# Terminal 1 - Eureka Server (Optional)
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

### Option 2: Using JAR files

```bash
# Build all services
mvn clean package -DskipTests

# Run each service
java -jar user-service/target/user-service-0.0.1-SNAPSHOT.jar
java -jar owner-service/target/owner-service-0.0.1-SNAPSHOT.jar
java -jar notification-service/target/notification-service-0.0.1-SNAPSHOT.jar
```

### 🌐 Access URLs

| Service | URL |
|---------|-----|
| User Portal | http://localhost:8081/ |
| Owner Portal | http://localhost:8082/ |
| Eureka Dashboard | http://localhost:8761/ |

---

## 📚 API Documentation

### User Service APIs (Port 8081)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/users/register` | Register new user |
| POST | `/api/users/login` | Login and get JWT |
| GET | `/api/users/all` | Get all users |
| GET | `/api/users/pending` | Get pending users |
| PUT | `/api/users/{id}/activate` | Activate user |
| PUT | `/api/users/{id}/deactivate` | Deactivate user |

### Owner Service APIs (Port 8082)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/owner/register` | Register developer |
| POST | `/api/owner/login` | Login and get JWT |
| POST | `/api/owner/add-app` | Publish new app |
| GET | `/api/owner/apps/all` | Get all apps |
| GET | `/api/owner/apps/{id}` | Get app by ID |
| POST | `/api/owner/apps/{id}/install` | Install an app |
| POST | `/api/owner/rate` | Rate an app |
| GET | `/api/owner/ratings/{appId}` | Get app ratings |

### Notification Service APIs (Port 8083)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/notification/registration` | Send welcome email |
| POST | `/api/notification/account-status` | Send activation email |
| POST | `/api/notification/app-download` | Notify developer |

---

## 📸 Screenshots

### User Portal
- **Home Page** - Landing page with login/register options
- **Store Page** - Browse and install applications
- **Rating System** - Rate apps with 1-5 stars

### Owner Portal
- **Dashboard** - Overview of apps, downloads, and ratings
- **My Apps** - Manage published applications
- **Add App** - Form to publish new apps
- **User Management** - Activate/deactivate users

---

## 📁 Project Structure

```
Capstone/
├── 📂 Eureka-service/          # Service Discovery (Optional)
│   └── Eureka-service/
│       └── src/main/java/...
│
├── 📂 user-service/            # User Management Service
│   └── user-service/
│       ├── src/main/java/com/capstone/user/
│       │   ├── controller/     # REST Controllers
│       │   ├── service/        # Business Logic
│       │   ├── repository/     # Database Access
│       │   ├── entity/         # JPA Entities
│       │   ├── dto/            # Data Transfer Objects
│       │   └── security/       # JWT & Security Config
│       └── src/main/webapp/WEB-INF/views/
│           ├── index.jsp       # Home Page
│           ├── login.jsp       # Login Page
│           ├── register.jsp    # Registration Page
│           └── store.jsp       # App Store Page
│
├── 📂 owner-service/           # App & Owner Management
│   └── owner-service/
│       ├── src/main/java/com/capstone/owner/
│       │   ├── controller/
│       │   ├── service/
│       │   ├── repository/
│       │   ├── entity/
│       │   ├── dto/
│       │   └── security/
│       └── src/main/webapp/WEB-INF/views/
│           ├── index.jsp       # Owner Home
│           ├── login.jsp       # Owner Login
│           ├── register.jsp    # Owner Registration
│           ├── dashboard.jsp   # Dashboard
│           ├── my-apps.jsp     # Manage Apps
│           ├── add-app.jsp     # Add New App
│           └── users.jsp       # User Management
│
├── 📂 notification-service/    # Email Notification Service
│   └── notification-service/
│       └── src/main/java/com/capstone/notification/
│           ├── controller/
│           ├── service/
│           ├── entity/
│           └── dto/
│
├── 📄 README.md                # This file
├── 📄 .gitignore               # Git ignore rules
└── 📄 project_documentation.md # Detailed documentation
```

---

## 🔐 Security Features

- **JWT Authentication** - Stateless token-based authentication
- **BCrypt Password Encoding** - Secure password hashing
- **Spring Security 6** - Request filtering and authorization
- **CORS Configuration** - Cross-origin resource sharing

---

## 💡 Key Design Decisions

1. **Microservices Architecture** - Independent, loosely coupled services
2. **Separate Databases** - Each service has its own database
3. **REST APIs** - Standard HTTP methods for communication
4. **JWT Tokens** - 10-hour expiration for security
5. **Public Rating System** - Users can rate without installing

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👨‍💻 Author

**Vatsal Jaiswal**

- GitHub: [@VatsalJaiswal24](https://github.com/VatsalJaiswal24)
- Email: wiprovatsal@gmail.com

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Spring Boot Documentation
- JWT.io for JWT implementation reference
- Wipro Training Program

---

Made with ❤️ by Vatsal Jaiswal | © 2025 All Rights Reserved

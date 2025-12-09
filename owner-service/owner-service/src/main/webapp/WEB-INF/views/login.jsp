<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Owner Login - PlayStore</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, #0f0f1a 0%, #1a1a2e 50%, #16213e 100%);
                color: #ffffff;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .bg-orb {
                position: fixed;
                border-radius: 50%;
                filter: blur(80px);
                z-index: -1;
            }

            .bg-orb.pink {
                width: 400px;
                height: 400px;
                background: rgba(255, 46, 99, 0.15);
                top: -100px;
                right: -100px;
                animation: pulse 8s ease-in-out infinite;
            }

            .bg-orb.cyan {
                width: 300px;
                height: 300px;
                background: rgba(0, 217, 255, 0.12);
                bottom: -50px;
                left: -50px;
                animation: pulse 6s ease-in-out infinite reverse;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.1);
                }
            }

            .login-container {
                width: 100%;
                max-width: 450px;
            }

            .login-card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 24px;
                padding: 3rem;
                backdrop-filter: blur(20px);
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            }

            .logo {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo a {
                font-size: 2rem;
                font-weight: 800;
                background: linear-gradient(90deg, #ff2e63, #00d9ff);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-decoration: none;
            }

            .logo span {
                display: block;
                font-size: 0.85rem;
                font-weight: 400;
                color: rgba(255, 255, 255, 0.5);
                margin-top: 0.25rem;
            }

            h1 {
                font-size: 1.8rem;
                font-weight: 700;
                text-align: center;
                margin-bottom: 0.5rem;
            }

            .subtitle {
                text-align: center;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: rgba(255, 255, 255, 0.9);
            }

            .form-group input {
                width: 100%;
                padding: 1rem 1.25rem;
                font-size: 1rem;
                font-family: inherit;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                color: #ffffff;
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                outline: none;
                border-color: #ff2e63;
                box-shadow: 0 0 0 3px rgba(255, 46, 99, 0.1);
            }

            .form-group input::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .btn-login {
                width: 100%;
                padding: 1rem;
                font-size: 1rem;
                font-weight: 600;
                font-family: inherit;
                background: linear-gradient(135deg, #ff2e63 0%, #ff6b6b 100%);
                color: #ffffff;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 1rem;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(255, 46, 99, 0.3);
            }

            .btn-login:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 2rem 0;
                color: rgba(255, 255, 255, 0.4);
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: rgba(255, 255, 255, 0.1);
            }

            .divider span {
                padding: 0 1rem;
                font-size: 0.9rem;
            }

            .register-link {
                text-align: center;
            }

            .register-link a {
                color: #00d9ff;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .register-link a:hover {
                color: #33e4ff;
            }

            .alert {
                padding: 1rem;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                display: none;
            }

            .alert.error {
                background: rgba(255, 46, 99, 0.1);
                border: 1px solid rgba(255, 46, 99, 0.3);
                color: #ff2e63;
            }

            .alert.success {
                background: rgba(0, 255, 136, 0.1);
                border: 1px solid rgba(0, 255, 136, 0.3);
                color: #00ff88;
            }

            .spinner {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                border-top-color: #ffffff;
                animation: spin 0.8s linear infinite;
                margin-right: 0.5rem;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>

    <body>
        <div class="bg-orb pink"></div>
        <div class="bg-orb cyan"></div>

        <div class="login-container">
            <div class="login-card">
                <div class="logo">
                    <a href="/">PlayStore</a>
                    <span>Developer Portal</span>
                </div>

                <h1>Welcome Back</h1>
                <p class="subtitle">Sign in to manage your applications</p>

                <div id="alertBox" class="alert"></div>

                <form id="loginForm">
                    <div class="form-group">
                        <label for="userName">Username</label>
                        <input type="text" id="userName" name="userName" placeholder="Enter your username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <button type="submit" class="btn-login" id="loginBtn">Sign In</button>
                </form>

                <div class="divider"><span>New developer?</span></div>

                <p class="register-link">
                    <a href="/register">Create a developer account →</a>
                </p>
            </div>
        </div>

        <script>
            const form = document.getElementById('loginForm');
            const alertBox = document.getElementById('alertBox');
            const loginBtn = document.getElementById('loginBtn');

            form.addEventListener('submit', async (e) => {
                e.preventDefault();

                const userName = document.getElementById('userName').value;
                const password = document.getElementById('password').value;

                loginBtn.disabled = true;
                loginBtn.innerHTML = '<span class="spinner"></span>Signing in...';
                alertBox.style.display = 'none';

                try {
                    const response = await fetch('/api/owner/login', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ userName, password })
                    });

                    const data = await response.json();

                    if (response.ok) {
                        localStorage.setItem('ownerToken', data.token);
                        localStorage.setItem('ownerId', data.ownerId);
                        localStorage.setItem('ownerUserName', data.userName);
                        localStorage.setItem('ownerFirstName', data.firstName);
                        localStorage.setItem('ownerLastName', data.lastName);
                        localStorage.setItem('ownerEmail', data.email);

                        alertBox.className = 'alert success';
                        alertBox.textContent = 'Login successful! Redirecting...';
                        alertBox.style.display = 'block';

                        setTimeout(() => { window.location.href = '/dashboard'; }, 1000);
                    } else {
                        throw new Error(data.message || data || 'Invalid credentials');
                    }
                } catch (error) {
                    alertBox.className = 'alert error';
                    alertBox.textContent = error.message || 'Login failed. Please try again.';
                    alertBox.style.display = 'block';
                    loginBtn.disabled = false;
                    loginBtn.textContent = 'Sign In';
                }
            });
        </script>
    </body>

    </html>
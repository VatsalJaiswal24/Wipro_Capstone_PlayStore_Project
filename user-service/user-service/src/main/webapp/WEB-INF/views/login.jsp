<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - PlayStore</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
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
                color: #fff;
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

            .bg-orb.cyan {
                width: 400px;
                height: 400px;
                background: rgba(0, 217, 255, 0.15);
                top: -100px;
                right: -100px;
            }

            .bg-orb.pink {
                width: 300px;
                height: 300px;
                background: rgba(255, 46, 99, 0.12);
                bottom: -50px;
                left: -50px;
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
            }

            .logo {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo a {
                font-size: 2rem;
                font-weight: 800;
                background: linear-gradient(90deg, #00d9ff, #ff2e63);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-decoration: none;
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
            }

            .form-group input {
                width: 100%;
                padding: 1rem 1.25rem;
                font-size: 1rem;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                color: #fff;
            }

            .form-group input:focus {
                outline: none;
                border-color: #00d9ff;
                box-shadow: 0 0 0 3px rgba(0, 217, 255, 0.1);
            }

            .btn-login {
                width: 100%;
                padding: 1rem;
                font-size: 1rem;
                font-weight: 600;
                background: linear-gradient(135deg, #00d9ff, #00b4d8);
                color: #0f0f1a;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                margin-top: 1rem;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 217, 255, 0.3);
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
                color: #ff2e63;
                text-decoration: none;
                font-weight: 600;
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

            .alert.warning {
                background: rgba(255, 193, 7, 0.1);
                border: 1px solid rgba(255, 193, 7, 0.3);
                color: #ffc107;
            }

            .spinner {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 2px solid rgba(15, 15, 26, 0.3);
                border-radius: 50%;
                border-top-color: #0f0f1a;
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
        <div class="bg-orb cyan"></div>
        <div class="bg-orb pink"></div>
        <div class="login-container">
            <div class="login-card">
                <div class="logo"><a href="/">PlayStore</a></div>
                <h1>Welcome Back</h1>
                <p class="subtitle">Sign in to browse and download apps</p>
                <div id="alertBox" class="alert"></div>
                <form id="loginForm">
                    <div class="form-group">
                        <label for="userName">Username</label>
                        <input type="text" id="userName" placeholder="Enter your username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" placeholder="Enter your password" required>
                    </div>
                    <button type="submit" class="btn-login" id="loginBtn">Sign In</button>
                </form>
                <div class="divider"><span>New to PlayStore?</span></div>
                <p class="register-link"><a href="/register">Create an account →</a></p>
            </div>
        </div>
        <script>
            document.getElementById('loginForm').addEventListener('submit', async (e) => {
                e.preventDefault();
                const btn = document.getElementById('loginBtn');
                const alertBox = document.getElementById('alertBox');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner"></span>Signing in...';
                alertBox.style.display = 'none';
                try {
                    const res = await fetch('/api/users/login', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            userName: document.getElementById('userName').value,
                            password: document.getElementById('password').value
                        })
                    });
                    const data = await res.json();
                    if (res.ok) {
                        localStorage.setItem('token', data.token);
                        localStorage.setItem('userId', data.userId);
                        localStorage.setItem('userName', data.userName);
                        localStorage.setItem('firstName', data.firstName);
                        localStorage.setItem('lastName', data.lastName);
                        localStorage.setItem('email', data.email);
                        alertBox.className = 'alert success';
                        alertBox.textContent = 'Login successful! Redirecting...';
                        alertBox.style.display = 'block';
                        setTimeout(() => window.location.href = '/store', 1000);
                    } else {
                        // Check if account not active
                        if (data && typeof data === 'string' && data.includes('not active')) {
                            alertBox.className = 'alert warning';
                            alertBox.textContent = 'Your account is pending activation. Please wait for approval.';
                        } else {
                            alertBox.className = 'alert error';
                            alertBox.textContent = data.message || data || 'Invalid credentials';
                        }
                        alertBox.style.display = 'block';
                        btn.disabled = false;
                        btn.textContent = 'Sign In';
                    }
                } catch (error) {
                    alertBox.className = 'alert error';
                    alertBox.textContent = 'Login failed. Please try again.';
                    alertBox.style.display = 'block';
                    btn.disabled = false;
                    btn.textContent = 'Sign In';
                }
            });
        </script>
    </body>

    </html>
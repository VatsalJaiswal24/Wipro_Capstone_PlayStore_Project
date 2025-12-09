<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - PlayStore</title>
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
                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f0f1a 100%);
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

            .bg-orb.cyan {
                width: 400px;
                height: 400px;
                background: rgba(0, 217, 255, 0.15);
                top: -100px;
                left: -100px;
                animation: pulse 8s ease-in-out infinite;
            }

            .bg-orb.pink {
                width: 350px;
                height: 350px;
                background: rgba(255, 46, 99, 0.15);
                bottom: -50px;
                right: -50px;
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

            .register-container {
                width: 100%;
                max-width: 500px;
            }

            .register-card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 24px;
                padding: 2.5rem;
                backdrop-filter: blur(20px);
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            }

            .logo {
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .logo a {
                font-size: 2rem;
                font-weight: 800;
                background: linear-gradient(90deg, #00d9ff, #ff2e63);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-decoration: none;
            }

            h1 {
                font-size: 1.6rem;
                font-weight: 700;
                text-align: center;
                margin-bottom: 0.5rem;
            }

            .subtitle {
                text-align: center;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 1.5rem;
                font-size: 0.95rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-group.full-width {
                grid-column: 1 / -1;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.4rem;
                font-weight: 500;
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.9);
            }

            .form-group input {
                width: 100%;
                padding: 0.85rem 1rem;
                font-size: 0.95rem;
                font-family: inherit;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                color: #ffffff;
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                outline: none;
                border-color: #00d9ff;
                box-shadow: 0 0 0 3px rgba(0, 217, 255, 0.1);
            }

            .form-group input::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .btn-register {
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
                margin-top: 0.5rem;
            }

            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(255, 46, 99, 0.3);
            }

            .btn-register:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 1.5rem 0;
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
                font-size: 0.85rem;
            }

            .login-link {
                text-align: center;
            }

            .login-link a {
                color: #00d9ff;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .login-link a:hover {
                color: #33e4ff;
            }

            .alert {
                padding: 0.85rem;
                border-radius: 10px;
                margin-bottom: 1rem;
                display: none;
                font-size: 0.9rem;
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
                width: 18px;
                height: 18px;
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

            @media (max-width: 500px) {
                .form-row {
                    grid-template-columns: 1fr;
                }

                .register-card {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="bg-orb cyan"></div>
        <div class="bg-orb pink"></div>

        <div class="register-container">
            <div class="register-card">
                <div class="logo">
                    <a href="/">PlayStore</a>
                </div>

                <h1>Create Account</h1>
                <p class="subtitle">Join PlayStore and discover amazing apps</p>

                <div id="alertBox" class="alert"></div>

                <form id="registerForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" placeholder="John" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="userName">Username</label>
                            <input type="text" id="userName" name="userName" placeholder="johndoe" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" placeholder="john@example.com" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="••••••••" required>
                        </div>
                        <div class="form-group">
                            <label for="mobileNo">Mobile Number</label>
                            <input type="tel" id="mobileNo" name="mobileNo" placeholder="+1234567890">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" placeholder="New York">
                        </div>
                        <div class="form-group">
                            <label for="state">State</label>
                            <input type="text" id="state" name="state" placeholder="NY">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="country">Country</label>
                            <input type="text" id="country" name="country" placeholder="USA">
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" placeholder="123 Main St">
                        </div>
                    </div>

                    <button type="submit" class="btn-register" id="registerBtn">
                        Create Account
                    </button>
                </form>

                <div class="divider">
                    <span>Already have an account?</span>
                </div>

                <p class="login-link">
                    <a href="/login">Sign in instead →</a>
                </p>
            </div>
        </div>

        <script>
            const form = document.getElementById('registerForm');
            const alertBox = document.getElementById('alertBox');
            const registerBtn = document.getElementById('registerBtn');

            form.addEventListener('submit', async (e) => {
                e.preventDefault();

                const formData = {
                    firstName: document.getElementById('firstName').value,
                    lastName: document.getElementById('lastName').value,
                    userName: document.getElementById('userName').value,
                    email: document.getElementById('email').value,
                    password: document.getElementById('password').value,
                    mobileNo: document.getElementById('mobileNo').value,
                    city: document.getElementById('city').value,
                    state: document.getElementById('state').value,
                    country: document.getElementById('country').value,
                    address: document.getElementById('address').value
                };

                registerBtn.disabled = true;
                registerBtn.innerHTML = '<span class="spinner"></span>Creating account...';
                alertBox.style.display = 'none';

                try {
                    const response = await fetch('/api/users/register', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    });

                    const data = await response.text();

                    if (response.ok) {
                        alertBox.className = 'alert success';
                        alertBox.textContent = 'Account created successfully! Redirecting to login...';
                        alertBox.style.display = 'block';

                        setTimeout(() => {
                            window.location.href = '/login';
                        }, 2000);
                    } else {
                        throw new Error(data || 'Registration failed');
                    }
                } catch (error) {
                    alertBox.className = 'alert error';
                    alertBox.textContent = error.message;
                    alertBox.style.display = 'block';

                    registerBtn.disabled = false;
                    registerBtn.textContent = 'Create Account';
                }
            });
        </script>
    </body>

    </html>
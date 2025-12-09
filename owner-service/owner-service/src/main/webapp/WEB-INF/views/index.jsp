<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Owner Portal - PlayStore</title>
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
                overflow-x: hidden;
            }

            .bg-animation {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
            }

            .bg-animation::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(255, 46, 99, 0.12) 0%, transparent 70%);
                top: -100px;
                right: -100px;
                animation: float 8s ease-in-out infinite;
            }

            .bg-animation::after {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(0, 217, 255, 0.12) 0%, transparent 70%);
                bottom: -50px;
                left: -50px;
                animation: float 6s ease-in-out infinite reverse;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translate(0, 0);
                }

                50% {
                    transform: translate(30px, 30px);
                }
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem 5%;
                background: rgba(255, 255, 255, 0.02);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 800;
                background: linear-gradient(90deg, #ff2e63, #00d9ff);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .logo span {
                font-size: 0.8rem;
                font-weight: 400;
                background: rgba(255, 46, 99, 0.2);
                color: #ff2e63;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                margin-left: 0.5rem;
            }

            .nav-links {
                display: flex;
                gap: 2rem;
            }

            .nav-links a {
                color: rgba(255, 255, 255, 0.7);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .nav-links a:hover {
                color: #ff2e63;
            }

            .hero {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 80vh;
                text-align: center;
                padding: 2rem;
            }

            .hero h1 {
                font-size: 3.5rem;
                font-weight: 800;
                line-height: 1.2;
                margin-bottom: 1.5rem;
            }

            .hero h1 span {
                background: linear-gradient(90deg, #ff2e63, #ff6b6b);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .hero p {
                font-size: 1.2rem;
                color: rgba(255, 255, 255, 0.6);
                max-width: 600px;
                margin-bottom: 3rem;
                line-height: 1.8;
            }

            .btn-group {
                display: flex;
                gap: 1.5rem;
            }

            .btn {
                padding: 1rem 2.5rem;
                font-size: 1rem;
                font-weight: 600;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-primary {
                background: linear-gradient(135deg, #ff2e63, #ff6b6b);
                color: #ffffff;
                box-shadow: 0 10px 40px rgba(255, 46, 99, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 50px rgba(255, 46, 99, 0.4);
            }

            .btn-secondary {
                background: transparent;
                color: #00d9ff;
                border: 2px solid #00d9ff;
            }

            .btn-secondary:hover {
                background: rgba(0, 217, 255, 0.1);
                transform: translateY(-3px);
            }

            .features {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 2rem;
                padding: 4rem 5%;
                max-width: 1200px;
                margin: 0 auto;
            }

            .feature-card {
                background: rgba(255, 255, 255, 0.02);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 20px;
                padding: 2rem;
                backdrop-filter: blur(10px);
                transition: all 0.3s ease;
            }

            .feature-card:hover {
                transform: translateY(-10px);
                border-color: rgba(255, 46, 99, 0.3);
                box-shadow: 0 20px 60px rgba(255, 46, 99, 0.1);
            }

            .feature-icon {
                width: 60px;
                height: 60px;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                background: linear-gradient(135deg, rgba(255, 46, 99, 0.2), rgba(255, 107, 107, 0.2));
            }

            .feature-card h3 {
                font-size: 1.3rem;
                margin-bottom: 1rem;
            }

            .feature-card p {
                color: rgba(255, 255, 255, 0.6);
                line-height: 1.7;
            }

            footer {
                text-align: center;
                padding: 2rem;
                border-top: 1px solid rgba(255, 255, 255, 0.05);
                color: rgba(255, 255, 255, 0.4);
            }

            @media (max-width: 768px) {
                .hero h1 {
                    font-size: 2.5rem;
                }

                .btn-group {
                    flex-direction: column;
                    width: 100%;
                    max-width: 300px;
                }
            }
        </style>
    </head>

    <body>
        <div class="bg-animation"></div>

        <nav>
            <div class="logo">PlayStore <span>Developer</span></div>
            <div class="nav-links">
                <a href="/">Home</a>
                <a href="/login">Login</a>
                <a href="/register">Register</a>
            </div>
        </nav>

        <section class="hero">
            <h1>Publish Your <span>Apps</span></h1>
            <p>Join thousands of developers who trust PlayStore to publish and manage their applications. Reach millions
                of users worldwide.</p>
            <div class="btn-group">
                <a href="/register" class="btn btn-primary">🚀 Start Publishing</a>
                <a href="/login" class="btn btn-secondary">Sign In</a>
            </div>
        </section>

        <section class="features">
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Real-time Analytics</h3>
                <p>Track downloads, ratings, and user engagement with detailed analytics dashboard.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔧</div>
                <h3>Easy Management</h3>
                <p>Update your apps, manage versions, and control visibility with a few clicks.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3>Monetization</h3>
                <p>Set your pricing, offer free trials, and maximize your app revenue.</p>
            </div>
        </section>

        <footer>
            <p>Made with ❤️ by Vatsal Jaiswal | © 2025 All Rights Reserved</p>
        </footer>
    </body>

    </html>
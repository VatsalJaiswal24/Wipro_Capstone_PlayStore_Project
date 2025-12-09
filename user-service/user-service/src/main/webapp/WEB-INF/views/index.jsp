<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PlayStore - App Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            overflow-x: hidden;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .bg-animation::before {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.15) 0%, transparent 70%);
            top: -100px;
            right: -100px;
            animation: float 8s ease-in-out infinite;
        }

        .bg-animation::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255, 46, 99, 0.15) 0%, transparent 70%);
            bottom: -50px;
            left: -50px;
            animation: float 6s ease-in-out infinite reverse;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(30px, 30px) rotate(5deg); }
        }

        /* Navigation */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 5%;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(90deg, #00d9ff, #ff2e63);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-links a:hover {
            color: #00d9ff;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #00d9ff, #ff2e63);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        /* Hero Section */
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
            font-size: 4rem;
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #ffffff 0%, #a0a0a0 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero h1 span {
            background: linear-gradient(90deg, #00d9ff, #ff2e63);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.7);
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
            background: linear-gradient(135deg, #00d9ff 0%, #00b4d8 100%);
            color: #0f0f1a;
            box-shadow: 0 10px 40px rgba(0, 217, 255, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 50px rgba(0, 217, 255, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: #ff2e63;
            border: 2px solid #ff2e63;
        }

        .btn-secondary:hover {
            background: rgba(255, 46, 99, 0.1);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(255, 46, 99, 0.2);
        }

        /* Features */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 4rem 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            border-color: rgba(0, 217, 255, 0.3);
            box-shadow: 0 20px 60px rgba(0, 217, 255, 0.1);
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
        }

        .feature-icon.cyan {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.2) 0%, rgba(0, 180, 216, 0.2) 100%);
            color: #00d9ff;
        }

        .feature-icon.pink {
            background: linear-gradient(135deg, rgba(255, 46, 99, 0.2) 0%, rgba(255, 107, 107, 0.2) 100%);
            color: #ff2e63;
        }

        .feature-icon.green {
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.2) 0%, rgba(0, 200, 100, 0.2) 100%);
            color: #00ff88;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: #ffffff;
        }

        .feature-card p {
            color: rgba(255, 255, 255, 0.6);
            line-height: 1.7;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.5);
        }

        footer span {
            color: #ff2e63;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .btn-group {
                flex-direction: column;
                width: 100%;
                max-width: 300px;
            }

            .nav-links {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="bg-animation"></div>

    <nav>
        <div class="logo">PlayStore</div>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/login">Login</a>
            <a href="/register">Sign Up</a>
        </div>
    </nav>

    <section class="hero">
        <h1>Discover Amazing <span>Apps</span></h1>
        <p>Your gateway to thousands of applications. Download, explore, and enjoy the best apps curated just for you.</p>
        <div class="btn-group">
            <a href="/register" class="btn btn-primary">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                </svg>
                Get Started
            </a>
            <a href="/login" class="btn btn-secondary">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                </svg>
                Sign In
            </a>
        </div>
    </section>

    <section class="features">
        <div class="feature-card">
            <div class="feature-icon cyan">📱</div>
            <h3>Vast Collection</h3>
            <p>Access thousands of applications across gaming, productivity, health, education and more categories.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon pink">🔒</div>
            <h3>Secure Downloads</h3>
            <p>All apps are verified and scanned for security. Download with confidence knowing you're protected.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon green">⚡</div>
            <h3>Lightning Fast</h3>
            <p>Optimized download speeds ensure you get your apps quickly without any delays.</p>
        </div>
    </section>

    <footer>
        <p>Made with <span>❤</span> by Vatsal Jaiswal | © 2025 All Rights Reserved</p>
    </footer>
</body>
</html>

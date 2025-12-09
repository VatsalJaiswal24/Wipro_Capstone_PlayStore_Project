<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - PlayStore</title>
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
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 5%;
                background: rgba(255, 255, 255, 0.02);
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            }

            .logo {
                font-size: 1.5rem;
                font-weight: 800;
                background: linear-gradient(90deg, #00d9ff, #ff2e63);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .nav-links {
                display: flex;
                gap: 2rem;
            }

            .nav-links a {
                color: rgba(255, 255, 255, 0.7);
                text-decoration: none;
                font-weight: 500;
            }

            .nav-links a:hover,
            .nav-links a.active {
                color: #00d9ff;
            }

            .btn-logout {
                padding: 0.5rem 1.25rem;
                background: rgba(255, 46, 99, 0.1);
                border: 1px solid rgba(255, 46, 99, 0.3);
                color: #ff2e63;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
            }

            .container {
                padding: 2rem 5%;
                max-width: 1200px;
                margin: 0 auto;
            }

            .welcome h1 {
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .welcome h1 span {
                background: linear-gradient(90deg, #00d9ff, #00b4d8);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .welcome p {
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 2rem;
            }

            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 16px;
                padding: 1.5rem;
            }

            .card h3 {
                font-size: 1rem;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 0.5rem;
            }

            .card .value {
                font-size: 1.8rem;
                font-weight: 700;
            }

            .card .value.cyan {
                color: #00d9ff;
            }

            .card .value.green {
                color: #00ff88;
            }

            .card .value.pink {
                color: #ff2e63;
            }

            .quick-actions {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
            }

            .action {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 12px;
                text-decoration: none;
                color: inherit;
                transition: all 0.3s;
            }

            .action:hover {
                border-color: rgba(0, 217, 255, 0.3);
                transform: translateY(-3px);
            }

            .action-icon {
                width: 45px;
                height: 45px;
                border-radius: 10px;
                background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 180, 216, 0.2));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
            }

            .action-text h4 {
                font-size: 0.95rem;
                margin-bottom: 0.2rem;
            }

            .action-text p {
                font-size: 0.8rem;
                color: rgba(255, 255, 255, 0.5);
            }
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore</div>
            <div class="nav-links">
                <a href="/">Home</a>
                <a href="/store">Store</a>
                <a href="/dashboard" class="active">Dashboard</a>
            </div>
            <button class="btn-logout" onclick="logout()">Logout</button>
        </nav>
        <main class="container">
            <div class="welcome">
                <h1>Welcome, <span id="firstName">User</span>!</h1>
                <p>Your personal dashboard</p>
            </div>
            <div class="cards">
                <div class="card">
                    <h3>Account Status</h3>
                    <div class="value green" id="status">ACTIVE</div>
                </div>
                <div class="card">
                    <h3>Wallet Balance</h3>
                    <div class="value cyan" id="balance">$0.00</div>
                </div>
                <div class="card">
                    <h3>Account Type</h3>
                    <div class="value pink" id="accountType">FREE</div>
                </div>
            </div>
            <h2 style="margin-bottom: 1rem;">Quick Actions</h2>
            <div class="quick-actions">
                <a href="/store" class="action">
                    <div class="action-icon">🎮</div>
                    <div class="action-text">
                        <h4>Browse Apps</h4>
                        <p>Discover new apps</p>
                    </div>
                </a>
                <a href="/store" class="action">
                    <div class="action-icon">⬇️</div>
                    <div class="action-text">
                        <h4>My Downloads</h4>
                        <p>View installed apps</p>
                    </div>
                </a>
                <a href="#" class="action">
                    <div class="action-icon">💳</div>
                    <div class="action-text">
                        <h4>Add Funds</h4>
                        <p>Top up your wallet</p>
                    </div>
                </a>
            </div>
        </main>
        <script>
            const token = localStorage.getItem('token');
            if (!token) window.location.href = '/login';
            document.getElementById('firstName').textContent = localStorage.getItem('firstName') || 'User';
            function logout() { localStorage.clear(); window.location.href = '/login'; }
        </script>
    </body>

    </html>
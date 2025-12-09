<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Apps - PlayStore</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                background: linear-gradient(90deg, #ff2e63, #00d9ff);
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
                color: #ff2e63;
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
                max-width: 1400px;
                margin: 0 auto;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
            }

            .header h1 {
                font-size: 2rem;
            }

            .btn-add {
                padding: 0.75rem 1.5rem;
                background: linear-gradient(135deg, #ff2e63, #ff6b6b);
                color: #fff;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
            }

            .apps-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
            }

            .app-card {
                background: rgba(255, 255, 255, 0.02);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 16px;
                padding: 1.5rem;
                transition: all 0.3s;
            }

            .app-card:hover {
                transform: translateY(-5px);
                border-color: rgba(0, 217, 255, 0.3);
            }

            .app-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .app-icon {
                width: 60px;
                height: 60px;
                border-radius: 14px;
                background: linear-gradient(135deg, #ff2e63, #00d9ff);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            .app-type {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .app-type.free {
                background: rgba(0, 255, 136, 0.1);
                color: #00ff88;
                border: 1px solid rgba(0, 255, 136, 0.3);
            }

            .app-type.paid {
                background: rgba(255, 46, 99, 0.1);
                color: #ff2e63;
                border: 1px solid rgba(255, 46, 99, 0.3);
            }

            .app-name {
                font-size: 1.25rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .app-genre {
                color: rgba(255, 255, 255, 0.5);
                font-size: 0.9rem;
                margin-bottom: 1rem;
            }

            .app-stats {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 0.5rem;
                padding-top: 1rem;
                border-top: 1px solid rgba(255, 255, 255, 0.05);
            }

            .stat {
                text-align: center;
            }

            .stat-value {
                font-size: 1.1rem;
                font-weight: 700;
                color: #00d9ff;
            }

            .stat-label {
                font-size: 0.75rem;
                color: rgba(255, 255, 255, 0.5);
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: rgba(255, 255, 255, 0.02);
                border: 1px dashed rgba(255, 255, 255, 0.1);
                border-radius: 16px;
                grid-column: 1/-1;
            }

            .loading {
                text-align: center;
                padding: 3rem;
                color: rgba(255, 255, 255, 0.6);
            }
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore Developer</div>
            <div class="nav-links">
                <a href="/dashboard">Dashboard</a>
                <a href="/my-apps" class="active">My Apps</a>
                <a href="/add-app">Add App</a>
            </div>
            <button class="btn-logout" onclick="logout()">Logout</button>
        </nav>
        <main class="container">
            <div class="header">
                <h1>My Applications</h1>
                <a href="/add-app" class="btn-add">+ Add New App</a>
            </div>
            <div id="appsContainer" class="apps-grid">
                <div class="loading">Loading your apps...</div>
            </div>
        </main>
        <script>
            var token = localStorage.getItem('ownerToken');
            if (!token) window.location.href = '/login';
            var ownerId = localStorage.getItem('ownerId');
            var container = document.getElementById('appsContainer');

            if (ownerId) {
                fetch('/api/owner/my-apps/' + ownerId, {
                    headers: { 'Authorization': 'Bearer ' + token }
                })
                    .then(function (res) { return res.json(); })
                    .then(function (apps) {
                        if (apps.length === 0) {
                            container.innerHTML = '<div class="empty-state"><h2>No Apps Yet</h2><p>Publish your first app!</p><a href="/add-app" class="btn-add">Publish App</a></div>';
                        } else {
                            var html = '';
                            for (var i = 0; i < apps.length; i++) {
                                var app = apps[i];
                                var typeClass = app.appType === 'FREE' ? 'free' : 'paid';
                                html += '<div class="app-card">' +
                                    '<div class="app-header">' +
                                    '<div class="app-icon">📱</div>' +
                                    '<span class="app-type ' + typeClass + '">' + app.appType + '</span>' +
                                    '</div>' +
                                    '<div class="app-name">' + app.appName + '</div>' +
                                    '<div class="app-genre">' + app.genre + ' v' + app.version + '</div>' +
                                    '<div class="app-stats">' +
                                    '<div class="stat"><div class="stat-value">' + (app.downloadCount || 0) + '</div><div class="stat-label">Downloads</div></div>' +
                                    '<div class="stat"><div class="stat-value">' + (app.rating || 0) + '</div><div class="stat-label">Rating</div></div>' +
                                    '<div class="stat"><div class="stat-value">$' + (app.price || 0) + '</div><div class="stat-label">Price</div></div>' +
                                    '</div>' +
                                    '</div>';
                            }
                            container.innerHTML = html;
                        }
                    })
                    .catch(function () {
                        container.innerHTML = '<div class="loading">Error loading apps.</div>';
                    });
            }

            function logout() {
                localStorage.clear();
                window.location.href = '/login';
            }
        </script>
    </body>

    </html>
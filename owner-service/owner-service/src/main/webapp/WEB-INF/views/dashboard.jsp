<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Developer Dashboard - PlayStore</title>
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

            .welcome h1 {
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .welcome h1 span {
                background: linear-gradient(90deg, #ff2e63, #ff6b6b);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .welcome p {
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 2rem;
            }

            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 16px;
                padding: 1.5rem;
                transition: all 0.3s;
            }

            .card:hover {
                transform: translateY(-3px);
                border-color: rgba(255, 46, 99, 0.3);
            }

            .card-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }

            .card-icon.pink {
                background: rgba(255, 46, 99, 0.15);
            }

            .card-icon.cyan {
                background: rgba(0, 217, 255, 0.15);
            }

            .card-icon.yellow {
                background: rgba(255, 193, 7, 0.15);
            }

            .card-icon.green {
                background: rgba(0, 255, 136, 0.15);
            }

            .card .value {
                font-size: 1.8rem;
                font-weight: 700;
                margin-bottom: 0.25rem;
            }

            .card .label {
                color: rgba(255, 255, 255, 0.6);
                font-size: 0.9rem;
            }

            .section-title {
                font-size: 1.25rem;
                margin-bottom: 1rem;
                margin-top: 2rem;
            }

            .actions {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 1rem;
            }

            .action {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1.25rem;
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
                width: 50px;
                height: 50px;
                border-radius: 12px;
                background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 180, 216, 0.2));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
            }

            .action-icon.highlight {
                background: linear-gradient(135deg, rgba(255, 193, 7, 0.3), rgba(255, 152, 0, 0.3));
            }

            .action-text h4 {
                font-size: 1rem;
                margin-bottom: 0.25rem;
            }

            .action-text p {
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.5);
            }

            .badge {
                background: #ff2e63;
                color: #fff;
                padding: 0.15rem 0.5rem;
                border-radius: 10px;
                font-size: 0.75rem;
                margin-left: 0.5rem;
            }

            .ratings-table {
                width: 100%;
                border-collapse: collapse;
                background: rgba(255, 255, 255, 0.02);
                border-radius: 12px;
                overflow: hidden;
            }

            .ratings-table th,
            .ratings-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            }

            .ratings-table th {
                background: rgba(255, 255, 255, 0.05);
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.7);
            }

            .star {
                color: #ffc107;
            }

            .no-data {
                text-align: center;
                padding: 2rem;
                color: rgba(255, 255, 255, 0.5);
            }

            .debug {
                background: rgba(255, 0, 0, 0.1);
                padding: 1rem;
                border-radius: 8px;
                margin-top: 1rem;
                font-size: 0.8rem;
                display: none;
            }
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore Developer</div>
            <div class="nav-links">
                <a href="/dashboard" class="active">Dashboard</a>
                <a href="/my-apps">My Apps</a>
                <a href="/add-app">Add App</a>
                <a href="/users">Users <span class="badge" id="pendingBadge" style="display:none;">0</span></a>
            </div>
            <button class="btn-logout" onclick="logout()">Logout</button>
        </nav>
        <main class="container">
            <div class="welcome">
                <h1>Welcome, <span id="firstName">Developer</span>!</h1>
                <p>Manage your applications and users</p>
            </div>
            <div class="cards">
                <div class="card">
                    <div class="card-icon pink">📱</div>
                    <div class="value" id="totalApps">0</div>
                    <div class="label">Total Apps</div>
                </div>
                <div class="card">
                    <div class="card-icon cyan">⬇️</div>
                    <div class="value" id="totalDownloads">0</div>
                    <div class="label">Downloads</div>
                </div>
                <div class="card">
                    <div class="card-icon yellow">👥</div>
                    <div class="value" id="pendingUsers">0</div>
                    <div class="label">Pending Users</div>
                </div>
                <div class="card">
                    <div class="card-icon green">⭐</div>
                    <div class="value" id="avgRating">0.0</div>
                    <div class="label">Avg Rating</div>
                </div>
            </div>
            <h2 class="section-title">Quick Actions</h2>
            <div class="actions">
                <a href="/add-app" class="action">
                    <div class="action-icon">🚀</div>
                    <div class="action-text">
                        <h4>Publish New App</h4>
                        <p>Upload a new application</p>
                    </div>
                </a>
                <a href="/my-apps" class="action">
                    <div class="action-icon">📊</div>
                    <div class="action-text">
                        <h4>Manage Apps</h4>
                        <p>View and edit your apps</p>
                    </div>
                </a>
                <a href="/users" class="action">
                    <div class="action-icon highlight">👥</div>
                    <div class="action-text">
                        <h4>Manage Users</h4>
                        <p>Approve pending users</p>
                    </div>
                </a>
            </div>
            <h2 class="section-title">Recent Ratings</h2>
            <table class="ratings-table">
                <thead>
                    <tr>
                        <th>App Name</th>
                        <th>User</th>
                        <th>Rating</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody id="ratingsBody">
                    <tr>
                        <td colspan="4" class="no-data">Loading ratings...</td>
                    </tr>
                </tbody>
            </table>
            <div class="debug" id="debugInfo"></div>
        </main>
        <script>
            var token = localStorage.getItem('ownerToken');
            if (!token) window.location.href = '/login';
            document.getElementById('firstName').textContent = localStorage.getItem('ownerFirstName') || 'Developer';
            var ownerId = localStorage.getItem('ownerId');
            var myApps = [];
            var appMap = {};

            function debug(msg) {
                var d = document.getElementById('debugInfo');
                d.innerHTML += msg + '<br>';
                d.style.display = 'block';
            }

            // Load apps stats
            if (ownerId) {
                fetch('/api/owner/my-apps/' + ownerId)
                    .then(function (res) { return res.json(); })
                    .then(function (apps) {
                        myApps = apps;
                        document.getElementById('totalApps').textContent = apps.length;
                        var downloads = 0, rating = 0;
                        for (var i = 0; i < apps.length; i++) {
                            downloads += apps[i].downloadCount || 0;
                            rating += apps[i].rating || 0;
                            appMap[apps[i].appId] = apps[i].appName;
                        }
                        document.getElementById('totalDownloads').textContent = downloads;
                        document.getElementById('avgRating').textContent = apps.length > 0 ? (rating / apps.length).toFixed(1) : '0.0';
                        loadRatingsForMyApps();
                    })
                    .catch(function (err) {
                        debug('Error loading apps: ' + err);
                    });
            }

            function loadRatingsForMyApps() {
                var ratingsBody = document.getElementById('ratingsBody');

                if (myApps.length === 0) {
                    ratingsBody.innerHTML = '<tr><td colspan="4" class="no-data">No apps found. Add an app first!</td></tr>';
                    return;
                }

                var allRatings = [];
                var completedRequests = 0;

                for (var i = 0; i < myApps.length; i++) {
                    (function (app) {
                        fetch('/api/owner/ratings/' + app.appId)
                            .then(function (res) {
                                if (!res.ok) throw new Error('HTTP ' + res.status);
                                return res.json();
                            })
                            .then(function (ratings) {
                                if (Array.isArray(ratings) && ratings.length > 0) {
                                    for (var j = 0; j < ratings.length; j++) {
                                        ratings[j].appName = app.appName;
                                        allRatings.push(ratings[j]);
                                    }
                                }
                            })
                            .catch(function (err) {
                                debug('Error loading ratings for app ' + app.appId + ': ' + err);
                            })
                            .finally(function () {
                                completedRequests++;
                                if (completedRequests === myApps.length) {
                                    displayRatings(allRatings);
                                }
                            });
                    })(myApps[i]);
                }
            }

            function displayRatings(allRatings) {
                var ratingsBody = document.getElementById('ratingsBody');

                if (allRatings.length === 0) {
                    ratingsBody.innerHTML = '<tr><td colspan="4" class="no-data">No ratings yet. Users can rate your apps from the store!</td></tr>';
                    return;
                }

                // Sort by date (most recent first)
                allRatings.sort(function (a, b) {
                    var dateA = a.createdAt ? new Date(a.createdAt) : new Date(0);
                    var dateB = b.createdAt ? new Date(b.createdAt) : new Date(0);
                    return dateB - dateA;
                });

                var html = '';
                var limit = Math.min(allRatings.length, 10);
                for (var k = 0; k < limit; k++) {
                    var r = allRatings[k];
                    var stars = '';
                    for (var s = 0; s < 5; s++) {
                        if (s < r.stars) {
                            stars += '<span class="star">★</span>';
                        } else {
                            stars += '☆';
                        }
                    }
                    var date = 'N/A';
                    if (r.createdAt) {
                        try {
                            date = new Date(r.createdAt).toLocaleDateString();
                        } catch (e) {
                            date = 'N/A';
                        }
                    }
                    html += '<tr>' +
                        '<td>' + (r.appName || 'App #' + r.appId) + '</td>' +
                        '<td>' + (r.userName || 'User #' + r.userId) + '</td>' +
                        '<td>' + stars + ' (' + r.stars + '/5)</td>' +
                        '<td>' + date + '</td>' +
                        '</tr>';
                }
                ratingsBody.innerHTML = html;
            }

            // Load pending users count
            fetch('/api/owner/users/pending')
                .then(function (res) { return res.json(); })
                .then(function (users) {
                    if (Array.isArray(users)) {
                        var count = users.length;
                        document.getElementById('pendingUsers').textContent = count;
                        if (count > 0) {
                            document.getElementById('pendingBadge').textContent = count;
                            document.getElementById('pendingBadge').style.display = 'inline';
                        }
                    }
                })
                .catch(function (err) { debug('Error loading pending users: ' + err); });

            function logout() { localStorage.clear(); window.location.href = '/login'; }
        </script>
        <footer
            style="text-align: center; padding: 2rem; color: rgba(255, 255, 255, 0.5); border-top: 1px solid rgba(255, 255, 255, 0.1); margin-top: 3rem;">
            <p>Made with <span style="color: #ff2e63;">❤</span> by Vatsal Jaiswal | © 2025 All Rights Reserved</p>
        </footer>
    </body>

    </html>
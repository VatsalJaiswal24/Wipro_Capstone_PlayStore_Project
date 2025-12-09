<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>App Store - PlayStore</title>
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
                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f0f1a 100%);
                color: #fff;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 5%;
                background: rgba(255, 255, 255, 0.03);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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
                align-items: center;
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
                text-decoration: none;
            }

            .btn-logout:hover {
                background: rgba(255, 46, 99, 0.2);
            }

            .search-bar {
                display: flex;
                gap: 0.5rem;
            }

            .search-bar input,
            .search-bar select {
                padding: 0.5rem 1rem;
                border-radius: 8px;
                border: 1px solid rgba(255, 255, 255, 0.1);
                background: rgba(255, 255, 255, 0.05);
                color: #fff;
            }

            .search-bar input {
                width: 200px;
            }

            .search-bar select {
                width: 120px;
            }

            .search-bar select option {
                background: #1a1a2e;
            }

            .container {
                padding: 2rem 5%;
                max-width: 1400px;
                margin: 0 auto;
            }

            h1 {
                font-size: 2rem;
                margin-bottom: 1rem;
            }

            .user-welcome {
                color: rgba(255, 255, 255, 0.7);
                margin-bottom: 1.5rem;
            }

            .user-welcome span {
                color: #00d9ff;
                font-weight: 600;
            }

            .categories {
                display: flex;
                gap: 1rem;
                margin-bottom: 2rem;
                flex-wrap: wrap;
            }

            .category {
                padding: 0.5rem 1.25rem;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 25px;
                cursor: pointer;
                transition: all 0.3s;
                font-size: 0.9rem;
                color: #fff;
            }

            .category.active,
            .category:hover {
                background: linear-gradient(135deg, #00d9ff, #00b4d8);
                border-color: transparent;
                color: #0f0f1a;
            }

            .apps-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                gap: 1.5rem;
            }

            .app-card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 16px;
                padding: 1.25rem;
                transition: all 0.3s;
            }

            .app-card:hover {
                transform: translateY(-5px);
                border-color: rgba(0, 217, 255, 0.3);
            }

            .app-header {
                display: flex;
                gap: 1rem;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .app-icon {
                width: 60px;
                height: 60px;
                border-radius: 14px;
                background: linear-gradient(135deg, #00d9ff, #ff2e63);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            .app-info {
                flex: 1;
            }

            .app-name {
                font-size: 1.1rem;
                font-weight: 700;
                margin-bottom: 0.25rem;
            }

            .app-genre {
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.5);
            }

            .app-desc {
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 1rem;
                line-height: 1.5;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }

            .app-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .app-rating {
                display: flex;
                align-items: center;
                gap: 0.25rem;
                color: #ffc107;
            }

            .app-price {
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
            }

            .app-price.free {
                background: rgba(0, 255, 136, 0.15);
                color: #00ff88;
            }

            .app-price.paid {
                background: rgba(255, 46, 99, 0.15);
                color: #ff2e63;
            }

            .downloads {
                font-size: 0.8rem;
                color: rgba(255, 255, 255, 0.5);
                margin-left: 0.5rem;
            }

            .loading,
            .empty {
                text-align: center;
                padding: 3rem;
                color: rgba(255, 255, 255, 0.5);
            }

            .pending-notice {
                background: rgba(255, 193, 7, 0.1);
                border: 1px solid rgba(255, 193, 7, 0.3);
                color: #ffc107;
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                text-align: center;
            }

            .app-actions {
                display: flex;
                gap: 0.5rem;
                align-items: center;
                flex-wrap: wrap;
            }

            .btn-install {
                padding: 0.5rem 1.25rem;
                background: linear-gradient(135deg, #00d9ff, #00b4d8);
                color: #0f0f1a;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
            }

            .btn-install:hover {
                transform: scale(1.05);
            }

            .btn-install:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .btn-install.installed {
                background: rgba(0, 255, 136, 0.15);
                color: #00ff88;
                border: 1px solid rgba(0, 255, 136, 0.3);
            }

            .star-rating {
                display: flex;
                gap: 0.2rem;
            }

            .star-rating .star {
                font-size: 1.2rem;
                cursor: pointer;
                color: rgba(255, 255, 255, 0.3);
                transition: all 0.2s;
            }

            .star-rating .star:hover,
            .star-rating .star.active {
                color: #ffc107;
            }

            .star-rating .star.filled {
                color: #ffc107;
            }

            .alert {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                z-index: 1000;
                animation: slideIn 0.3s;
            }

            .alert.success {
                background: rgba(0, 255, 136, 0.9);
                color: #0f0f1a;
            }

            .alert.error {
                background: rgba(255, 46, 99, 0.9);
                color: #fff;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                }

                to {
                    transform: translateX(0);
                }
            }
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore</div>
            <div class="nav-links">
                <a href="/">Home</a>
                <a href="/store" class="active">Store</a>
                <a href="/login" id="loginLink">Login</a>
                <a href="#" class="btn-logout" id="logoutBtn" style="display:none;" onclick="logout()">Logout</a>
            </div>
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Search apps..." onkeyup="searchApps()">
                <select id="ratingFilter" onchange="filterByRating()">
                    <option value="0">All Ratings</option>
                    <option value="4">4+ Stars</option>
                    <option value="3">3+ Stars</option>
                    <option value="2">2+ Stars</option>
                    <option value="1">1+ Stars</option>
                </select>
            </div>
        </nav>
        <main class="container">
            <div id="pendingNotice" class="pending-notice" style="display:none;">
                Your account is pending activation. You can browse apps but cannot install them until your account is
                activated.
            </div>
            <div id="userWelcome" class="user-welcome" style="display:none;">
                Welcome back, <span id="userNameDisplay"></span>!
            </div>
            <h1>App Store</h1>
            <div class="categories">
                <span class="category active" id="catAll" onclick="filterByGenre('all')">All</span>
                <span class="category" id="catGames" onclick="filterByGenre('Games')">Games</span>
                <span class="category" id="catEducation" onclick="filterByGenre('Education')">Education</span>
                <span class="category" id="catHealth" onclick="filterByGenre('Health')">Health</span>
                <span class="category" id="catProductivity" onclick="filterByGenre('Productivity')">Productivity</span>
                <span class="category" id="catSocial" onclick="filterByGenre('Social')">Social</span>
                <span class="category" id="catEntertainment"
                    onclick="filterByGenre('Entertainment')">Entertainment</span>
            </div>
            <div id="appsContainer" class="apps-grid">
                <div class="loading">Loading apps...</div>
            </div>
        </main>
        <div id="alertBox" class="alert" style="display:none;"></div>
        <script>
            var allApps = [];
            var currentGenre = 'all';
            var currentMinRating = 0;
            var token = localStorage.getItem('token');
            var userId = localStorage.getItem('userId');
            var userName = localStorage.getItem('userName');
            var userStatus = localStorage.getItem('userStatus');
            var firstName = localStorage.getItem('firstName');

            // Show/hide login/logout based on auth status
            if (token && userId) {
                document.getElementById('loginLink').style.display = 'none';
                document.getElementById('logoutBtn').style.display = 'inline-block';
                document.getElementById('userWelcome').style.display = 'block';
                document.getElementById('userNameDisplay').textContent = firstName || userName || 'User';
            }

            if (userStatus === 'PENDING') {
                document.getElementById('pendingNotice').style.display = 'block';
            }

            function logout() {
                localStorage.clear();
                window.location.href = '/login';
            }

            function loadApps() {
                fetch('http://localhost:8082/api/owner/apps/all')
                    .then(function (res) { return res.json(); })
                    .then(function (apps) {
                        allApps = apps;
                        applyFilters();
                    })
                    .catch(function () {
                        document.getElementById('appsContainer').innerHTML = '<div class="loading">Error loading apps. Make sure Owner Service is running.</div>';
                    });
            }

            function filterByGenre(genre) {
                currentGenre = genre;
                var cats = document.querySelectorAll('.category');
                for (var i = 0; i < cats.length; i++) { cats[i].className = 'category'; }
                var catId = 'cat' + (genre === 'all' ? 'All' : genre);
                document.getElementById(catId).className = 'category active';
                applyFilters();
            }

            function filterByRating() {
                currentMinRating = parseFloat(document.getElementById('ratingFilter').value);
                applyFilters();
            }

            function searchApps() {
                applyFilters();
            }

            function applyFilters() {
                var term = document.getElementById('searchInput').value.toLowerCase();
                var filtered = allApps.filter(function (a) {
                    var matchesSearch = a.appName.toLowerCase().indexOf(term) !== -1 ||
                        (a.description && a.description.toLowerCase().indexOf(term) !== -1);
                    var matchesGenre = currentGenre === 'all' || a.genre === currentGenre;
                    var matchesRating = (a.rating || 0) >= currentMinRating;
                    return matchesSearch && matchesGenre && matchesRating;
                });
                renderApps(filtered);
            }

            function renderApps(apps) {
                var container = document.getElementById('appsContainer');
                if (apps.length === 0) {
                    container.innerHTML = '<div class="empty">No apps found</div>';
                    return;
                }
                var html = '';
                for (var i = 0; i < apps.length; i++) {
                    var app = apps[i];
                    var priceClass = app.appType === 'FREE' ? 'free' : 'paid';
                    var priceText = app.appType === 'FREE' ? 'FREE' : '$' + (app.price || 0);
                    var rating = app.rating || 0;
                    var stars = '';
                    for (var s = 1; s <= 5; s++) {
                        stars += '<span class="' + (s <= Math.round(rating) ? 'star filled' : '') + '">' + (s <= Math.round(rating) ? '★' : '☆') + '</span>';
                    }

                    html += '<div class="app-card" data-appid="' + app.appId + '">' +
                        '<div class="app-header">' +
                        '<div class="app-icon">📱</div>' +
                        '<div class="app-info">' +
                        '<div class="app-name">' + app.appName + '</div>' +
                        '<div class="app-genre">' + (app.genre || 'App') + '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="app-desc">' + (app.description || 'No description available') + '</div>' +
                        '<div class="app-footer">' +
                        '<div>' +
                        '<span class="app-rating" style="color:#ffc107;">' + stars + ' ' + rating.toFixed(1) + '</span>' +
                        '<span class="downloads">' + (app.downloadCount || 0) + ' downloads</span>' +
                        '</div>' +
                        '<span class="app-price ' + priceClass + '">' + priceText + '</span>' +
                        '</div>' +
                        '<div class="app-actions">' +
                        '<button class="btn-install" id="install-' + app.appId + '" onclick="installApp(' + app.appId + ', \'' + app.appName.replace(/'/g, "\\'") + '\')">Install</button>' +
                        '<div class="star-rating" id="rating-' + app.appId + '">' +
                        '<span class="star" onclick="rateApp(' + app.appId + ', 1)">★</span>' +
                        '<span class="star" onclick="rateApp(' + app.appId + ', 2)">★</span>' +
                        '<span class="star" onclick="rateApp(' + app.appId + ', 3)">★</span>' +
                        '<span class="star" onclick="rateApp(' + app.appId + ', 4)">★</span>' +
                        '<span class="star" onclick="rateApp(' + app.appId + ', 5)">★</span>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                }
                container.innerHTML = html;
            }

            function installApp(appId, appName) {
                if (!token || !userId) {
                    showAlert('Please login to install apps!', 'error');
                    return;
                }
                if (userStatus === 'PENDING') {
                    showAlert('Your account is pending activation!', 'error');
                    return;
                }
                var btn = document.getElementById('install-' + appId);
                btn.disabled = true;
                btn.textContent = 'Installing...';

                fetch('http://localhost:8082/api/owner/apps/' + appId + '/install', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ userId: userId, userName: userName })
                })
                    .then(function (res) { return res.json(); })
                    .then(function (data) {
                        btn.textContent = 'Installed ✓';
                        btn.className = 'btn-install installed';
                        showAlert('App installed successfully!', 'success');
                    })
                    .catch(function () {
                        btn.disabled = false;
                        btn.textContent = 'Install';
                        showAlert('Error installing app', 'error');
                    });
            }

            function rateApp(appId, stars) {
                if (!token || !userId) {
                    showAlert('Please login to rate apps!', 'error');
                    return;
                }
                if (userStatus === 'PENDING') {
                    showAlert('Your account is pending activation!', 'error');
                    return;
                }

                fetch('http://localhost:8082/api/owner/rate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ appId: appId, userId: userId, userName: userName, stars: stars })
                })
                    .then(function (res) { return res.json(); })
                    .then(function (data) {
                        var ratingDiv = document.getElementById('rating-' + appId);
                        var starElements = ratingDiv.querySelectorAll('.star');
                        for (var i = 0; i < starElements.length; i++) {
                            starElements[i].className = 'star' + (i < stars ? ' active' : '');
                        }
                        showAlert('Rated ' + stars + ' stars!', 'success');
                        // Reload apps to show updated average rating
                        setTimeout(function () { loadApps(); }, 500);
                    })
                    .catch(function () {
                        showAlert('Error submitting rating', 'error');
                    });
            }

            function showAlert(message, type) {
                var alertBox = document.getElementById('alertBox');
                alertBox.textContent = message;
                alertBox.className = 'alert ' + type;
                alertBox.style.display = 'block';
                setTimeout(function () { alertBox.style.display = 'none'; }, 3000);
            }

            loadApps();
        </script>
        <footer
            style="text-align: center; padding: 2rem; color: rgba(255, 255, 255, 0.5); border-top: 1px solid rgba(255, 255, 255, 0.1); margin-top: 3rem;">
            <p>Made with <span style="color: #ff2e63;">❤</span> by Vatsal Jaiswal | © 2025 All Rights Reserved</p>
        </footer>
    </body>

    </html>
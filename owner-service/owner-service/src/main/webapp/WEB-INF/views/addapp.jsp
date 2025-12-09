<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add App - PlayStore</title>
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

            .container {
                padding: 2rem 5%;
                max-width: 700px;
                margin: 0 auto;
            }

            h1 {
                font-size: 2rem;
                margin-bottom: 2rem;
            }

            .form-card {
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 20px;
                padding: 2rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.4rem;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 0.85rem 1rem;
                font-size: 0.95rem;
                font-family: inherit;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                color: #fff;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #00d9ff;
            }

            .form-group select option {
                background: #1a1a2e;
                color: #fff;
            }

            .btn-submit {
                width: 100%;
                padding: 1rem;
                font-size: 1rem;
                font-weight: 600;
                font-family: inherit;
                background: linear-gradient(135deg, #00d9ff, #00b4d8);
                color: #0f0f1a;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                margin-top: 0.5rem;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
            }

            .btn-submit:disabled {
                opacity: 0.6;
                cursor: not-allowed;
            }

            .alert {
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1rem;
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
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore Developer</div>
            <div class="nav-links">
                <a href="/dashboard">Dashboard</a>
                <a href="/my-apps">My Apps</a>
                <a href="/add-app" class="active">Add App</a>
            </div>
        </nav>
        <main class="container">
            <h1>Publish New App</h1>
            <div class="form-card">
                <div id="alertBox" class="alert"></div>
                <form id="addAppForm">
                    <div class="form-group">
                        <label for="appName">App Name</label>
                        <input type="text" id="appName" placeholder="My Awesome App" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" rows="3" placeholder="Describe your app..." required></textarea>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="version">Version</label>
                            <input type="text" id="version" placeholder="1.0.0" required>
                        </div>
                        <div class="form-group">
                            <label for="genre">Genre</label>
                            <select id="genre" required>
                                <option value="">Select Genre</option>
                                <option value="Games">Games</option>
                                <option value="Education">Education</option>
                                <option value="Health">Health</option>
                                <option value="Productivity">Productivity</option>
                                <option value="Social">Social</option>
                                <option value="Entertainment">Entertainment</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="appType">App Type</label>
                            <select id="appType" required onchange="togglePrice()">
                                <option value="FREE">Free</option>
                                <option value="PAID">Paid</option>
                            </select>
                        </div>
                        <div class="form-group" id="priceGroup" style="display:none;">
                            <label for="price">Price ($)</label>
                            <input type="number" id="price" step="0.01" min="0" placeholder="4.99">
                        </div>
                    </div>
                    <button type="submit" class="btn-submit" id="submitBtn">Publish App</button>
                </form>
            </div>
        </main>
        <script>
            var token = localStorage.getItem('ownerToken');
            if (!token) window.location.href = '/login';

            function togglePrice() {
                var priceGroup = document.getElementById('priceGroup');
                var appType = document.getElementById('appType').value;
                priceGroup.style.display = appType === 'PAID' ? 'block' : 'none';
            }

            document.getElementById('addAppForm').onsubmit = function (e) {
                e.preventDefault();
                var btn = document.getElementById('submitBtn');
                var alertBox = document.getElementById('alertBox');
                btn.disabled = true;
                btn.textContent = 'Publishing...';
                alertBox.style.display = 'none';

                var data = {
                    appName: document.getElementById('appName').value,
                    description: document.getElementById('description').value,
                    version: document.getElementById('version').value,
                    genre: document.getElementById('genre').value,
                    appType: document.getElementById('appType').value,
                    price: parseFloat(document.getElementById('price').value) || 0,
                    appOwnerId: parseInt(localStorage.getItem('ownerId'))
                };

                fetch('/api/owner/add-app', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + token },
                    body: JSON.stringify(data)
                })
                    .then(function (res) {
                        if (res.ok) {
                            alertBox.className = 'alert success';
                            alertBox.textContent = 'App published successfully!';
                            alertBox.style.display = 'block';
                            setTimeout(function () { window.location.href = '/my-apps'; }, 1500);
                        } else {
                            return res.text().then(function (text) { throw new Error(text); });
                        }
                    })
                    .catch(function (err) {
                        alertBox.className = 'alert error';
                        alertBox.textContent = err.message;
                        alertBox.style.display = 'block';
                        btn.disabled = false;
                        btn.textContent = 'Publish App';
                    });
            };
        </script>
    </body>

    </html>
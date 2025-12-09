<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Users - PlayStore</title>
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

            h1 {
                font-size: 2rem;
                margin-bottom: 2rem;
            }

            .tabs {
                display: flex;
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .tab {
                padding: 0.75rem 1.5rem;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
                color: #fff;
            }

            .tab.active {
                background: linear-gradient(135deg, #ff2e63, #ff6b6b);
                border-color: transparent;
            }

            .tab:hover:not(.active) {
                background: rgba(255, 255, 255, 0.1);
            }

            .users-table {
                width: 100%;
                border-collapse: collapse;
                background: rgba(255, 255, 255, 0.02);
                border-radius: 16px;
                overflow: hidden;
            }

            .users-table th,
            .users-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            }

            .users-table th {
                background: rgba(255, 255, 255, 0.05);
                color: rgba(255, 255, 255, 0.7);
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
            }

            .users-table tr:hover {
                background: rgba(255, 255, 255, 0.03);
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-badge.pending {
                background: rgba(255, 193, 7, 0.2);
                color: #ffc107;
            }

            .status-badge.active {
                background: rgba(0, 255, 136, 0.2);
                color: #00ff88;
            }

            .status-badge.inactive {
                background: rgba(255, 46, 99, 0.2);
                color: #ff2e63;
            }

            .action-btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                font-size: 0.85rem;
                transition: all 0.3s;
                margin-right: 0.5rem;
            }

            .action-btn.activate {
                background: rgba(0, 255, 136, 0.2);
                color: #00ff88;
                border: 1px solid rgba(0, 255, 136, 0.3);
            }

            .action-btn.deactivate {
                background: rgba(255, 46, 99, 0.2);
                color: #ff2e63;
                border: 1px solid rgba(255, 46, 99, 0.3);
            }

            .loading,
            .empty {
                text-align: center;
                padding: 3rem;
                color: rgba(255, 255, 255, 0.6);
            }

            .alert {
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1rem;
            }

            .alert.success {
                background: rgba(0, 255, 136, 0.1);
                border: 1px solid rgba(0, 255, 136, 0.3);
                color: #00ff88;
            }

            .alert.error {
                background: rgba(255, 46, 99, 0.1);
                border: 1px solid rgba(255, 46, 99, 0.3);
                color: #ff2e63;
            }
        </style>
    </head>

    <body>
        <nav>
            <div class="logo">PlayStore Developer</div>
            <div class="nav-links">
                <a href="/dashboard">Dashboard</a>
                <a href="/my-apps">My Apps</a>
                <a href="/add-app">Add App</a>
                <a href="/users" class="active">Users</a>
            </div>
            <button class="btn-logout" onclick="logout()">Logout</button>
        </nav>
        <main class="container">
            <h1>Manage Users</h1>
            <div id="alertBox" class="alert" style="display:none;"></div>
            <div class="tabs">
                <button class="tab active" id="tabPending" onclick="filterUsers('pending')">Pending Approval</button>
                <button class="tab" id="tabActive" onclick="filterUsers('active')">Active Users</button>
                <button class="tab" id="tabAll" onclick="filterUsers('all')">All Users</button>
            </div>
            <table class="users-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="usersBody">
                    <tr>
                        <td colspan="6" class="loading">Loading users...</td>
                    </tr>
                </tbody>
            </table>
        </main>
        <script>
            var token = localStorage.getItem('ownerToken');
            if (!token) window.location.href = '/login';
            var allUsers = [];
            var currentFilter = 'pending';

            function loadUsers() {
                fetch('/api/owner/users/all', { headers: { 'Authorization': 'Bearer ' + token } })
                    .then(function (res) { return res.json(); })
                    .then(function (users) {
                        allUsers = users;
                        filterUsers(currentFilter);
                    })
                    .catch(function () {
                        document.getElementById('usersBody').innerHTML = '<tr><td colspan="6" class="loading">Error loading users</td></tr>';
                    });
            }

            function filterUsers(filter) {
                currentFilter = filter;
                document.getElementById('tabPending').className = 'tab' + (filter === 'pending' ? ' active' : '');
                document.getElementById('tabActive').className = 'tab' + (filter === 'active' ? ' active' : '');
                document.getElementById('tabAll').className = 'tab' + (filter === 'all' ? ' active' : '');

                var filtered = allUsers;
                if (filter === 'pending') {
                    filtered = allUsers.filter(function (u) { return u.status === 'PENDING'; });
                } else if (filter === 'active') {
                    filtered = allUsers.filter(function (u) { return u.status === 'ACTIVE'; });
                }
                renderUsers(filtered);
            }

            function renderUsers(users) {
                var tbody = document.getElementById('usersBody');
                if (users.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="6" class="empty">No users found</td></tr>';
                    return;
                }
                var html = '';
                for (var i = 0; i < users.length; i++) {
                    var u = users[i];
                    var statusClass = u.status.toLowerCase();
                    var actions = '';
                    if (u.status !== 'ACTIVE') {
                        actions += '<button class="action-btn activate" onclick="activateUser(' + u.userId + ')">Activate</button>';
                    }
                    if (u.status === 'ACTIVE') {
                        actions += '<button class="action-btn deactivate" onclick="deactivateUser(' + u.userId + ')">Deactivate</button>';
                    }
                    html += '<tr>' +
                        '<td>' + u.userId + '</td>' +
                        '<td>' + u.firstName + ' ' + u.lastName + '</td>' +
                        '<td>' + u.userName + '</td>' +
                        '<td>' + u.email + '</td>' +
                        '<td><span class="status-badge ' + statusClass + '">' + u.status + '</span></td>' +
                        '<td>' + actions + '</td>' +
                        '</tr>';
                }
                tbody.innerHTML = html;
            }

            function activateUser(id) {
                showAlert('Activating user...', 'success');
                fetch('/api/owner/users/' + id + '/activate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                })
                    .then(function (res) {
                        if (res.ok) {
                            showAlert('User activated!', 'success');
                            loadUsers();
                        } else {
                            showAlert('Error activating user', 'error');
                        }
                    })
                    .catch(function (e) { showAlert('Error: ' + e.message, 'error'); });
            }

            function deactivateUser(id) {
                fetch('/api/owner/users/' + id + '/deactivate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                })
                    .then(function (res) {
                        if (res.ok) {
                            showAlert('User deactivated.', 'success');
                            loadUsers();
                        } else {
                            showAlert('Error deactivating user', 'error');
                        }
                    })
                    .catch(function (e) { showAlert('Error: ' + e.message, 'error'); });
            }

            function showAlert(msg, type) {
                var box = document.getElementById('alertBox');
                box.className = 'alert ' + type;
                box.textContent = msg;
                box.style.display = 'block';
                setTimeout(function () { box.style.display = 'none'; }, 4000);
            }

            function logout() { localStorage.clear(); window.location.href = '/login'; }
            loadUsers();
        </script>
    </body>

    </html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>User Panel</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #eef1f5;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        h1, h2, h3 {
            color: #333;
            margin-bottom: 10px;
        }
        .section {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fafafa;
        }
        .user-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-weight: bold;
            color: #444;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px 14px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .btn {
            padding: 10px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.2s ease;
            font-size: 14px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        .back-button {
            margin-bottom: 25px;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .status-pending {
            color: #ffc107;
        }
        .status-confirmed {
            color: #28a745;
        }
        .status-cancelled {
            color: #dc3545;
        }
        .status-completed {
            color: #17a2b8;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="back-button">
        <a href="${pageContext.request.contextPath}/cars" class="btn btn-secondary">← Back to Cars</a>
    </div>

    <h1>User Panel</h1>

    <div class="section">
        <h2>Account Information</h2>
        <form method="post" action="/user/update-info">
            <div class="user-info">
                <div class="info-item">
                    <label class="info-label">First Name:</label>
                    <input type="text" name="firstName" value="${user.firstName}" required>
                </div>
                <div class="info-item">
                    <label class="info-label">Last Name:</label>
                    <input type="text" name="lastName" value="${user.lastName}" required>
                </div>
                <div class="info-item">
                    <label class="info-label">Email:</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>
                <div class="info-item">
                    <label class="info-label">Phone:</label>
                    <input type="tel" name="telephone" value="${user.telephone}" required>
                </div>
                <div class="info-item">
                    <label class="info-label">Date of Birth:</label>
                    <span>${user.dateOfBirth}</span>
                </div>
            </div>
            <br>
            <button type="submit" class="btn">Update Information</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h3 style="margin-top: 30px;">Change Password</h3>
        <form method="post" action="/user/change-password">
            <div class="user-info">
                <div class="info-item">
                    <label class="info-label">Current Password:</label>
                    <input type="password" name="currentPassword" required>
                </div>
                <div class="info-item">
                    <label class="info-label">New Password:</label>
                    <input type="password" name="newPassword" required>
                </div>
                <div class="info-item">
                    <label class="info-label">Confirm New Password:</label>
                    <input type="password" name="confirmPassword" required>
                </div>
            </div>
            <br>
            <button type="submit" class="btn">Change Password</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>

    <div class="section">
        <h2>Your Orders</h2>
        <c:choose>
            <c:when test="${not empty orders}">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Car</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.car.brand} ${order.car.model}</td>
                            <td>${order.startDate}</td>
                            <td>${order.endDate}</td>
                            <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencyCode="USD"/></td>
                            <td class="status-${order.status.toString().toLowerCase()}">${order.status}</td>
                            <td>
                                <c:if test="${order.status == 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/orders/cancel/${order.id}" method="post" style="margin: 0;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to cancel this order?');">Cancel</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>You don't have any orders yet.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>

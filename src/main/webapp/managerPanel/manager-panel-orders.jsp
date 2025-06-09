<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .navbar h1 { margin: 0; font-size: 24px; color: #333; }
        .navbar .nav-links a {
            margin-right: 15px;
            text-decoration: none;
            color: #2196F3;
            font-weight: bold;
        }
        .navbar .nav-links a.active {
            color: #0b7dda;
            text-decoration: underline;
        }
        .logout-form button {
            background: none;
            border: none;
            color: #f44336;
            cursor: pointer;
            padding: 0;
            font-weight: bold;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            table-layout: fixed;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .action-buttons a { margin-right: 5px; }
        .add-btn { margin-bottom: 15px; }
        .filter-form {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .filter-form input[type="text"], .filter-form select {
            padding: 5px;
        }
        .filter-form button {
            padding: 6px 12px;
            background: #2196F3;
            color: white;
            border: none;
            cursor: pointer;
        }
        /* New styles for dropdown controls */
        .compact-select {
            max-width: 150px; /* Adjust as needed */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .compact-select option {
            padding: 3px 8px;
        }
        /* Column width adjustments */
        td:nth-child(1) { width: 5%; }  /* ID */
        td:nth-child(2) { width: 10%; } /* User */
        td:nth-child(3) { width: 15%; } /* Car */
        td:nth-child(4) { width: 12%; } /* Status */
        td:nth-child(5) { width: 15%; } /* Pickup */
        td:nth-child(6) { width: 15%; } /* Return */
        td:nth-child(7) { width: 15%; } /* Actions */
    </style>
</head>
<body>
<div class="navbar">
    <h1>Manager Panel</h1>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/orders/manager/manage" class="active">Orders</a>
        <a href="${pageContext.request.contextPath}/cars/manager">Cars</a>
        <a href="?lang=pl">PL</a>
        <a href="?lang=en">EN</a>
        <form:form action="/logout" method="post" class="logout-form" style="display:inline;">
            <button type="submit">Logout</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form:form>
    </div>
</div>

<c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
</c:if>

<table class="table table-bordered table-hover">
    <thead class="table-light">
    <tr>
        <th>ID</th>
        <th>User</th>
        <th>Car</th>
        <th>Status</th>
        <th>Pickup Location</th>
        <th>Return Location</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="order" items="${orders}">
        <tr>
            <form method="post" action="${pageContext.request.contextPath}/orders/update/manager">
                <input type="hidden" name="orderId" value="${order.id}" />
                <td>${order.id}</td>
                <td>${order.user.login}</td>
                <td>${order.car.brand} ${order.car.model}</td>
                <td>
                    <select class="form-select form-select-sm compact-select" name="status">
                        <c:forEach var="status" items="${statuses}">
                            <option value="${status}" ${status == order.status ? 'selected' : ''}>${status}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select class="form-select form-select-sm compact-select" name="pickupLocationId">
                        <c:forEach var="loc" items="${locations}">
                            <option value="${loc.id}" ${order.pickupLocation != null && loc.id == order.pickupLocation.id ? 'selected' : ''}>
                                    ${loc.city}, ${loc.address}
                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select class="form-select form-select-sm compact-select" name="returnLocationId">
                        <c:forEach var="loc" items="${locations}">
                            <option value="${loc.id}" ${order.returnLocation != null && loc.id == order.returnLocation.id ? 'selected' : ''}>
                                    ${loc.city}, ${loc.address}
                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td class="d-flex gap-2">
                    <button class="btn btn-sm btn-primary" type="submit">Update</button>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
            <form method="post" action="${pageContext.request.contextPath}/orders/manager/delete/${order.id}">
                <button class="btn btn-sm btn-danger" type="submit">Delete</button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
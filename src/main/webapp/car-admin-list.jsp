<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Car Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .nav-links form {
            display: inline;
        }
        .nav-links button {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
        }
        .table th, .table td {
            vertical-align: middle;
        }
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
        .action-buttons a {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <h1>Admin Panel</h1>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/users">Users</a>
        <a href="${pageContext.request.contextPath}/orders/manage">Orders</a>
        <a href="${pageContext.request.contextPath}/cars/admin/manage" class="active">Cars</a>
        <a href="?lang=pl">PL</a>
        <a href="?lang=en">EN</a>
        <form:form action="/logout" method="post" class="logout-form">
            <button type="submit">Logout</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form:form>
    </div>
</div>

<div class="filter-box mb-3">
    <form method="get" class="filter-form d-flex flex-wrap gap-3 align-items-end">
        <div>
            <label for="brand">Brand:</label>
            <select name="brand" id="brand" class="form-select">
                <option value="">All</option>
                <c:forEach items="${brands}" var="carBrand">
                    <option value="${carBrand}" ${param.brand == carBrand ? 'selected' : ''}>${carBrand}</option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="sort">Sort by:</label>
            <select name="sort" id="sort" class="form-select">
                <option value="">Default</option>
                <option value="brand_asc" ${param.sort == 'brand_asc' ? 'selected' : ''}>Brand (A-Z)</option>
                <option value="brand_desc" ${param.sort == 'brand_desc' ? 'selected' : ''}>Brand (Z-A)</option>
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price (Low to High)</option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price (High to Low)</option>
                <option value="year_asc" ${param.sort == 'year_asc' ? 'selected' : ''}>Year (Oldest)</option>
                <option value="year_desc" ${param.sort == 'year_desc' ? 'selected' : ''}>Year (Newest)</option>
            </select>
        </div>

        <div>
            <button type="submit" class="btn btn-primary">Filter</button>
            <a href="${pageContext.request.contextPath}/cars/admin/manage" class="btn btn-secondary">Reset</a>
        </div>
    </form>
</div>


<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Manage Cars</h2>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/cars/admin/add">Add New Car</a>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Brand</th>
                <th>Model</th>
                <th>Year</th>
                <th>License</th>
                <th>Color</th>
                <th>Cost</th>
                <th style="width: 150px;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="car" items="${cars}">
                <tr>
                    <td>${car.id}</td>
                    <td>${car.brand}</td>
                    <td>${car.model}</td>
                    <td>${car.year}</td>
                    <td>${car.licensePlate}</td>
                    <td>${car.color}</td>
                    <td>$${car.dailyCost}</td>
                    <td>
                        <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/cars/admin/edit/${car.id}">Edit</a>
                        <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/cars/admin/delete/${car.id}"
                           onclick="return confirm('Are you sure you want to delete this car?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

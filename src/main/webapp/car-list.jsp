<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .header {
            background-color: #f8f9fa;
            padding: 15px 0;
            margin-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
        }

        .company-name {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
            text-decoration: none;
        }

        .account-dropdown {
            cursor: pointer;
        }

        .dropdown-menu {
            min-width: 200px;
        }

        .dropdown-item {
            padding: 10px 20px;
        }

        .dropdown-item i {
            margin-right: 10px;
        }

        .filter-box {
            background: #f5f5f5;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .filter-box form {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filter-box label {
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0;
        }

        .filter-box select,
        .filter-box input[type="number"] {
            padding: 6px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .filter-box button[type="submit"] {
            padding: 6px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .filter-box button[type="submit"]:hover {
            background-color: #0069d9;
        }

        .filter-box a {
            padding: 6px 15px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .filter-box a:hover {
            background-color: #5a6268;
        }

        .car-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
            margin: 0;
        }

        .car-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            width: calc(33.33% - 20px);
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .car-img {
            width: 100%;
            height: 140px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            border-radius: 4px;
            overflow: hidden;
        }

        .car-img img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            border-radius: 4px;
        }

        .car-card h3 {
            margin: 0 0 8px 0;
            color: #333;
            font-size: 18px;
        }

        .car-card p {
            margin: 3px 0;
            color: #666;
            font-size: 14px;
        }

        .car-card a {
            display: inline-block;
            margin-top: auto;
            padding: 6px 12px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            text-align: center;
        }

        .car-card a:hover {
            background: #0056b3;
        }

        @media (max-width: 992px) {
            .car-card {
                width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .car-card {
                width: 100%;
            }

            .filter-box form {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
    <title>CarRental.com</title>
</head>
<body>
<header class="header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}" class="company-name">CarRental.com</a>

            <div class="dropdown">
                <div class="account-dropdown dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle" style="font-size: 2rem;"></i>
                </div>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                            <i class="bi bi-list-check"></i> My Orders
                        </a>
                    </li>
                    <li>
                        <form:form action="/logout" method="post" class="p-0">
                            <button type="submit" class="dropdown-item border-0 bg-transparent" style="width: 100%; text-align: left;">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form:form>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>

<div class="container" style="padding: 0 10px;">
    <div class="filter-box">
        <form method="get">
            <label>Brand:
                <select name="brand">
                    <option value="">All</option>
                    <c:forEach items="${brands}" var="carBrand">
                        <option value="${carBrand}" ${param.brand == carBrand ? 'selected' : ''}>${carBrand}</option>
                    </c:forEach>
                </select>
            </label>

            <label>Min Price: <input type="number" name="minPrice" value="${param.minPrice}" step="10"></label>
            <label>Max Price: <input type="number" name="maxPrice" value="${param.maxPrice}" step="10"></label>

            <label>Sort by:
                <select name="sort">
                    <option value="">Default</option>
                    <option value="brand_asc" ${param.sort == 'brand_asc' ? 'selected' : ''}>Brand (A-Z)</option>
                    <option value="brand_desc" ${param.sort == 'brand_desc' ? 'selected' : ''}>Brand (Z-A)</option>
                    <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price (Low to High)</option>
                    <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price (High to Low)</option>
                    <option value="year_asc" ${param.sort == 'year_asc' ? 'selected' : ''}>Year (Oldest)</option>
                    <option value="year_desc" ${param.sort == 'year_desc' ? 'selected' : ''}>Year (Newest)</option>
                </select>
            </label>

            <button type="submit">Filter</button>
            <a href="${pageContext.request.contextPath}/cars">Reset</a>
        </form>
    </div>

    <div class="car-list">
        <c:forEach items="${cars}" var="car">
            <div class="car-card">
                <div class="car-img">
                    <c:choose>
                        <c:when test="${not empty car.imageUrl}">
                            <img src="${car.imageUrl}" alt="${car.brand} + ${car.model}"/></a>
                        </c:when>
                        <c:otherwise>
                            <span>No image</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h3>${car.brand} ${car.model} (${car.year})</h3>
                <p>License: ${car.licensePlate}</p>
                <p>Color: ${car.color}</p>
                <p>Price: $<fmt:formatNumber value="${car.dailyCost}" pattern="#,##0.00"/>/day</p>
                <a href="${pageContext.request.contextPath}/cars/${car.id}">Rent Now</a>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
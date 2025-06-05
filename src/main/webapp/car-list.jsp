<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Available Cars</title>
    <style>
        .filter-box {
            background: #f5f5f5;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .filter-box label {
            margin-right: 15px;
        }
        .car-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
        }
        .car-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            width: calc(33.33% - 20px);
            box-sizing: border-box;
        }
        .car-img {
            width: 100%;
            height: 180px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            border-radius: 4px;
        }
        .car-card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .car-card p {
            margin: 5px 0;
            color: #666;
        }
        .car-card a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .car-card a:hover {
            background: #0056b3;
        }
        @media (max-width: 992px) {
            .car-card {
                width: calc(50% - 15px);
            }
        }
        @media (max-width: 576px) {
            .car-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<h1>Available Cars</h1>

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
            <img src="${car.imagePath}" alt="${car.brand} ${car.model}">
            <h3>${car.brand} ${car.model} (${car.year})</h3>
            <p>License: ${car.licensePlate}</p>
            <p>Color: ${car.color}</p>
            <p>Price: $<fmt:formatNumber value="${car.dailyCost}" pattern="#,##0.00"/>/day</p>
            <a href="${pageContext.request.contextPath}/cars/${car.id}">Rent Now</a>
        </div>
    </c:forEach>
</div>
</body>
</html>
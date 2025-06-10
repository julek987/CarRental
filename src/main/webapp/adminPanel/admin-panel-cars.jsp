<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="car.management.title"/></title>
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
            position: relative;
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
    <h1><spring:message code="admin.panel"/></h1>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/users"><spring:message code="nav.users"/></a>
        <a href="${pageContext.request.contextPath}/orders/manage"><spring:message code="nav.orders"/></a>
        <a href="${pageContext.request.contextPath}/cars/admin/manage" class="active"><spring:message code="nav.cars"/></a>
        <a href="?lang=pl">PL</a>
        <a href="?lang=en">EN</a>
        <form:form action="/logout" method="post" class="logout-form" style="display:inline;">
            <button type="submit"><spring:message code="button.logout"/></button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form:form>
    </div>
</div>


<div class="filter-box mb-3">
    <form method="get" class="filter-form d-flex flex-wrap gap-3 align-items-end">
        <div>
            <label for="brand"><spring:message code="filter.brand"/></label>
            <select name="brand" id="brand" class="form-select">
                <option value=""><spring:message code="filter.all"/></option>
                <c:forEach items="${brands}" var="carBrand">
                    <option value="${carBrand}" ${param.brand == carBrand ? 'selected' : ''}>${carBrand}</option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="sort"><spring:message code="filter.sortBy"/></label>
            <select name="sort" id="sort" class="form-select">
                <option value=""><spring:message code="filter.default"/></option>
                <option value="brand_asc" ${param.sort == 'brand_asc' ? 'selected' : ''}><spring:message code="sort.brandAsc"/></option>
                <option value="brand_desc" ${param.sort == 'brand_desc' ? 'selected' : ''}><spring:message code="sort.brandDesc"/></option>
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}><spring:message code="sort.priceAsc"/></option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}><spring:message code="sort.priceDesc"/></option>
                <option value="year_asc" ${param.sort == 'year_asc' ? 'selected' : ''}><spring:message code="sort.yearAsc"/></option>
                <option value="year_desc" ${param.sort == 'year_desc' ? 'selected' : ''}><spring:message code="sort.yearDesc"/></option>
            </select>
        </div>

        <div>
            <button type="submit" class="btn btn-primary"><spring:message code="button.filter"/></button>
            <a href="${pageContext.request.contextPath}/cars/admin/manage" class="btn btn-secondary"><spring:message code="button.reset"/></a>
        </div>
    </form>
</div>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2><spring:message code="manage.cars.heading"/></h2>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/cars/admin/add"><spring:message code="button.addNewCar"/></a>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-dark">
            <tr>
                <th><spring:message code="table.id"/></th>
                <th><spring:message code="table.brand"/></th>
                <th><spring:message code="table.model"/></th>
                <th><spring:message code="table.year"/></th>
                <th><spring:message code="table.license"/></th>
                <th><spring:message code="table.color"/></th>
                <th><spring:message code="table.cost"/></th>
                <th style="width: 150px;"><spring:message code="table.actions"/></th>
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
                        <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/cars/admin/edit/${car.id}"><spring:message code="button.edit"/></a>
                        <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/cars/admin/delete/${car.id}"
                           onclick="return confirm('<spring:message code="confirm.deleteCar"/>')"><spring:message code="button.delete"/></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

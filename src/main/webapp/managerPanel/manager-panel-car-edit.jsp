<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="car.management.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
            margin-bottom: 20px;
        }

        .navbar h1 {
            font-size: 24px;
            margin: 0;
        }

        .nav-links a {
            margin-right: 15px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .nav-links a.active {
            color: #0056b3;
            text-decoration: underline;
        }

        .logout-form {
            display: inline;
        }

        .logout-form button {
            background: none;
            border: none;
            color: #dc3545;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">

    <!-- MANAGER NAVBAR -->
    <div class="navbar">
        <h1><spring:message code="manager.panel"/></h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/cars/manager" class="active">
                <spring:message code="nav.cars"/>
            </a>
            <a href="?lang=pl">PL</a>
            <a href="?lang=en">EN</a>
            <form:form action="/logout" method="post" class="logout-form">
                <button type="submit"><spring:message code="button.logout"/></button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form:form>
        </div>
    </div>

    <!-- TITLE -->
    <c:choose>
        <c:when test="${car.id != null}">
            <h2><spring:message code="car.edit.title"/></h2>
        </c:when>
        <c:otherwise>
            <h2><spring:message code="car.add.title"/></h2>
        </c:otherwise>
    </c:choose>

    <!-- FORM -->
    <form:form method="post" action="${pageContext.request.contextPath}/cars/manager/edit" modelAttribute="car" class="row g-3">
        <form:hidden path="id"/>

        <div class="col-md-6">
            <label class="form-label"><spring:message code="form.label.brand"/></label>
            <form:input path="brand" class="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label"><spring:message code="form.label.model"/></label>
            <form:input path="model" class="form-control"/>
        </div>

        <div class="col-md-4">
            <label class="form-label"><spring:message code="form.label.year"/></label>
            <form:input path="year" type="number" class="form-control"/>
        </div>

        <div class="col-md-4">
            <label class="form-label"><spring:message code="form.label.licensePlate"/></label>
            <form:input path="licensePlate" class="form-control"/>
        </div>

        <div class="col-md-4">
            <label class="form-label"><spring:message code="form.label.color"/></label>
            <form:input path="color" class="form-control"/>
        </div>

        <div class="col-md-4">
            <label class="form-label"><spring:message code="form.label.dailyCost"/></label>
            <form:input path="dailyCost" type="number" step="0.01" class="form-control"/>
        </div>

        <div class="col-md-4">
            <label class="form-label"><spring:message code="form.label.available"/></label>
            <form:select path="available" class="form-control">
                <form:option value="true"><spring:message code="value.yes"/></form:option>
                <form:option value="false"><spring:message code="value.no"/></form:option>
            </form:select>
        </div>

        <div class="col-md-12">
            <label class="form-label"><spring:message code="form.label.imageUrl"/></label>
            <form:input path="imageUrl" class="form-control"/>
        </div>

        <div class="col-md-12">
            <button type="submit" class="btn btn-primary"><spring:message code="button.save"/></button>
            <a href="${pageContext.request.contextPath}/cars/manager" class="btn btn-secondary">
                <spring:message code="button.cancel"/>
            </a>
        </div>
    </form:form>
</div>
</body>
</html>

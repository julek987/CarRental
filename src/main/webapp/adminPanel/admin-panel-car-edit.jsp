<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="car.edit.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .lang-switcher {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
<div class="lang-switcher">
    <a href="?lang=pl" class="btn btn-sm btn-outline-secondary me-1">PL</a>
    <a href="?lang=en" class="btn btn-sm btn-outline-secondary">EN</a>
</div>

<div class="container mt-4">
    <h2>
        <c:choose>
            <c:when test="${car.id != null}">
                <spring:message code="car.edit.heading.edit"/>
            </c:when>
            <c:otherwise>
                <spring:message code="car.edit.heading.add"/>
            </c:otherwise>
        </c:choose>
    </h2>

    <form:form method="post" action="${pageContext.request.contextPath}/cars/admin/edit" modelAttribute="car" class="row g-3">
        <form:hidden path="id"/>

        <div class="col-md-6">
            <label class="form-label" for="brand"><spring:message code="car.brand"/></label>
            <form:input path="brand" id="brand" class="form-control"/>
        </div>
        <div class="col-md-6">
            <label class="form-label" for="model"><spring:message code="car.model"/></label>
            <form:input path="model" id="model" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label" for="year"><spring:message code="car.year"/></label>
            <form:input path="year" type="number" id="year" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label" for="licensePlate"><spring:message code="car.licensePlate"/></label>
            <form:input path="licensePlate" id="licensePlate" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label" for="color"><spring:message code="car.color"/></label>
            <form:input path="color" id="color" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label" for="dailyCost"><spring:message code="car.dailyCost"/></label>
            <form:input path="dailyCost" type="number" step="0.01" id="dailyCost" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label" for="available"><spring:message code="car.available"/></label>
            <form:select path="available" id="available" class="form-control">
                <form:option value="true"><spring:message code="option.yes"/></form:option>
                <form:option value="false"><spring:message code="option.no"/></form:option>
            </form:select>
        </div>
        <div class="col-md-12">
            <label class="form-label" for="imageUrl"><spring:message code="car.imageUrl"/></label>
            <form:input path="imageUrl" id="imageUrl" class="form-control"/>
        </div>
        <div class="col-md-12">
            <button type="submit" class="btn btn-primary"><spring:message code="button.save"/></button>
            <a href="${pageContext.request.contextPath}/cars/admin/manage" class="btn btn-secondary"><spring:message code="button.cancel"/></a>
        </div>
    </form:form>
</div>
</body>
</html>

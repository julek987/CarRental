<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Car</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>${car.id != null ? "Edit Car" : "Add New Car"}</h2>
    <form:form method="post" action="${pageContext.request.contextPath}/cars/manager/edit" modelAttribute="car" class="row g-3">
        <form:hidden path="id"/>
        <div class="col-md-6">
            <label class="form-label">Brand</label>
            <form:input path="brand" class="form-control"/>
        </div>
        <div class="col-md-6">
            <label class="form-label">Model</label>
            <form:input path="model" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label">Year</label>
            <form:input path="year" type="number" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label">License Plate</label>
            <form:input path="licensePlate" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label">Color</label>
            <form:input path="color" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label">Daily Cost</label>
            <form:input path="dailyCost" type="number" step="0.01" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label class="form-label">Available</label>
            <form:select path="available" class="form-control">
                <form:option value="true">Yes</form:option>
                <form:option value="false">No</form:option>
            </form:select>
        </div>
        <div class="col-md-12">
            <label class="form-label">Image URL</label>
            <form:input path="imageUrl" class="form-control"/>
        </div>
        <div class="col-md-12">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="${pageContext.request.contextPath}/cars/manager" class="btn btn-secondary">Cancel</a>
        </div>
    </form:form>
</div>
</body>
</html>

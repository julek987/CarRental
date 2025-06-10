<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="admin.panel.title" /></title>
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
    .add-btn {
      margin-bottom: 15px;
    }
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
    .action-buttons a {
      margin-right: 5px;
    }
  </style>
</head>
<body>

<div class="navbar">
  <h1><fmt:message key="admin.panel.title" /></h1>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/admin/users" class="active"><fmt:message key="nav.users" /></a>
    <a href="${pageContext.request.contextPath}/orders/manage"><fmt:message key="nav.orders" /></a>
    <a href="${pageContext.request.contextPath}/cars/admin/manage"><fmt:message key="nav.cars" /></a>
    <a href="?lang=pl">PL</a>
    <a href="?lang=en">EN</a>
    <form:form action="/logout" method="post" class="logout-form" style="display:inline;">
      <button type="submit"><fmt:message key="button.logout" /></button>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form:form>
  </div>
</div>

<div class="add-btn">
  <a href="users/add" class="btn btn-success btn-sm"><fmt:message key="button.addNewUser" /></a>
</div>

<form method="get" action="users" class="filter-form">
  <label for="loginSearch"><fmt:message key="filter.login" />:</label>
  <input type="text" id="loginSearch" name="login" value="${param.login != null ? param.login : ''}" placeholder="<fmt:message key='filter.loginPlaceholder' />">

  <label for="roleFilter"><fmt:message key="filter.role" />:</label>
  <select id="roleFilter" name="role" class="form-select form-select-sm" style="max-width: 150px;">
    <option value="" <c:if test="${param.role == null || param.role == ''}">selected</c:if>><fmt:message key="filter.role.all" /></option>
    <option value="ADMIN" <c:if test="${param.role == 'ADMIN'}">selected</c:if>><fmt:message key="role.admin" /></option>
    <option value="USER" <c:if test="${param.role == 'USER'}">selected</c:if>><fmt:message key="role.user" /></option>
    <option value="MANAGER" <c:if test="${param.role == 'MANAGER'}">selected</c:if>><fmt:message key="role.manager" /></option>
  </select>

  <button type="submit" class="btn btn-primary btn-sm"><fmt:message key="button.filter" /></button>
</form>

<table class="table table-bordered table-hover">
  <thead class="table-light">
  <tr>
    <th><fmt:message key="user.id" /></th>
    <th><fmt:message key="user.login" /></th>
    <th><fmt:message key="user.firstName" /></th>
    <th><fmt:message key="user.lastName" /></th>
    <th><fmt:message key="user.email" /></th>
    <th><fmt:message key="user.telephone" /></th>
    <th><fmt:message key="user.dateOfBirth" /></th>
    <th><fmt:message key="user.verified" /></th>
    <th><fmt:message key="user.role" /></th>
    <th><fmt:message key="table.actions" /></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${users}">
    <tr>
      <td>${user.id}</td>
      <td>${user.login}</td>
      <td>${user.firstName}</td>
      <td>${user.lastName}</td>
      <td>${user.email}</td>
      <td>${user.telephone}</td>
      <td>${user.dateOfBirth}</td>
      <td><c:choose>
        <c:when test="${user.verified}"><fmt:message key="value.yes" /></c:when>
        <c:otherwise><fmt:message key="value.no" /></c:otherwise>
      </c:choose></td>
      <td>${user.role}</td>
      <td class="d-flex gap-2">
        <a href="users/edit/${user.id}" class="btn btn-sm btn-primary"><fmt:message key="button.edit" /></a>
        <a href="users/delete/${user.id}" class="btn btn-sm btn-danger" onclick="return confirm('<fmt:message key="confirm.deleteUser" />')"><fmt:message key="button.delete" /></a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>

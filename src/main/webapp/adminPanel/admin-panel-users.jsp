<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Panel</title>
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
  <h1>Admin Panel</h1>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/admin/users" class="active">Users</a>
    <a href="${pageContext.request.contextPath}/orders/manage">Orders</a>
    <a href="${pageContext.request.contextPath}/cars/admin/manage">Cars</a>
    <a href="?lang=pl">PL</a>
    <a href="?lang=en">EN</a>
    <form:form action="/logout" method="post" class="logout-form" style="display:inline;">
      <button type="submit">Logout</button>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form:form>
  </div>
</div>

<div class="add-btn">
  <a href="users/add" class="btn btn-success btn-sm">Add New User</a>
</div>

<form method="get" action="users" class="filter-form">
  <label for="loginSearch">Login:</label>
  <input type="text" id="loginSearch" name="login" value="${param.login != null ? param.login : ''}" placeholder="Search by login">

  <label for="roleFilter">Role:</label>
  <select id="roleFilter" name="role" class="form-select form-select-sm" style="max-width: 150px;">
    <option value="" <c:if test="${param.role == null || param.role == ''}">selected</c:if>>All</option>
    <option value="ADMIN" <c:if test="${param.role == 'ADMIN'}">selected</c:if>>Admin</option>
    <option value="USER" <c:if test="${param.role == 'USER'}">selected</c:if>>User</option>
    <option value="MANAGER" <c:if test="${param.role == 'MANAGER'}">selected</c:if>>Manager</option>
  </select>

  <button type="submit" class="btn btn-primary btn-sm">Filter</button>
</form>

<table class="table table-bordered table-hover">
  <thead class="table-light">
  <tr>
    <th>ID</th>
    <th>Login</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Email</th>
    <th>Telephone</th>
    <th>Date of Birth</th>
    <th>Verified</th>
    <th>Role</th>
    <th>Actions</th>
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
      <td>${user.verified ? 'Yes' : 'No'}</td>
      <td>${user.role}</td>
      <td class="d-flex gap-2">
        <a href="users/edit/${user.id}" class="btn btn-sm btn-primary">Edit</a>
        <a href="users/delete/${user.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>User Management</title>
  <style>
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
    tr:nth-child(even) { background-color: #f9f9f9; }
    .action-buttons a { margin-right: 5px; }
    .header { margin-bottom: 20px; }
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
  </style>
</head>
<body>
<div class="header">
  <h1>User Management</h1>
  <span style="float: right">
    <a href="?lang=pl">PL</a> |
    <a href="?lang=en">EN</a>
  </span>
</div>

<div class="add-btn">
  <a href="users/add" style="padding: 8px 12px; background: #4CAF50; color: white; text-decoration: none;">Add New User</a>
</div>

<!-- Search and Filter Form -->
<form method="get" action="users" class="filter-form">
  <label for="loginSearch">Login:</label>
  <input type="text" id="loginSearch" name="login" value="${param.login != null ? param.login : ''}" placeholder="Search by login">

  <label for="roleFilter">Role:</label>
  <select id="roleFilter" name="role">
    <option value="" <c:if test="${param.role == null || param.role == ''}">selected</c:if>>All</option>
    <!-- Replace with actual roles if known -->
    <option value="ADMIN" <c:if test="${param.role == 'ADMIN'}">selected</c:if>>Admin</option>
    <option value="USER" <c:if test="${param.role == 'USER'}">selected</c:if>>User</option>
    <option value="MANAGER" <c:if test="${param.role == 'MANAGER'}">selected</c:if>>Manager</option>
  </select>

  <button type="submit">Filter</button>
</form>

<table>
  <thead>
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
      <td class="action-buttons">
        <a href="users/edit/${user.id}" style="padding: 3px 6px; background: #2196F3; color: white; text-decoration: none;">Edit</a>
        <a href="users/delete/${user.id}" style="padding: 3px 6px; background: #f44336; color: white; text-decoration: none;"
           onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>

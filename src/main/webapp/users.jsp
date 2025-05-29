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
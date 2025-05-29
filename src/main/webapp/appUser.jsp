<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>AppUser List</title>
</head>
<body>
<div class="header">
      <span style="float: right">
        <a style="background-color: white" href="?lang=pl">pl</a> |
        <a style="background-color: white" href="?lang=en">en</a>
      </span>
</div>
<h2>All Users</h2>

<table border="2px">
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
  </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${appUserList}">
    <tr>
      <td>${user.id}</td>
      <td>${user.login}</td>
      <td>${user.firstName}</td>
      <td>${user.lastName}</td>
      <td>${user.email}</td>
      <td>${user.telephone}</td>
      <td>${user.dateOfBirth}</td>
      <td><c:out value="${user.verified}" /></td>
      <td>${user.role}</td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>

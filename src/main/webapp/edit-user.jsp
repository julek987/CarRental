<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Edit User</title>
  <style>
    .form-container { max-width: 500px; margin: 20px auto; }
    .form-group { margin-bottom: 15px; }
    label { display: block; margin-bottom: 5px; }
    input[type="text"], input[type="email"], input[type="date"] {
      width: 100%; padding: 8px; box-sizing: border-box;
    }
    .form-actions { margin-top: 20px; }
    .btn { padding: 8px 15px; text-decoration: none; }
    .btn-save { background: #4CAF50; color: white; }
    .btn-cancel { background: #ccc; color: black; }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Edit User</h2>
  <form method="post" action="../edit/${user.id}">
    <input type="hidden" name="id" value="${user.id}">
    <div class="form-group">
      <label for="login">Login:</label>
      <input type="text" id="login" name="login" value="${user.login}" required>
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="text" id="password" name="password" value="${user.password}" required>
    </div>
    <div class="form-group">
      <label for="firstName">First Name:</label>
      <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
    </div>
    <div class="form-group">
      <label for="lastName">Last Name:</label>
      <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" value="${user.email}" required>
    </div>
    <div class="form-group">
      <label for="telephone">Telephone:</label>
      <input type="text" id="telephone" name="telephone" value="${user.telephone}">
    </div>
    <div class="form-group">
      <label for="dateOfBirth">Date of Birth:</label>
      <input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}">
    </div>
    <div class="form-group">
      <label for="verified">Verified:</label>
      <select id="verified" name="verified">
        <option value="true" ${user.verified ? 'selected' : ''}>Yes</option>
        <option value="false" ${not user.verified ? 'selected' : ''}>No</option>
      </select>
    </div>
    <div class="form-group">
      <label for="role">Role:</label>
      <input type="text" id="role" name="role" value="${user.role}" required>
    </div>
    <div class="form-actions">
      <button type="submit" class="btn btn-save">Update</button>
      <a href="../admin/users" class="btn btn-cancel">Cancel</a>
    </div>
  </form>
</div>
</body>
</html>
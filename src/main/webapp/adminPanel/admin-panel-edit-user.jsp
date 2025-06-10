<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="edit.user.title"/></title>
  <style>
    .form-container { max-width: 500px; margin: 20px auto; }
    .form-group { margin-bottom: 15px; }
    label { display: block; margin-bottom: 5px; }
    input[type="text"], input[type="email"], input[type="date"], select {
      width: 100%; padding: 8px; box-sizing: border-box;
    }
    .form-actions { margin-top: 20px; }
    .btn { padding: 8px 15px; text-decoration: none; border: none; cursor: pointer; display: inline-block; }
    .btn-save { background: #4CAF50; color: white; }
    .btn-cancel { background: #ccc; color: black; }

    .lang-switcher {
      position: fixed;
      top: 10px;
      right: 10px;
      font-weight: bold;
    }
    .lang-switcher a {
      margin-left: 10px;
      text-decoration: none;
      color: #2196F3;
    }
  </style>
</head>
<body>
<div class="lang-switcher">
  <a href="?lang=pl">PL</a>
  <a href="?lang=en">EN</a>
</div>

<div class="form-container">
  <h2><spring:message code="edit.user.heading"/></h2>
  <form method="post" action="../edit/${user.id}">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <input type="hidden" name="id" value="${user.id}">

    <div class="form-group">
      <label for="login"><spring:message code="edit.user.login"/></label>
      <input type="text" id="login" name="login" value="${user.login}" required>
    </div>
    <div class="form-group">
      <label for="password"><spring:message code="edit.user.password"/></label>
      <input type="text" id="password" name="password" value="${user.password}" required>
    </div>
    <div class="form-group">
      <label for="firstName"><spring:message code="edit.user.firstName"/></label>
      <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
    </div>
    <div class="form-group">
      <label for="lastName"><spring:message code="edit.user.lastName"/></label>
      <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
    </div>
    <div class="form-group">
      <label for="email"><spring:message code="edit.user.email"/></label>
      <input type="email" id="email" name="email" value="${user.email}" required>
    </div>
    <div class="form-group">
      <label for="telephone"><spring:message code="edit.user.telephone"/></label>
      <input type="text" id="telephone" name="telephone" value="${user.telephone}">
    </div>
    <div class="form-group">
      <label for="dateOfBirth"><spring:message code="edit.user.dateOfBirth"/></label>
      <input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}">
    </div>
    <div class="form-group">
      <label for="verified"><spring:message code="edit.user.verified"/></label>
      <select id="verified" name="verified">
        <option value="true" ${user.verified ? 'selected' : ''}><spring:message code="option.yes"/></option>
        <option value="false" ${not user.verified ? 'selected' : ''}><spring:message code="option.no"/></option>
      </select>
    </div>
    <div class="form-group">
      <label for="role"><spring:message code="edit.user.role"/></label>
      <select id="role" name="role" required>
        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
        <option value="MANAGER" ${user.role == 'MANAGER' ? 'selected' : ''}>MANAGER</option>
        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
      </select>
    </div>
    <div class="form-actions">
      <button type="submit" class="btn btn-save"><spring:message code="button.update"/></button>
      <a href="/admin/users" class="btn btn-cancel"><spring:message code="button.cancel"/></a>
    </div>
  </form>
</div>
</body>
</html>

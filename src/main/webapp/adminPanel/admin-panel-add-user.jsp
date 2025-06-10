<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="user.add.title"/></title>
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

<div class="form-container">
  <h2><spring:message code="user.add.title"/></h2>
  <form method="post" action="add">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <div class="form-group">
      <label for="login"><spring:message code="user.login"/></label>
      <input type="text" id="login" name="login" required>
    </div>
    <div class="form-group">
      <label for="password"><spring:message code="user.password"/></label>
      <input type="text" id="password" name="password" required>
    </div>
    <div class="form-group">
      <label for="firstName"><spring:message code="user.firstname"/></label>
      <input type="text" id="firstName" name="firstName" required>
    </div>
    <div class="form-group">
      <label for="lastName"><spring:message code="user.lastname"/></label>
      <input type="text" id="lastName" name="lastName" required>
    </div>
    <div class="form-group">
      <label for="email"><spring:message code="user.email"/></label>
      <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="telephone"><spring:message code="user.telephone"/></label>
      <input type="text" id="telephone" name="telephone">
    </div>
    <div class="form-group">
      <label for="dateOfBirth"><spring:message code="user.dateofbirth"/></label>
      <input type="date" id="dateOfBirth" name="dateOfBirth">
    </div>
    <div class="form-group">
      <label for="verified"><spring:message code="user.verified"/></label>
      <select id="verified" name="verified">
        <option value="true"><spring:message code="user.verified.yes"/></option>
        <option value="false"><spring:message code="user.verified.no"/></option>
      </select>
    </div>
    <div class="form-group">
      <label for="role"><spring:message code="user.role"/></label>
      <select id="role" name="role" required>
        <option value=""><spring:message code="user.role.select"/></option>
        <option value="USER"><spring:message code="user.role.user"/></option>
        <option value="MANAGER"><spring:message code="user.role.manager"/></option>
        <option value="ADMIN"><spring:message code="user.role.admin"/></option>
      </select>
    </div>
    <div class="form-actions">
      <button type="submit" class="btn btn-save"><spring:message code="button.save"/></button>
      <a href="/admin/users" class="btn btn-cancel"><spring:message code="button.cancel"/></a>
    </div>
  </form>
</div>
</body>
</html>

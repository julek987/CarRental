<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="label.login"/></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .login-container {
      max-width: 400px;
      margin: 100px auto 0;
    }
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

<div class="container">
  <div class="login-container">
    <div class="card shadow-sm">
      <div class="card-body p-4">
        <h2 class="card-title text-center mb-4"><spring:message code="label.login"/></h2>

        <form:form method="post" action="/login">
          <div class="mb-3">
            <label for="username" class="form-label"><spring:message code="label.username"/></label>
            <input type="text" class="form-control" id="username" name="username" required>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label"><spring:message code="label.password"/></label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>

          <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary"><spring:message code="label.login"/></button>
          </div>
        </form:form>

        <div class="text-center mt-3">
          <a href="/register" class="text-decoration-none"><spring:message code="label.register.redirect"/></a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
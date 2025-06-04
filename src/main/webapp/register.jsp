<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="label.register"/></title>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      min-height: 100vh;
      align-items: center;
    }
    .register-container {
      max-width: 400px;
      width: 100%;
      margin: 0 auto;
    }
    .lang-switcher {
      position: absolute;
      top: 15px;
      right: 15px;
    }
    .form-group {
      margin-bottom: 0.75rem;
    }
    .card-body {
      padding: 1.5rem;
    }
    .compact-input {
      padding: 0.375rem 0.75rem;
      font-size: 0.875rem;
    }
  </style>
</head>
<body>
<div class="lang-switcher">
  <a href="?lang=pl" class="btn btn-sm btn-outline-secondary me-1">PL</a>
  <a href="?lang=en" class="btn btn-sm btn-outline-secondary">EN</a>
</div>

<div class="container">
  <div class="register-container">
    <div class="card shadow-sm">
      <div class="card-body">
        <h4 class="card-title text-center mb-3"><spring:message code="label.register"/></h4>

        <form:form method="post" action="/register" modelAttribute="appUser">
          <div class="row g-2">
            <div class="col-6">
              <div class="form-group">
                <label for="firstName" class="form-label small"><spring:message code="label.firstName"/></label>
                <input type="text" class="form-control form-control-sm compact-input" id="firstName" name="firstName" required>
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label for="lastName" class="form-label small"><spring:message code="label.lastName"/></label>
                <input type="text" class="form-control form-control-sm compact-input" id="lastName" name="lastName" required>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="login" class="form-label small"><spring:message code="label.username"/></label>
            <input type="text" class="form-control form-control-sm compact-input" id="login" name="login" required>
          </div>

          <div class="form-group">
            <label for="password" class="form-label small"><spring:message code="label.password"/></label>
            <input type="password" class="form-control form-control-sm compact-input" id="password" name="password" required>
          </div>

          <div class="form-group">
            <label for="email" class="form-label small"><spring:message code="label.email"/></label>
            <input type="email" class="form-control form-control-sm compact-input" id="email" name="email" required>
          </div>

          <div class="row g-2">
            <div class="col-6">
              <div class="form-group">
                <label for="telephone" class="form-label small"><spring:message code="label.telephone"/></label>
                <input type="tel" class="form-control form-control-sm compact-input" id="telephone" name="telephone">
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label for="dateOfBirth" class="form-label small"><spring:message code="label.birthDate"/></label>
                <input type="date" class="form-control form-control-sm compact-input" id="dateOfBirth" name="dateOfBirth" required>
              </div>
            </div>
          </div>

          <div class="d-grid gap-2 mt-3">
            <button type="submit" class="btn btn-primary btn-sm"><spring:message code="label.register"/></button>
          </div>
        </form:form>

        <div class="text-center mt-2 small">
          <a href="/login" class="text-decoration-none"><spring:message code="label.login.redirect"/></a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
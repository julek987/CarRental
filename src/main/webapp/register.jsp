<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="label.register"/></title>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://www.google.com/recaptcha/api.js"></script>
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
    .text-danger {
      font-size: 0.875em;
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

        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>

        <form:form method="post" action="/register" modelAttribute="appUser">
          <div class="row g-2">
            <div class="col-6">
              <div class="form-group">
                <label for="firstName" class="form-label small"><spring:message code="label.firstName"/></label>
                <form:input path="firstName" class="form-control form-control-sm" id="firstName" required="true"/>
                <form:errors path="firstName" cssClass="text-danger"/>
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label for="lastName" class="form-label small"><spring:message code="label.lastName"/></label>
                <form:input path="lastName" class="form-control form-control-sm" id="lastName" required="true"/>
                <form:errors path="lastName" cssClass="text-danger"/>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="login" class="form-label small"><spring:message code="label.username"/></label>
            <form:input path="login" class="form-control form-control-sm" id="login" required="true"/>
            <form:errors path="login" cssClass="text-danger"/>
          </div>

          <div class="form-group">
            <label for="password" class="form-label small"><spring:message code="label.password"/></label>
            <form:password path="password" class="form-control form-control-sm" id="password" required="true"/>
            <form:errors path="password" cssClass="text-danger"/>
          </div>

          <div class="form-group">
            <label for="email" class="form-label small"><spring:message code="label.email"/></label>
            <form:input path="email" type="email" class="form-control form-control-sm" id="email" required="true"/>
            <form:errors path="email" cssClass="text-danger"/>
          </div>

          <div class="row g-2">
            <div class="col-6">
              <div class="form-group">
                <label for="telephone" class="form-label small"><spring:message code="label.telephone"/></label>
                <form:input path="telephone" type="tel" class="form-control form-control-sm" id="telephone"/>
                <form:errors path="telephone" cssClass="text-danger"/>
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label for="dateOfBirth" class="form-label small"><spring:message code="label.birthDate"/></label>
                <form:input path="dateOfBirth" type="date" class="form-control form-control-sm" id="dateOfBirth" required="true"/>
                <form:errors path="dateOfBirth" cssClass="text-danger"/>
              </div>
            </div>
          </div>

          <div class="form-group mt-3">
            <div class="g-recaptcha" data-sitekey="6Lf3PhUrAAAAAMz4ph3f31CMLscueFFcj1oOrzp1"></div>
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

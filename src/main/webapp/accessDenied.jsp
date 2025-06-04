<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="access.denied.title" text="Access Denied"/></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .lang-switcher {
      position: absolute;
      top: 20px;
      right: 20px;
    }
    .card {
      padding: 2rem;
      max-width: 400px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="lang-switcher">
  <a href="?lang=pl" class="btn btn-sm btn-outline-secondary me-1">PL</a>
  <a href="?lang=en" class="btn btn-sm btn-outline-secondary">EN</a>
</div>
<div class="card shadow">
  <h2 class="text-danger mb-3"><spring:message code="access.denied.heading" text="Access Denied"/></h2>
  <p class="mb-4"><spring:message code="access.denied.message" text="You do not have permission to access this page."/></p>
  <a href="/login" class="btn btn-primary"><spring:message code="access.denied.login" text="Return to Login"/></a>
</div>
</body>
</html>

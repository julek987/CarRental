<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><spring:message code="label.welcome"/></title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.6;
    }
    .header {
      margin-bottom: 30px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
    }
    .welcome-container {
      max-width: 600px;
      margin: 0 auto;
      text-align: center;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 5px;
      background-color: #f9f9f9;
    }
    .btn {
      display: inline-block;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      text-decoration: none;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      margin-top: 20px;
    }
    .btn:hover {
      background-color: #45a049;
    }
    .lang-switcher {
      float: right;
    }
    .lang-switcher a {
      text-decoration: none;
      color: #333;
      padding: 2px 5px;
    }
    .lang-switcher a:hover {
      color: #4CAF50;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="lang-switcher">
    <a href="?lang=pl">PL</a> |
    <a href="?lang=en">EN</a>
  </div>
</div>

<div class="welcome-container">
  <h2><spring:message code="label.welcome"/></h2>

  <form action="admin/users" method="get">
    <button type="submit" class="btn">Manage Users (Admin Panel)</button>
  </form>
</div>
</body>
</html>
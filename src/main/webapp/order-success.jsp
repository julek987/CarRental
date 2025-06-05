<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Order Confirmation</title>
</head>
<body>
<h1>Order Successful!</h1>
<p>Your car rental has been confirmed.</p>

<c:if test="${not empty order}">
  <h2>Order Details</h2>
  <p>Car: ${order.car.brand} ${order.car.model}</p>
  <p>Dates: <fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
    to <fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/></p>
  <p>Total Price: $<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></p>
</c:if>

<a href="/cars">Back to available cars</a>
</body>
</html>
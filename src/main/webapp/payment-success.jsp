<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Payment Successful</title>
</head>
<body>
<h1>Payment Successful!</h1>
<p>Your order has been confirmed and payment processed.</p>

<c:if test="${not empty order}">
    <h2>Order Details</h2>
    <p>Car: ${order.car.brand} ${order.car.model}</p>
    <p>Dates: <fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
        to <fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/></p>
    <p>Total Price: $<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></p>
    <p>A confirmation email with your rental details has been sent to ${order.user.email}.</p>
</c:if>

<a href="/cars">Back to available cars</a>
</body>
</html>
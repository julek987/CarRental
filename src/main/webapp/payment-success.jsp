<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Payment Successful</title>
</head>
<body>
<h1>Payment Successful!</h1>
<p>Your order has been confirmed and payment processed.</p>

<h2>Order Details</h2>
<p>Car: ${order.car.brand} ${order.car.model}</p>
<p>Dates: ${order.startDate} to ${order.endDate}</p>
<p>Total Price: $<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></p>
<p>Payment Method: ${order.paymentMethod}</p>

<a href="/cars">Back to available cars</a>
</body>
</html>
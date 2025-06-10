<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Payment Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .success-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            background-color: white;
        }
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 1rem;
        }
        .order-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }
    </style>
</head>
<body class="bg-light">
<div class="container">
    <div class="success-container text-center">
        <div class="success-icon">✓</div>
        <h1 class="mb-3">Payment Successful!</h1>
        <p class="lead">Your order has been confirmed and payment processed.</p>

        <c:if test="${not empty order}">
            <div class="order-details text-start">
                <h2 class="mb-3">Order Details</h2>
                <div class="row mb-2">
                    <div class="col-md-6">
                        <p><strong>Car:</strong> ${order.car.brand} ${order.car.model}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Dates:</strong> <fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
                            to <fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/></p>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-6">
                        <p><strong>Total Price:</strong> $<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></p>
                    </div>
                </div>
                <p class="mt-3">A confirmation email with your rental details has been sent to ${order.user.email}.</p>
            </div>
        </c:if>

        <a href="/cars" class="btn btn-primary btn-lg mt-3">Back to available cars</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
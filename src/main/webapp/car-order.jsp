<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Rent ${car.brand} ${car.model}</title>
  <style>
    .car-details { display: flex; gap: 20px; }
    .car-img { width: 300px; height: 200px; background: #eee; display: flex; align-items: center; justify-content: center; }
    .reservation-form { margin-top: 20px; }
    .form-group { margin-bottom: 15px; }
    label { display: block; margin-bottom: 5px; }
    select, input[type="date"] { width: 200px; padding: 8px; }
    .car-img img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<h1>Rent ${car.brand} ${car.model}</h1>

<div class="car-details">
  <div class="car-img">
    <c:choose>
      <c:when test="${not empty car.imageUrl}">
        <img src="${car.imageUrl}" alt="${car.brand} + ${car.model}"/></a>
      </c:when>
      <c:otherwise>
        <span>No image</span>
      </c:otherwise>
    </c:choose>
  </div>
  <div>
    <p><strong>Year:</strong> ${car.year}</p>
    <p><strong>License Plate:</strong> ${car.licensePlate}</p>
    <p><strong>Color:</strong> ${car.color}</p>
    <p><strong>Daily Rate:</strong> $<fmt:formatNumber value="${car.dailyCost}" pattern="#,##0.00"/></p>
  </div>
</div>

<div class="reservation-form">
  <h2>Reservation Details</h2>
  <form action="${pageContext.request.contextPath}/orders" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="carId" value="${car.id}">

    <div class="form-group">
      <label>Start Date:
        <input type="date" name="startDate" min="${today}" max="${maxDate}" required>
      </label>
    </div>

    <div class="form-group">
      <label>End Date:
        <input type="date" name="endDate" min="${today}" max="${maxDate}" required>
      </label>
    </div>

    <div class="form-group">
      <label>Pickup Location:
        <select name="pickupLocationId" required>
          <c:forEach items="${locations}" var="location">
            <option value="${location.id}">${location.city}, ${location.address}</option>
          </c:forEach>
        </select>
      </label>
    </div>

    <div class="form-group">
      <label>Return Location:
        <select name="returnLocationId" required>
          <c:forEach items="${locations}" var="location">
            <option value="${location.id}">${location.city}, ${location.address}</option>
          </c:forEach>
        </select>
      </label>
    </div>

    <button type="submit">Confirm Reservation</button>
  </form>
</div>
</body>
</html>
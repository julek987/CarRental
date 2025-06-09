<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Rent ${car.brand} ${car.model} | CarRental.com</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <style>
    body {
      overflow-y: auto;
    }
    .container {
      max-width: 1200px;
      padding: 5px;
    }
    .car-img-container {
      height: 200px;
      background: #f8f9fa;
      border-radius: 8px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .car-img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }
    .availability-calendar {
      margin-top: 5px;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    .calendar-header {
      background-color: #007bff;
      color: white;
      padding: 8px;
      text-align: center;
    }
    .calendar-grid {
      display: grid;
      grid-template-columns: repeat(7, 1fr);
      gap: 1px;
      background-color: #dee2e6;
    }
    .calendar-day-header {
      background-color: #f8f9fa;
      padding: 8px;
      text-align: center;
      font-weight: bold;
      font-size: 0.9rem;
    }
    .calendar-day {
      background-color: white;
      padding: 5px;
      min-height: 40px;
      position: relative;
      font-size: 0.9rem;
    }
    .day-number {
      font-weight: bold;
      margin-bottom: 2px;
    }
    .available {
      background-color: #d4edda;
    }
    .unavailable {
      background-color: #f8d7da;
      color: #721c24;
    }
    .today {
      border: 2px solid #007bff;
    }
    .reservation-form {
      background-color: #f8f9fa;
      padding: 5px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }
    .price-highlight {
      font-size: 1.3rem;
      color: #007bff;
      font-weight: bold;
    }
    .feature-icon {
      font-size: 1rem;
      color: #007bff;
      margin-right: 5px;
    }
    .other-month {
      background-color: #f8f9fa;
      color: #adb5bd;
    }
    .selected-start, .selected-end {
      background-color: #007bff !important;
      color: white;
      font-weight: bold;
    }
    .selected-range {
      background-color: #b3d7ff !important;
    }
    .calendar-day {
      cursor: pointer;
      transition: all 0.2s;
      text-decoration: none;
      color: inherit;
    }
    .calendar-day:hover:not(.unavailable) {
      transform: scale(1.03);
      box-shadow: 0 0 3px rgba(0,0,0,0.2);
    }
    .calendar-day.unavailable {
      cursor: not-allowed;
    }
    .form-row {
      margin-bottom: 10px;
    }
    h1 {
      font-size: 1.8rem;
    }
    h3 {
      font-size: 1.4rem;
    }
    h4 {
      font-size: 1.2rem;
    }
    .total-price {
      font-size: 1.2rem;
      font-weight: bold;
      color: #28a745;
      margin-top: 10px;
      padding: 8px;
      background-color: #f8f9fa;
      border-radius: 4px;
      text-align: center;
    }
    .invalid-range {
      color: #dc3545;
      font-size: 0.9rem;
      margin-top: 5px;
    }
  </style>
</head>
<body>
<div class="container py-2">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-primary btn-sm">
      <i class="bi bi-arrow-left"></i> Back to Cars
    </a>
    <div style="width: 100px;"></div>
  </div>

  <div class="row g-3">
    <!-- Car Details -->
    <div class="col-md-5">
      <div class="car-img-container mb-3">
        <c:choose>
          <c:when test="${not empty car.imageUrl}">
            <img src="${car.imageUrl}" alt="${car.brand} ${car.model}" class="car-img">
          </c:when>
          <c:otherwise>
            <div class="text-muted">No image available</div>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="card mb-3">
        <div class="card-body p-3">
          <h3 class="card-title">${car.brand} ${car.model}</h3>
          <div class="d-flex justify-content-between align-items-center mb-2">
            <span class="price-highlight">$<fmt:formatNumber value="${car.dailyCost}" pattern="#,##0.00"/>/day</span>
            <span class="badge bg-primary">${car.year}</span>
          </div>
          <hr class="my-2">
          <div class="row">
            <div class="col-6">
              <p class="mb-1"><i class="bi bi-palette feature-icon"></i> <strong>Color:</strong> ${car.color}</p>
            </div>
            <div class="col-6">
              <p class="mb-1"><i class="bi bi-upc-scan feature-icon"></i> <strong>License:</strong> ${car.licensePlate}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Reservation Form & Calendar -->
    <div class="col-md-7">
      <div class="availability-calendar mb-3">
        <div class="calendar-header d-flex justify-content-between align-items-center p-2">
          <a href="?id=${car.id}&monthOffset=${monthOffset - 1}"
             class="btn btn-sm btn-light ${monthOffset <= 0 ? 'disabled' : ''}">
            <i class="bi bi-chevron-left"></i>
          </a>
          <h4 class="mb-0">
            <c:choose>
              <c:when test="${currentMonth.getMonthValue() == 1}">January</c:when>
              <c:when test="${currentMonth.getMonthValue() == 2}">February</c:when>
              <c:when test="${currentMonth.getMonthValue() == 3}">March</c:when>
              <c:when test="${currentMonth.getMonthValue() == 4}">April</c:when>
              <c:when test="${currentMonth.getMonthValue() == 5}">May</c:when>
              <c:when test="${currentMonth.getMonthValue() == 6}">June</c:when>
              <c:when test="${currentMonth.getMonthValue() == 7}">July</c:when>
              <c:when test="${currentMonth.getMonthValue() == 8}">August</c:when>
              <c:when test="${currentMonth.getMonthValue() == 9}">September</c:when>
              <c:when test="${currentMonth.getMonthValue() == 10}">October</c:when>
              <c:when test="${currentMonth.getMonthValue() == 11}">November</c:when>
              <c:when test="${currentMonth.getMonthValue() == 12}">December</c:when>
            </c:choose>
            ${currentMonth.getYear()}
          </h4>
          <a href="?id=${car.id}&monthOffset=${monthOffset + 1}"
             class="btn btn-sm btn-light ${monthOffset >= 2 ? 'disabled' : ''}">
            <i class="bi bi-chevron-right"></i>
          </a>
        </div>

        <div class="calendar-grid">
          <c:forEach items="${['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']}" var="day">
            <div class="calendar-day-header">${day}</div>
          </c:forEach>

          <c:forEach items="${calendarDays}" var="dayInfo">
            <c:choose>
              <c:when test="${dayInfo.available}">
                <a href="?id=${car.id}&monthOffset=${monthOffset}<c:if test="${not empty selectedStartDate}">&startDate=${selectedStartDate}</c:if><c:if test="${empty selectedStartDate or not empty selectedEndDate}">&startDate=${dayInfo.date}</c:if><c:if test="${not empty selectedStartDate and empty selectedEndDate}">&endDate=${dayInfo.date}</c:if>"
                   class="calendar-day available
                            ${dayInfo.today ? 'today' : ''}
                            ${not dayInfo.currentMonth ? 'other-month' : ''}
                            ${not empty selectedStartDate and dayInfo.date.equals(selectedStartDate) ? 'selected-start' : ''}
                            ${not empty selectedEndDate and dayInfo.date.equals(selectedEndDate) ? 'selected-end' : ''}
                            ${not empty selectedStartDate and not empty selectedEndDate
                              and dayInfo.date.isAfter(selectedStartDate)
                              and dayInfo.date.isBefore(selectedEndDate) ? 'selected-range' : ''}">
                  <div class="day-number">${dayInfo.dayOfMonth}</div>
                </a>
              </c:when>
              <c:otherwise>
                <div class="calendar-day unavailable
                            ${dayInfo.today ? 'today' : ''}
                            ${not dayInfo.currentMonth ? 'other-month' : ''}">
                  <div class="day-number">${dayInfo.dayOfMonth}</div>
                  <c:if test="${not dayInfo.available and dayInfo.currentMonth}">
                    <small class="text-muted">Booked</small>
                  </c:if>
                </div>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </div>
      </div>

      <div class="reservation-form">
        <h3 class="mb-3">Reservation Details</h3>
        <form action="${pageContext.request.contextPath}/orders" method="post">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <input type="hidden" name="carId" value="${car.id}">

          <div class="row g-2">
            <div class="col-md-6">
              <label for="startDate" class="form-label">Pickup Date</label>
              <input type="date" class="form-control form-control-sm" id="startDate" name="startDate"
                     value="${not empty selectedStartDate ? selectedStartDate : today}"
                     min="${today}" max="${maxDate}" required>
            </div>

            <div class="col-md-6">
              <label for="endDate" class="form-label">Return Date</label>
              <input type="date" class="form-control form-control-sm" id="endDate" name="endDate"
                     value="${not empty selectedEndDate ? selectedEndDate : today.plusDays(1)}"
                     min="${not empty selectedStartDate ? selectedStartDate.plusDays(1) : today.plusDays(1)}"
                     max="${maxDate}" required>
            </div>

            <div class="col-md-6">
              <label for="pickupLocationId" class="form-label">Pickup Location</label>
              <select class="form-select form-select-sm" id="pickupLocationId" name="pickupLocationId" required>
                <c:forEach items="${locations}" var="location">
                  <option value="${location.id}">${location.city}, ${location.address}</option>
                </c:forEach>
              </select>
            </div>

            <div class="col-md-6">
              <label for="returnLocationId" class="form-label">Return Location</label>
              <select class="form-select form-select-sm" id="returnLocationId" name="returnLocationId" required>
                <c:forEach items="${locations}" var="location">
                  <option value="${location.id}">${location.city}, ${location.address}</option>
                </c:forEach>
              </select>
            </div>

            <!-- Total Price Calculation -->
            <c:if test="${not empty selectedStartDate and not empty selectedEndDate}">
              <c:set var="daysBetween" value="${java.time.temporal.ChronoUnit.DAYS.between(selectedStartDate, selectedEndDate)}" />
              <c:set var="totalPrice" value="${daysBetween * car.dailyCost}" />
              <div class="col-12 total-price">
                Total for ${daysBetween} day(s): $<fmt:formatNumber value="${totalPrice}" pattern="#,##0.00"/>
              </div>

              <!-- Check for unavailable days in range -->
              <c:set var="hasUnavailableDays" value="false" />
              <c:forEach items="${calendarDays}" var="dayInfo">
                <c:if test="${dayInfo.date.isAfter(selectedStartDate.minusDays(1)) and dayInfo.date.isBefore(selectedEndDate.plusDays(1)) and not dayInfo.available}">
                  <c:set var="hasUnavailableDays" value="true" />
                </c:if>
              </c:forEach>

              <c:if test="${hasUnavailableDays}">
                <div class="col-12 invalid-range">
                  <i class="bi bi-exclamation-triangle"></i> Your selected range includes unavailable days. Please adjust your dates.
                </div>
              </c:if>
            </c:if>

            <div class="col-12 mt-3">
              <button type="submit" class="btn btn-primary btn-sm w-100"
                      <c:if test="${hasUnavailableDays}">disabled</c:if>>
                <i class="bi bi-check-circle"></i> Confirm Reservation
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
  // Get all booked dates from the calendar
  const bookedDates = [];
  <c:forEach items="${calendarDays}" var="dayInfo">
  <c:if test="${not dayInfo.available}">
  bookedDates.push("${dayInfo.date}");
  </c:if>
  </c:forEach>

  flatpickr("#startDate", {
    minDate: "today",
    maxDate: new Date().fp_incr(90),
    onChange: function(selectedDates, dateStr) {
      const endDatePicker = document.querySelector("#endDate")._flatpickr;
      endDatePicker.set("minDate", dateStr);

      // Check if the selected range includes any unavailable dates
      checkDateRangeValidity();
    }
  });

  flatpickr("#endDate", {
    minDate: "today",
    maxDate: new Date().fp_incr(90),
    onChange: function() {
      checkDateRangeValidity();
    }
  });

  function checkDateRangeValidity() {
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;
    const submitButton = document.querySelector("form button[type='submit']");

    if (!startDate || !endDate) {
      return;
    }

    const start = new Date(startDate);
    const end = new Date(endDate);
    let hasUnavailableDays = false;

    // Check each day in the range
    for (let dt = new Date(start); dt <= end; dt.setDate(dt.getDate() + 1)) {
      const dateStr = dt.toISOString().split('T')[0];
      if (bookedDates.includes(dateStr)) {
        hasUnavailableDays = true;
        break;
      }
    }

    // Disable submit button if range is invalid
    submitButton.disabled = hasUnavailableDays;

    // Show/hide warning message
    const warningElement = document.querySelector(".invalid-range");
    if (warningElement) {
      warningElement.style.display = hasUnavailableDays ? "block" : "none";
    }
  }

  // Initialize check on page load
  document.addEventListener("DOMContentLoaded", function() {
    checkDateRangeValidity();
  });
</script>
</body>
</html>
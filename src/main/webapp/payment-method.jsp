<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Select Payment Method</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .payment-container {
      max-width: 600px;
      margin: 2rem auto;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    .payment-method-card {
      border: 1px solid #dee2e6;
      border-radius: 8px;
      padding: 1.5rem;
      margin-bottom: 1rem;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    .payment-method-card:hover {
      border-color: #0d6efd;
      background-color: #f8f9fa;
    }
    .payment-method-card.selected {
      border-color: #0d6efd;
      background-color: #e7f1ff;
    }
    .payment-details {
      margin-top: 1rem;
      padding: 1rem;
      background-color: #f8f9fa;
      border-radius: 5px;
    }
    .form-control:invalid {
      border-color: #dc3545;
    }
  </style>
</head>
<body class="bg-light">
<div class="container">
  <div class="payment-container bg-white">
    <h1 class="mb-4 text-center">Select Payment Method</h1>

    <form id="paymentForm" action="${pageContext.request.contextPath}/payments/process" method="post">
      <input type="hidden" name="orderId" value="${orderId}">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

      <div class="payment-method-card" onclick="selectPaymentMethod('BLIK')">
        <div class="form-check">
          <input class="form-check-input" type="radio" id="blik" name="paymentMethod" value="BLIK" required>
          <label class="form-check-label fw-bold" for="blik">BLIK</label>
        </div>

        <div id="blik-details" class="payment-details">
          <div class="mb-3">
            <label class="form-label">6-digit BLIK code:</label>
            <input type="text" class="form-control" name="blikCode" pattern="\d{6}" maxlength="6"
                   id="blikCode">
            <div class="invalid-feedback">Please enter a valid 6-digit BLIK code</div>
          </div>
        </div>
      </div>

      <div class="payment-method-card" onclick="selectPaymentMethod('CREDIT_CARD')">
        <div class="form-check">
          <input class="form-check-input" type="radio" id="card" name="paymentMethod" value="CREDIT_CARD">
          <label class="form-check-label fw-bold" for="card">Credit Card</label>
        </div>

        <div id="card-details" class="payment-details">
          <div class="mb-3">
            <label class="form-label">Card Number:</label>
            <input type="text" class="form-control" name="cardNumber" pattern="\d{16}" maxlength="16"
                   id="cardNumber">
            <div class="invalid-feedback">Please enter a valid 16-digit card number</div>
          </div>
          <div class="mb-3">
            <label class="form-label">Expiry Date (MM/YY):</label>
            <input type="text" class="form-control" name="expiryDate" pattern="\d{2}/\d{2}"
                   placeholder="MM/YY" id="expiryDate">
            <div class="invalid-feedback">Please enter a valid expiry date (MM/YY)</div>
          </div>
          <div class="mb-3">
            <label class="form-label">CVV:</label>
            <input type="text" class="form-control" name="cvv" pattern="\d{3}" maxlength="3"
                   id="cvv">
            <div class="invalid-feedback">Please enter a valid 3-digit CVV</div>
          </div>
        </div>
      </div>

      <div class="d-grid mt-4">
        <button type="submit" class="btn btn-primary btn-lg">Confirm Payment</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function selectPaymentMethod(method) {
    // Update radio button selection
    document.getElementById(method === 'BLIK' ? 'blik' : 'card').checked = true;

    // Show/hide payment details
    document.getElementById('blik-details').style.display = method === 'BLIK' ? 'block' : 'none';
    document.getElementById('card-details').style.display = method === 'CREDIT_CARD' ? 'block' : 'none';

    // Update card styling
    const blikCard = document.querySelector('#blik').closest('.payment-method-card');
    const cardCard = document.querySelector('#card').closest('.payment-method-card');

    if (method === 'BLIK') {
      blikCard.classList.add('selected');
      cardCard.classList.remove('selected');
    } else {
      cardCard.classList.add('selected');
      blikCard.classList.remove('selected');
    }
  }


  // Form validation
  document.getElementById('paymentForm').addEventListener('submit', function(event) {
    if (!this.checkValidity()) {
      event.preventDefault();
      event.stopPropagation();
    }
    this.classList.add('was-validated');
  }, false);
</script>
</body>
</html>
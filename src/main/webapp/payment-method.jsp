<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Select Payment Method</title>
  <style>
    .payment-method { margin-bottom: 20px; }
    .payment-details { display: none; margin-left: 20px; }
  </style>
  <script>
    function showPaymentDetails(method) {
      document.getElementById('blik-details').style.display =
              method === 'BLIK' ? 'block' : 'none';
      document.getElementById('card-details').style.display =
              method === 'CREDIT_CARD' ? 'block' : 'none';
    }
  </script>
</head>
<body>
<h1>Select Payment Method</h1>

<form action="${pageContext.request.contextPath}/payments/process" method="post">
  <input type="hidden" name="orderId" value="${orderId}">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

  <div class="payment-method">
    <input type="radio" id="blik" name="paymentMethod" value="BLIK"
           onclick="showPaymentDetails('BLIK')" required>
    <label for="blik">BLIK</label>

    <div id="blik-details" class="payment-details">
      <label>6-digit BLIK code:
        <input type="text" name="blikCode" pattern="\d{6}" maxlength="6">
      </label>
    </div>
  </div>

  <div class="payment-method">
    <input type="radio" id="card" name="paymentMethod" value="CREDIT_CARD"
           onclick="showPaymentDetails('CREDIT_CARD')">
    <label for="card">Credit Card</label>

    <div id="card-details" class="payment-details">
      <label>Card Number:
        <input type="text" name="cardNumber" pattern="\d{16}" maxlength="16">
      </label><br>
      <label>Expiry Date (MM/YY):
        <input type="text" name="expiryDate" pattern="\d{2}/\d{2}" placeholder="MM/YY">
      </label><br>
      <label>CVV:
        <input type="text" name="cvv" pattern="\d{3}" maxlength="3">
      </label>
    </div>
  </div>

  <button type="submit">Confirm Payment</button>
</form>
</body>
</html>
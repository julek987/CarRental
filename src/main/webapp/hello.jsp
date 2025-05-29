<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title><spring:message code="label.welcome"/></title>
  </head>
  <body>
  <h3><spring:message code="label.welcome"/></h3>
  </body>

  <div class="header">
    <span style="float: right">
    	<a style="background-color: white" href="?lang=pl">pl</a> | <a style="background-color: white" href="?lang=en">en</a>
	</span>
  </div>

</html>

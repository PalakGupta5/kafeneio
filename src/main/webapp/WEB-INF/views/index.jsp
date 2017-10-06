<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html  class="js">
<head>
<title><spring:message code="kafeneio.main.title"/></title>

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 -->
 <link rel="stylesheet" href="static/css/font-awesome.min-4.7.0.css"></link>
 
<link rel="stylesheet" href="static/css/bootstrap.css"></link>
<link href="static/css/app.css" rel="stylesheet"></link>
<link href="static/css/theme.css" media="all" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="static/css/free-jqgrid/4.14.1/ui.jqgrid.min.css">
<link href = "static/css/ui/1.10.4/jquery-ui.css" rel = "stylesheet">
<link href="static/css/pnotify.custom.css" rel="stylesheet"></link>
<link rel="stylesheet" href="static/css/kafeneio.css"></link>

<script src="static/js/app.js" /></script>
<script src="static/JSlib/jquery/1.12.4/jquery.min.js"></script>
<script src="static/JSlib/twitter-bootstrap/3.3.7/bootstrap.min.js"></script>
<script src="static/JSlib/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
<script src="static/JSlib/jQuery.print.js"></script>
<script src="static/JSlib/pnotify.custom.js" /></script>
<script  src="static/JSlib/home.js"></script>
</head>
<body>
<div class="container">
		<%@include file="menu.jsp"%>
</div>
<sec:authorize access="hasRole('ADMIN')">
	<div class="container" style="display:flex">
		<div class="row" style="margin: 15px">
			<table id="newOrdersGrid"></table>
		</div>

		<div class="row" style="margin: 15px">
			<table id="servedOrdersGrid"></table>
			 <div id="servedOrdersPager" style="height: 50;"></div>
		</div>

		<div class="row" style="margin: 15px">
			<table id="cancelledOrdersGrid"></table>
		</div>
	</div>	
</sec:authorize>
<div class="container">
		<%@include file="footer.jsp"%>
</div>
</body>
</html>
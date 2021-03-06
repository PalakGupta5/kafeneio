<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html  class="js">
<head>
<title><spring:message code="kafeneio.main.title"/></title>
<link rel="stylesheet" href="static/css/bootstrap.css"></link>
<link rel="stylesheet" href="static/css/font-awesome.min-4.7.0.css"></link>
<link href="static/css/app.css" rel="stylesheet"></link>
<link href="static/css/theme.css" media="all" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="static/css/free-jqgrid/4.14.1/ui.jqgrid.min.css">
<link href = "static/css/bootstrap-datetimepicker-4.17.37.min.css" rel = "stylesheet">
<link href = "static/css/ui/1.10.4/jquery-ui.css" rel = "stylesheet">
<link href="static/css/pnotify.custom.css" rel="stylesheet"></link>
<link rel="stylesheet" href="static/css/kafeneio.css"></link>

<script src="static/js/app.js" /></script>
<script src="static/JSlib/jquery/1.12.4/jquery.min.js"></script>
<script src="static/JSlib/jquery.validate.js"></script>
<script src="static/JSlib/twitter-bootstrap/3.3.7/bootstrap.min.js"></script>
<script src="static/JSlib/moment-2.10.6.min.js"></script> 
<script src="static/JSlib/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
<script src="static/JSlib/bootstrap-datetimepicker-4.17.37.min.js"></script>
<script src="static/JSlib/jQuery.print.js"></script>
<script src="static/JSlib/pnotify.custom.js" /></script>
<script  src="static/JSlib/kafeneioHome.js"></script>
</head>
<body>
<form action="" name="menu" id = "menu">
<input type="hidden" name="currentDateTime" id="currentDateTime" value="${currentDateTime}"/> 
<input type="hidden" name="dateTimeFormatCalendar" id="dateTimeFormatCalendar" value="${dateTimeFormatCalendar}"/> 
<input type="hidden" name="orderNumber" id="orderNumber" value=""/> 

	<div class="container">
				<%@include file = "menu.jsp" %>
		</div>
		<div class="container" id="menuChildDiv">
		<div class="row">
		<div class="col-lg-8">
					<div class="row" style="margin-left: 10">
						<div class="top-navbar header b-b">
							<button class=" navbar navbar-toggle" data-toggle="collapse"
								data-target=".navheadercollapse">
								<span class=" icon-bar"></span> <span class=" icon-bar"></span>
								<span class=" icon-bar"></span>
							</button>
							<div>
							<input type = "hidden" id = "wholeMenu" value= "${foodCategoryList}"/>
							
								<ul class=" nav navbar-nav">
									<c:forEach items="${foodCategoryList}" var="category">
   									    <li><a href="#" onclick="getItems('${category.foodCode}');">${category.foodDesc}</a></li> 
   									</c:forEach>
									<!-- <li><a href="#" onclick="getItems('KC');">Kafeneio Coolers</a></li>
									<li><a href="#" onclick="getItems('BUR');">Burgers</a></li>
									<li><a href="#" onclick="getItems('SM');">Sandwich Mania</a></li>
									<li><a href="#" onclick="getItems('WR');">Wraps & Rolls</a></li>
									<li><a href="#" onclick="getItems('PST');">Pasta</a></li>
									<li><a href="#" onclick="getItems('CHI');">Chinese</a></li>
									<li><a href="#" onclick="getItems('ATF');">All Time Favourite</a></li>
									<li><a href="#" onclick="getItems('KOC');">Kafeneio Special</a></li>
									<li><a href="#" onclick="getItems('PL');">Protein Loaders</a></li>
									<li><a href="#" onclick="getItems('CL');">Carb Loaders</a></li>
									<li><a href="#" onclick="getItems('AO');">Ad Ons</a></li> -->
								</ul>
							</div>
						</div>
					</div>
					  <div class="row" style="margin-left: 5" id="itemsRow"></div>
				</div>
				<div class="col-lg-4">
							<div class='input-group date' id='datetimepicker' style="width: 253px;text-align: center;">
								<input type='text' class="form-control" id="orderDateTime" required/> <span
									class="input-group-addon"><span onclick="reloadGrid();"
									class="glyphicon glyphicon-calendar"></span> </span>
							</div>
				<div id="printGrid" style="width: 253px;text-align: center;">
					<h5>
						<b>The Kafeneio</b>
					</h5>
					<!-- <h5>
						GST: 12345678
					</h5> -->
					<br>
					<span style="text-align: left">Customer Copy <b><i>(07BTQPG0862G1ZL)</i></b></span>
					<table id="invoiceGrid"></table>
					 <!-- <h5> <span class="glyphicon glyphicon-telephone"> 011-49148538, 8218349619 </span></h5> -->
					 <h5><span>Contact:011-49148538, 8218349619</span></h5>
					<h5>D-1 Cent. Mkt Surajmal Vihar 110092</h5>
					<!-- <h4>Happy Dushehra!</h4> -->
					
				</div>
				
					<br>
						<div style="text-align: left;">
							<button class="btn btn-default" type="button" onclick="generateBill();">Print</button>
							<button class="btn btn-default" type="button" onclick="reloadGrid()">Clear</button>
							<button class="btn btn-default" type="button" onclick="discount()">Discount</button>
					</div>
				</div>
			</div>
			
			
		
		
		<%@include file = "footer.jsp" %>		 	
	</div>	

<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="modeOfPaymentModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" id="closeButton">&times;</button>
          <h4 class="modal-title">Mode Of Payment</h4>
        </div>
        <div class="modal-body">
        <fieldset>
        
							 <div class="form-group">			
 								<div class="col-md-6">
								<label for="prepended-input" class="control-label">Mode Of Payment</label>
								<select path="id" class="form-control" id="modeOfPayment" required="required">
								</select>
							</div>
 								
							</div>
						</fieldset>
		 
		 		 
		  
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default"  id= "okMOPButton" onclick="saveOrderWithModeOfPayment()">Ok</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="payOnServeButton" onclick = "saveOrder(null)">Pay on serve</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>


<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="discountModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" id="closeButton">&times;</button>
          <h4 class="modal-title">Discount</h4>
        </div>
        <div class="modal-body">
        <fieldset>

							<div class="col-md-6">
								<label for="normal-field" class="control-label">Discount %</label> <input type="text" name="discountPercentage"
									placeholder="" class="form-control" id="discountPercentage">
									<label id="discountPercentage-error" style="color:red" for="discountPercentage"></label>
							</div>

						</fieldset>
		 
		 		 
		  
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default"  id= "okDiscountButton" onclick="">Ok</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"  id= "cancelDiscountButton" onclick="">Cancel</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>


</form>
</body>
</html>
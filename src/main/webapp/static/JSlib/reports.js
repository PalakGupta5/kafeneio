$(document).ready(function(){
	
  /*myData = [
      {orderNo: "123", amount: "111", creationDate: "2014-07-27"},
      {orderNo: "123", amount: "111", creationDate: "2014-07-21"},
      {orderNo: "123", amount: "111", creationDate: "2014-07-29"},
  ];

  $("#application-list").jqGrid({
  url :  $("#contextPath").val()+"/orderList?fromDate=12-12-2015&&toDate=12-12-2017",
  datatype: "json",
  mtype : 'POST',
  colNames: ['Order No', 'Amount', 'Date'],
  colModel: [
      { name: 'orderNo', width: 50, align: 'center' },
      { name: 'amount', width: 50, align: 'center' },
      { name: 'creationDate', width: 50, align: 'center', sorttype: 'date' },
  ],
  rowNum: 3,
  rowList: [3, 10, 20],
  pager: '#application-list-pager',
  gridview: true,
  rownumbers: false,
  guiStyle: "bootstrap",
  autoencode: true,
  iconSet: "fontAwesome",
  ignoreCase: true,
  sortname: 'orderNo',
  viewrecords: true,
  sortorder: 'desc',
  autowidth: true,
  height: 'auto',
  caption: 'Order Detail Report',
});*/

  $(window).on("resize", function () {
	  var newWidth = $("#orderReportGrid").closest(".ui-jqgrid").parent().width();
	  $("#orderReportGrid").jqGrid("setGridWidth", newWidth, true);

//	  var newWidth = $("#application-list").closest(".ui-jqgrid").parent().width();
//	  $("#application-list").jqGrid("setGridWidth", newWidth, true);
});
  
});

$( document ).ready(function() {
    $('#fromDateTimePicker').datetimepicker({
    	 format: 'DD-MM-YYYY'
    });
    $('#toDateTimePicker').datetimepicker({
   	 	format: 'DD-MM-YYYY'
   });
  
});


function searchOrders(){
	var fromDate = $("#fromDateTimePicker").find("input").val();
	var toDate = $("#toDateTimePicker").find("input").val();

	$("#orderReportGrid").jqGrid({
		url :  $("#contextPath").val()+"/orderList?fromDate=12-12-2015&&toDate=12-12-2017",
		datatype : "json",
		mtype : 'POST',
		colModel: [
			{ name: "id", label: "id",hidden:true},
			{ name: "orderNo", label: "Order No",  align: "center"},
			{ name: "amount", label: "Amount",  align: "right",template: "number"},
			{ name: "creationDate", label: "Date",  align: "center" },
			],
			 footerrow: true,
		     userDataOnFooter : true,
			rowNum:10,
			rowList:[10,20,30],
			guiStyle: "bootstrap",
			iconSet: "fontAwesome",
			pager: '#pager',
			sortname: 'orderNo',
			viewrecords: true,
			sortorder: "desc",
			autowidth: true,
			loadonce: true,
			caption: "Order Detail Report",
			/* loadComplete:function() {
				 adjustTotal();
			    }*/
	});
	$("#orderReportGrid").bind("jqGridAfterLoadComplete", function() {
		 adjustTotal();
	});
	
}

function adjustTotal(){
	var data = $("#orderReportGrid").jqGrid("getGridParam", "data");
	var amount = 0;
	for (var i in data) {
		var row = data[i];
		amount=parseInt(amount)+parseInt(row.amount);
		
	}	
//	alert(amount);
	jQuery("#orderReportGrid").footerData('set',{orderNo:'Total', amount:amount});	
}


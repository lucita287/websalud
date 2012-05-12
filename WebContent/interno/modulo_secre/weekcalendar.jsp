<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<div style="float:right">

</div>
<div id="dialog-form" title="Citas">
			</div>
<div id="message" class="ui-corner-all"></div> 

<div style="clear: both;"></div>
<div id='calendar'></div>
<style>
.ui-dialog-titlebar-close{
    display: none;
}
</style>
<script>

 
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var day = new Date().getDate();

	
	$(function() {
		$( "#datepicker" ).datepicker();		
		$( "#datepicker" ).datepicker( "option", "dateFormat", "mm/dd/yy");
	
			$( "#dialog-form" ).dialog({
				
				autoOpen: false,
				height: 450,
				width: 800,
				modal: true
			});
			$( "#dialog:ui-dialog" ).dialog( "destroy" );
			
			
	  });	
	   
	$(document).ready(function() {
		
		$('#calendar').weekCalendar({
			
			// I18N
	        firstDayOfWeek: $.datepicker.regional['es'].firstDay,
	        shortDays: $.datepicker.regional['es'].dayNamesShort,
	        longDays: $.datepicker.regional['es'].dayNames,
	        shortMonths: $.datepicker.regional['es'].monthNamesShort,
	        longMonths: $.datepicker.regional['es'].monthNames,
	        dateFormat: "d F y",
	        switchDisplay: {'1 day': 1, '3 next days': 3, 'full week': 7},
	        readonly: true,
	        businessHours: { start: 7.00,end: 19.00,limitDisplay:true},
			timeslotsPerHour: 2,
			allowCalEventOverlap: true,
			overlapEventsSeparate: true,
			totalEventsWidthPercentInOneColumn : 95,
			eventClick : function(calEvent, $event) {
				cadena = [ 
				           "a=especifico_calendar",
				           "start="+calEvent.start.getTime(),
				           "end="+calEvent.end.getTime(),
				           ].join('&');
				 $( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?"+cadena);
				  $( "#dialog-form" ).dialog( "open" );
				
			    //displayMessage(calEvent.start.getTimezoneOffset()+"<strong>Clicked Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
			},
			height: function($calendar){
				return $(window).height() - $("h1").outerHeight(true);
			},
	        data: function(start, end, callback) {
	        	  
	        	
	        	 $.ajax({
	        	        url:        "../SCita?a=citas_calendar&start="+ start.getTime()+"&end="+end.getTime(),
	        	        type: 'GET',
	        	        dataType: 'json',
				  	  	success:    function(json) {
	        	        	
	        	            if ($.isArray(json)) { 
	        	                $.each(json, function(key, value) { 
	        	                	value.start = new Date(value.start.year,value.start.month,value.start.day,value.start.hour,value.start.minute); 
	        	                    value.end =new Date(value.end.year,value.end.month,value.end.day,value.end.hour,value.end.minute); 
	        	                });
	        	            }
	        	            callback(json);
	        	        }
	        	    });


	        		}	
			
		});
		  
	});
	function displayMessage(message) {
		$("#message").html(message).fadeIn();
	}
	$('#datepicker').datepicker().change(function() {
	   $('#calendar').weekCalendar("gotoWeek", new Date($('#datepicker').val()));
	});

	
</script>
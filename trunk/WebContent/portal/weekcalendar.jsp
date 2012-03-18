
<div style="float:right">
<div id="datepicker"></div>
</div>
<div id="message" class="ui-corner-all"></div> 

<div style="clear: both;"></div>
<div id='calendar'></div>
<script>

 
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var day = new Date().getDate();

	
	$(function() {
		$( "#datepicker" ).datepicker();		
		$( "#datepicker" ).datepicker( "option", "dateFormat", "mm/dd/yy");
	});

	   
	$(document).ready(function() {
		cadena = [ 'idarea=1',
		            'a=showcalendar',
		            'end=1332655200',
		            'start=1332050400'
		        ].join('&');
		$.ajax({
	        url: "SCalendario",
	        data: cadena,
	  	    type: 'post',
	  	  	dataType: 'json',
	  	  	success: function(datos){
	  	  	events=datos;;	
				
	        }});
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
			timeslotsPerHour: 3,
			allowCalEventOverlap: true,
			overlapEventsSeparate: true,
			totalEventsWidthPercentInOneColumn : 95,
			eventClick : function(calEvent, $event) {
				displayMessage(calEvent.start.getTimezoneOffset()+"<strong>Clicked Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
			},
			height: function($calendar){
				return $(window).height() - $("h1").outerHeight(true);
			},
			changedate:function($calendar,$date){
				
			},
	        //data:'portal/json_calendar.jsp?idarea=1&a=showcalendar',
	        data: function(start, end, callback) {
	        	  
	        	
	        	 $.ajax({
	        	        url:        "SCalendario?idarea=1&a=showcalendar&start="+ start.getTime()+"&end="+end.getTime(),
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
		  // $("#calendar").weekCalendar("refresh");
			//   $("#calendar").weekCalendar("refresh");
		
	});
	function displayMessage(message) {
		$("#message").html(message).fadeIn();
	}
	$('#datepicker').datepicker().change(function() {
	   $('#calendar').weekCalendar("gotoWeek", new Date($('#datepicker').val()));
	});

	
</script>
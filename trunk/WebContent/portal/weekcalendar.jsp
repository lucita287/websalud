<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%
CDataBase	data=new CDataBase();
data.Connect();
ArrayList<CArea> list=data.getAreaLista();
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}

%>
<hr />
	<% for(int j=0; j<list.size();j++){  
		CArea area=list.get(j);%>
		<div class="bt_area_calendario"><a href="calendario.jsp?idarea=<%= area.getidarea()%>" class="ui-state-default ui-corner-all button"><%= area.getnombre()%></a></div>
	<%} %>
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
				cadena = [ 
				           "idarea=<%=idarea%>",
				           "a=especifico_calendar",
				           "start="+calEvent.start.getTime(),
				           "end="+calEvent.end.getTime(),
				           ].join('&');
				$.ajax({
        	        url:        "SCalendario",
        	        data: cadena,
        	        type: 'POST',
			  	  	success:    function(json) {
			  	  	displayMessage(json);
        	        }
        	    });
				
			    //displayMessage(calEvent.start.getTimezoneOffset()+"<strong>Clicked Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
			},
			height: function($calendar){
				return $(window).height() - $("h1").outerHeight(true);
			},
	        data: function(start, end, callback) {
	        	  
	        	
	        	 $.ajax({
	        	        url:        "SCalendario?idarea=<%=idarea%>&a=showcalendar&start="+ start.getTime()+"&end="+end.getTime(),
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
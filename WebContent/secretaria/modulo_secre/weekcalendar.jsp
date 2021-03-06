<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){

%>  
 
    <style>
    #message {
		font-size: 1em;
		width: 550px;
		height: 150px;
		padding: 1em;
		background: #ffc;
		border: 1px solid #dda;
		float:left;
		overflow: auto;
	}
    
    </style>

<div id="dialog-form" title="Citas"></div>

<div style="clear: both;"></div>
<div id='calendar'></div>
<style>
.ui-dialog-titlebar-close{
    display: none;
}
.wc-time{
	font-size:60%;
}
.wc-title{
	font-size:80%;
}
</style>
<script>

 
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var day = new Date().getDate();

	
	$(function() {
		//$( "#datepicker" ).datepicker();		
		
		$( "#datepicker" ).datepicker({
			dayNamesMin: ['Dom', 'Lun', 'Mar', 'Mi&eacute;', 'Jue', 'Vie', 'S&aacute;b'],
			monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre'],
			changeMonth: true,
			changeYear: true
		});
		$( "#datepicker" ).datepicker( "option", "dateFormat", "mm/dd/yy");
	
		//$("#datepicker").datepicker({ 
		//	  dateFormat: 'mm/dd/yy', 
		//	  changeYear: true,
		//	  changeMonth: true,
		//	  dayNamesMin: ['Dom', 'Lun', 'Mar', 'Mi&eacute;', 'Jue', 'Vie', 'S&aacute;b'],
		//	  monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre']
		//	});
		
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
			timeslotsPerHour: 3,
			allowCalEventOverlap: true,
			overlapEventsSeparate: true,
			totalEventsWidthPercentInOneColumn : 95,
			eventClick : function(calEvent, $event) {
				Cita(calEvent.start.getTime(),calEvent.end.getTime());
				
			    //displayMessage(calEvent.start.getTimezoneOffset()+"<strong>Clicked Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
			},
			height: function($calendar){
				return $(window).height() - $("h1").outerHeight(true);
			},
			eventRender : function(calEvent, $event) {
		        
				$("#citas_calendario").append("<a href='#' onclick=Cita("+calEvent.start.getTime()+","+calEvent.end.getTime()+") >"+calEvent.des_dia+"</a><br/>");
				if(calEvent.cupo>=0){
						
					if(calEvent.estado==2){
						if(calEvent.tipo==1){
							$event.css('backgroundColor', '#717D7D');
					        $event.find('.time').css({'backgroundColor': '#717D7D', 'border':'1px solid #888'});
						}else{
							$event.css('backgroundColor', '#000000');
					        $event.find('.time').css({'backgroundColor': '#000000', 'border':'1px solid #888'});
						}
						
					}else if(calEvent.estado==1){
						if(calEvent.tipo==1){
							$event.css('backgroundColor', '#2554C7');
					        $event.find('.time').css({'backgroundColor': '#2554C7', 'border':'1px solid #888'});
						}else{
							$event.css('backgroundColor', '#347C17');
					        $event.find('.time').css({'backgroundColor': '#347C17', 'border':'1px solid #888'});
						}
					}else if(calEvent.estado==0){
						$event.css('backgroundColor', '#FF0000');
				        $event.find('.time').css({'backgroundColor': '#FF0000', 'border':'1px solid #888'});	
					}
					
				}else{
					if(calEvent.estado==2){
						if(calEvent.tipo==1){
							$event.css('backgroundColor', '#717D7D');
					        $event.find('.time').css({'backgroundColor': '#717D7D', 'border':'1px solid #888'});
						}else{
							$event.css('backgroundColor', '#000000');
					        $event.find('.time').css({'backgroundColor': '#000000', 'border':'1px solid #888'});
						}
						
					}else if(calEvent.estado==1){
						if(calEvent.tipo==1){
							$event.css('backgroundColor', '#6698FF');
					        $event.find('.time').css({'backgroundColor': '#6698FF', 'border':'1px solid #888'});
						}else{
							$event.css('backgroundColor', '#667C26');
					        $event.find('.time').css({'backgroundColor': '#667C26', 'border':'1px solid #888'});
						}
					}else if(calEvent.estado==0){
						$event.css('backgroundColor', '#FF0000');
				        $event.find('.time').css({'backgroundColor': '#FF0000', 'border':'1px solid #888'});	
					}
				}
				
				 
		        
		      },
	        data: function(start, end, callback) {
	        	  
	        	
	        	 $.ajax({
	        	        url:        "../SCita?a=citas_calendar&start="+ start.getTime()+"&end="+end.getTime(),
	        	        type: 'GET',
	        	        dataType: 'json',
				  	  	success:    function(json) {
	        	        	
				  	  	
				  	  	$("#citas_calendario").html("");
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
	
	$('#datepicker').datepicker().change(function() {
	   $('#calendar').weekCalendar("gotoWeek", new Date($('#datepicker').val()));
	});

	function Cita(start,end){
		cadena = [ 
		           "a=especifico_calendar",
		           "start="+start,
		           "end="+end,
		           ].join('&');
		 $( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?"+cadena);
		  $( "#dialog-form" ).dialog( "open" );
	}
</script>
<%	} %>
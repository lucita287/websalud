<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
int month=0;
String mes=request.getParameter("mes");
java.util.GregorianCalendar calendar=new java.util.GregorianCalendar();	
if(mes!=null){
	try{
		
		month=calendar.get(calendar.MONTH);
		
		//month=Integer.parseInt(request.getParameter("mes"));
	}catch(Exception e){}
}

%> 
<script>
$(document).ready(function () {
$('#tabs').tabs({ selected: <%=month%> });
$( "#tabs" ).tabs({
	ajaxOptions: {
		error: function( xhr, status, index, anchor ) {
			$( anchor.hash ).html(
				"NO SE PUEDE CARGAR LA PAGINA POR AHORA " );
		}
	}
});
});
</script>
<div id="tabs">
			<ul>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=1">Enero</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=2">Febrero</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=3">Marzo</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=4">Abril</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=5">Mayo</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=6">Junio</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=7">Julio</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=8">Agosto</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=9">Septiembre</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=10">Octubre</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=11">Noviembre</a></li>
				<li><a href="portal/calendar/mes_header.jsp?year=<%=calendar.get(calendar.YEAR)%>&month=12">Diciembre</a></li>
			</ul>
			
</div>			

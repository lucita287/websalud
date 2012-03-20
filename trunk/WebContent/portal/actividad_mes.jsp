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
});
</script>
<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Enero</a></li>
				<li><a href="#tabs-2">Febrero</a></li>
				<li><a href="#tabs-3">Marzo</a></li>
				<li><a href="#tabs-4">Abril</a></li>
				<li><a href="#tabs-5">Mayo</a></li>
				<li><a href="#tabs-6">Junio</a></li>
				<li><a href="#tabs-7">Julio</a></li>
				<li><a href="#tabs-8">Agosto</a></li>
				<li><a href="#tabs-9">Septiembre</a></li>
				<li><a href="#tabs-10">Octubre</a></li>
				<li><a href="#tabs-11">Noviembre</a></li>
				<li><a href="#tabs-12">Diciembre</a></li>
			</ul>
			<div id="tabs-1" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="1" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="1" />	
						</jsp:include>
			</div>
			<div id="tabs-2" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="2" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="2" />	
						</jsp:include>
			</div>
			<div id="tabs-3" style="width:1000px; ">
			
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="3" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="3" />	
						</jsp:include>
			
			</div>
			<div id="tabs-4" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="4" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="4" />	
						</jsp:include>
			</div>
			<div id="tabs-5" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="5" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="5" />	
						</jsp:include>
			</div>
			<div id="tabs-6" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="6" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="6" />	
						</jsp:include>
			</div>
			<div id="tabs-7" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="7" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="7" />	
						</jsp:include>
			</div>
			<div id="tabs-8" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="8" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="8" />	
						</jsp:include>
			</div>
			<div id="tabs-9" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="9" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="9" />	
						</jsp:include>
			</div>
			<div id="tabs-10" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="10" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="10" />	
						</jsp:include>
			</div>
			<div id="tabs-11" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="11" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="11" />	
						</jsp:include>
			</div>
			<div id="tabs-12" style="width:1000px; ">
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)%>" />
						   <jsp:param name="month" value="12" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=calendar.get(calendar.YEAR)+1%>" />
						   <jsp:param name="month" value="12" />	
						</jsp:include>
			</div>
</div>			

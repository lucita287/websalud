<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
int month=0;
int year=0;
	try{
		month=Integer.parseInt(request.getParameter("month"));
		year=Integer.parseInt(request.getParameter("year"));
	}catch(Exception e){}

%>

						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=year%>" />
						   <jsp:param name="month" value="<%=month%>" />	
						</jsp:include>
						<jsp:include page="mes.jsp">	
						   <jsp:param name="year" value="<%=year+1%>" />
						   <jsp:param name="month" value="<%=month%>" />	
						</jsp:include>
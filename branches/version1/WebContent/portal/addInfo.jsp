<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CConfiguracion" %>
<%
CDataBase dbo=new CDataBase();
if(dbo.Connect()){
CConfiguracion temp=dbo.getConfiguracion();
dbo.Close();
if(temp!=null){
%>
<div class="row-top">
					<div class="row-padding">
						<div id="info_configuracion">
						<%=temp.getdireccion()%> <b>TELEFONO:</b> <%=temp.gettelefono()%> <b>FAX:</b><%=temp.getfax()%>
						</div>
					</div>
							
</div>
<% }} %>
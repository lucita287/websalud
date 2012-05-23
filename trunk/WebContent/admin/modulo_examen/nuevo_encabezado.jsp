		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
    <% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
    Iterator<CTipo_Interpretacion> it=list.iterator();
    %>
 Descripcion de la condici&oacute;n: <br>
    <textarea rows="3" cols="70"></textarea>
 <select id="tipo_inter_result" name="tipo_inter_result" onchange="cambiarTipo()">
<% while(it.hasNext()){
	CTipo_Interpretacion ctipo=it.next();
	%>
  <option value="<%=ctipo.getIdtipo_interpretacion() %>"><%=ctipo.getDescripcion() %></option>
<% } %>
</select>  
	<% } %> 
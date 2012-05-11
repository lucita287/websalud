<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %> 
    <%@ page import="data.CPaciente" %>
    <%@ page import="java.util.ArrayList" %> 
    <%@ page import="java.util.Iterator" %>
      <% 
    HttpSession sessiones=request.getSession(false); 
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    	CDataExam dbo=new CDataExam();
    	if(dbo.Connect()){	
    %>	    
<h2>    RESULTADOS DE AUTOEVALUACI&Oacute;N</h2>

<% 
	ArrayList<String> lista=dbo.Resultado(pac.getIdpaciente());
	Iterator<String> it=lista.iterator();
	while(it.hasNext()){
		out.println(it.next());
%>
<%	}}} %>
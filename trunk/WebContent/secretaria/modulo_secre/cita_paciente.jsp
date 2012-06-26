<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@page import="framework.CValidation" %>
    <%@page import="data.CCita" %>
    <%@page import="data.CPaciente" %>
    <%@page import="framework.CDataExam" %>
<% 
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
	CValidation valid=new CValidation();
	CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
if(pac!=null){	
int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
CDataExam dbo=new CDataExam();
	if(dbo.Connect()){

			CCita cp1=dbo.getCita(idcita,pac.getIdpaciente());
				String img=null;
				if(cp1!=null){
					if(cp1.getEstado()==1) img="'../images/exclamation.png'";
					else if(cp1.getEstado()==2) img="'../images/off.png'";
					else if(cp1.getEstado()==0) img="'../images/close.png'";
					else if(cp1.getEstado()==3) img="'../images/on.png'";
						
				}
%>				
<%=(pac==null)?"":"<a href='index.jsp?portal=3'>Carne: "+pac.getCarne()+"</a>"%><br>
	<%=(pac==null)?"":pac.getIdpaciente()+ ")<b>"+(pac.getNombre()+" "+pac.getApellido()) %></b><br/>
	<%=(pac==null)?"":"<b>"+dbo.getUnidadAcademica(pac.getIdunidad_academica())+"</b> Celular: "+pac.getMovil() %><br/>
	<%if(img!=null) {%>CITA ACTUAL:<button onclick="Modificar(<%=pac.getIdpaciente() %>,<%= idcita %>)" > <img src=<%=img %> widht="16px" height="16px" ></button><%} %>
<% } dbo.Close(); } } %>	
	
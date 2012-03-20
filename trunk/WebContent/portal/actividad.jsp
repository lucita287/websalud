<%@page import="java.util.GregorianCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CActividad" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CResponsable" %>   
<%@ page import="data.CDetalleActividad" %>
<div id="calendario-frame">
<div class="calendario_actividad">
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CActividad> list_act=dbo.getActividad(new java.util.GregorianCalendar().getTime());



for(int i=0; i<list_act.size();i++){
	CActividad temp_act=list_act.get(i);
	%>
		
		<div  class="ui-widget-content ui-corner-all calendario_ventana">
		<h3 class="ui-widget-header"><%=temp_act.getTitulo()%></h3>
		<div class="titulo_area"><%=temp_act.getAreaidarea().getnombre().toUpperCase()%></div>
		<div style="clear: both;"></div>
		
		
		<div class="tabla">

		<div class="fila">
		<div class="col_titulo" ><%=temp_act.getDescripcion()%></div>
		</div>
		
				<div class="fila">
				<div class="col" >
				<div class="tr1">LUGAR:</div>
				<div class="tr2"> 
				<%=temp_act.getEdificioidedificio().getNombre()+", "+temp_act.getEdificioidedificio().getDireccion()%></div>
				</div>
				</div>
		
				<% if(temp_act.getSalon().compareTo("")!=0){%>
				<div class="fila">
				<div class="col" >
				<div class="tr1">SALON:</div>
				<div class="tr2"> 
				<%=temp_act.getSalon()%></div>
				</div>
				</div>
				<%}
				
		ArrayList<CResponsable> lista_respon=dbo.getListaResponsables(temp_act.getIdactividad());
		
		 if(lista_respon.size()>0){%>
				<div class="fila">
				<div class="col" >
				<div class="tr1">RESPONSABLE:</div>
				<div class="tr2"> 
				<% 	 for(int j=0; j<lista_respon.size();j++){
					 	CResponsable cr=lista_respon.get(j);
					 	out.println(cr.getNombre()+" "+cr.getApellido()+"<br/>");
				     } %>
				</div>
				</div>
		
				</div>
		<%} 
		
		 ArrayList<CDetalleActividad> lista= dbo.getDetalleActividad(temp_act.getIdactividad());
		
		%>
				<div class="fila">
				<div class="col" >
				<div class="tr1">FECHA:</div>
				<div class="tr2"> 
				<% 	 for(int j=0; j<lista.size();j++){
					 	CDetalleActividad cr=lista.get(j);
					 	out.println(cr.getFormatoFechaDes(cr.getFecha())+" "+cr.getFormatoFechahhmm(cr.getHorainicio())+"-"+cr.getFormatoFechahhmm(cr.getHorafin())+"<br/>");
				     } %>
				</div>
				</div>
		
				</div>
		</div>
		</div>
		
	<%  }%>
	
	<div style="clear: both;"></div>
</div>
</div>
<%dbo.Close(); %>
    
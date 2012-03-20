<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="data.CDetalleActividad" %>
<%
int month=0;
int year=0;

CDataBase	data=new CDataBase();
data.Connect();

	try{
		month=Integer.parseInt(request.getParameter("month"));
		year=Integer.parseInt(request.getParameter("year"));
	}catch(Exception e){}
	ArrayList<Date> list=data.getDetalleActividad(month, year);
	
	if(list.size()>0){
%>
	<div class="year_calendar"><%=year%></div>
	
	<% for(int j=0; j<list.size();j++){ 
		Date edi=list.get(j); 
		GregorianCalendar cal=new GregorianCalendar();
		cal.setTime(edi);
		ArrayList<CDetalleActividad> lista_dta=data.getDetalleActividad(edi);
		
		%>
	<div class="ui-widget-content ui-corner-all mes_calendar">
	<div class="day_calendar ui-corner-all"><%=cal.get(cal.DAY_OF_MONTH)%></div>
	
	
	<div class="tabla">
		<div class="fila">
				<div class="col_titulo" style="width:170px;">
					TITULO
				</div>
				<div class="col_titulo" style="width:260px;">
					DESCRIPCION
				</div>
				<div class="col_titulo" style="width:100px;">
					AREA
				</div>
				<div class="col_titulo" style="width:150px;">
					LUGAR
				</div>
				<div class="col_titulo" style="width:100px;">
					HORA
				</div>
		</div>
		
		<%
		for(int i=0; i<lista_dta.size();i++){ 
			CDetalleActividad deta=lista_dta.get(i); 
		%>
		<div class="fila">
			<div class="col">
				<div class="tr1" style="width:176px;">
					<%=deta.getActividadidactividad().getTitulo()%>
				</div>
				<div class="tr1" style="width:266px;">
					<%=deta.getActividadidactividad().getDescripcion()%>
				</div>
				<div class="tr1" style="width:106px;">
					<%=deta.getActividadidactividad().getAreaidarea().getnombre()%>
				</div>
				<div class="tr1" style="width:156px;">
					<%=deta.getActividadidactividad().getEdificioidedificio().getNombre()+", "+deta.getActividadidactividad().getEdificioidedificio().getDireccion()+". "+deta.getActividadidactividad().getSalon()%>
				</div>
				<div class="tr1" style="width:101px;">
					<%=deta.getFormatoFechahhmm(deta.getHorainicio())+" - "+deta.getFormatoFechahhmm(deta.getHorafin())%>
				</div>
			</div>
		</div>
		<% } %>		
	</div>
	
	
	<div style="clear: both;"></div>	
	</div>
	<% } %>
<% } data.Close(); %>	

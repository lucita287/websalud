<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CPaciente" %>
<%@ page import="data.CCentro_Regional" %>
<%@ page import="data.CUnidad_Academica" %>
<%@ page import="data.CCarrera" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<style>
	label,select,.ui-select-menu { float: left; margin-right: 10px; }
		select { width: 500px; }
</style>
<script>

var addressFormatting = function(text){
	var newText = text;
	//array of find replaces
	var findreps = [
		{find:/^([^\-]+) \- /g, rep: '<span class="ui-selectmenu-item-header">$1</span>'},
		{find:/([^\|><]+) \| /g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
		{find:/([^\|><\(\)]+) (\()/g, rep: '<span class="ui-selectmenu-item-content">$1</span>$2'},
		{find:/([^\|><\(\)]+)$/g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
		{find:/(\([^\|><]+\))$/g, rep: '<span class="ui-selectmenu-item-footer">$1</span>'}
	];
	
	for(var i in findreps){
		newText = newText.replace(findreps[i].find, findreps[i].rep);
	}
	return newText;
}
$(function(){
		$('.mselect').selectmenu({
			style:'dropdown', 
			menuWidth: 400,
			maxHeight: 150,
			format: addressFormatting
		});
		$( ".radio" ).buttonset();
});	
</script>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
			
	CDataExam	data=new CDataExam();
	data.Connect();
	ArrayList<CCentro_Regional> centro=data.getListaCentro_Regional();
	ArrayList<CUnidad_Academica> facultad=data.getListaUnidad_Academica();
	ArrayList<CCarrera> carrera=data.getListaCarrera();
	
%>

	<form id="MainForm" name="MainForm" action="../SEstatus_estudiante" method="post">
<div style="float:left;">
<h2>PASO 1 / OPCIONAL, SOLO PARA ESTUDIANTES</h2>
</div>
<div class="button-sig">
<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Guardar"/> 
</div>
<div style="clear: both;"></div>	
<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Estatus del estudiante</h3>
			<div class="perfil">
					<div class="tabla">
						<div class="border">
							
									<div class="col_titulo">Carne</div>
									<div class="col"><%= pac.getCarne() %></div>
									
							<div style="clear: both;"></div>
						</div>																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																														
						<div class="border">
							
									<div class="col_titulo">Centro Regional</div>
									<div class="col">
										<select id="centro_estudiante"  name="centro_estudiante" class="mselect" >
												<option value="0">SELECCIONE SU CENTRO UNIVERSITARIO</option>
										<%
										Iterator<CCentro_Regional> it=centro.iterator();
										while (it.hasNext()) {
											CCentro_Regional cen=it.next();%>
												<option value="<%=cen.getIdcentro_regional()%>" <%= (cen.getIdcentro_regional()==pac.getIdcentro() ?"SELECTED":"")%>><%=cen.getNombre()%></option>
										    <%}
											%>			
										</select>
									</div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Facultad</div>
									<div class="col">
										<select id="facultad_estudiante" name="facultad_estudiante" class="mselect" >
												<option value="0">SELECCIONE SU FACULTAD</option>	
												<%
											Iterator<CUnidad_Academica> it2=facultad.iterator();
											while (it2.hasNext()) {
												CUnidad_Academica fac=it2.next();%>
												<option value="<%=fac.getIdunidad_academica()%>" <%= (fac.getIdunidad_academica()==pac.getIdunidad() ?"SELECTED":"")%> ><%=fac.getNombre()%></option> 
										    <%}%>			
										</select>
									</div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Carrera</div>
									<div class="col">
									
									<select id="carrera_estudiante" name="carrera_estudiante" class="mselect" >
												<option value="0">SELECCIONE SU CARRERA</option>	
												<%
													Iterator<CCarrera> it3=carrera.iterator();
													while (it3.hasNext()) {
														CCarrera car=it3.next();%>
															<option value="<%=car.getIdcarrera()%>" <%= (car.getIdcarrera()==pac.getIdcarrera() ?"SELECTED":"")%>><%=car.getNombre()%></option>
													    <%}
												%>
										</select>
									
									</div>
									
							<div style="clear: both;"></div>
						</div>
						
					</div>	
			</div>
		<div style="clear: both;"></div>
										
</div>

	</form>
<% data.Close();	} %>	
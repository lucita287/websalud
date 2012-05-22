<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CParentesco" %>
<%@ page import="data.CPaciente" %>
<%@ page import="data.CGrupo_Familiar" %>
<%@ page import="data.CMenu_Categoria" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="framework.CValidation" %>
<% 
CValidation valid =new CValidation();
int idparen= valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idparen")));
int edad= valid.ConvertEntero(valid.ValidarRequest(request.getParameter("edad")));
int genero= valid.ConvertEntero(valid.ValidarRequest(request.getParameter("genero")));
int salud= valid.ConvertEntero(valid.ValidarRequest(request.getParameter("salud")));
String trabajo= valid.ValidarRequest(request.getParameter("trabajo"));
String lugar= valid.ValidarRequest(request.getParameter("lugar"));
Double mensual= valid.ConvertDouble(valid.ValidarRequest(request.getParameter("mensual")));
String error= valid.ValidarRequest(request.getParameter("e"));

HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
ArrayList<CParentesco> paren=dbo.getListaParentesco();
String ambiente=dbo.getAmbienteFamiliar(pac.getIdpaciente());
ArrayList<CGrupo_Familiar> grupo=dbo.getListaGrupoFamiliar(pac.getIdpaciente());
CMenu_Categoria menu_desc=dbo.getMenuCategoriaEspecifico(1);
if(menu_desc!=null){
%>
<script  type="text/javascript">
			  $(document).ready(function () {
				  $("#MainPsico").validate();
			  });
	$(function() {
		$(".siguiente").button();	
		$("#button_sig").button();	
	});
	</script>
<form id="MainPsico" name="MainPsico" action="../SDatoPersonal" method="post">	

<div style="float:right">
<input type="submit" class="siguiente" name="a" value="Regresar al menu" />
<input type="submit" class="siguiente" name="a" value="siguiente" />

</div>
<div style="float:left;">
	<h2>PASO 2 / <%= menu_desc.getNombre() %> </h2>
	<input type="hidden" name="idarea" value="<%= menu_desc.getArea_examen()%>" id="idarea"/>
	</div>
		
	<div class="instruccion">
	<%= menu_desc.getInstruccion() %>
	</div>
<div style="clear: both;"></div>

<%if(error.compareTo("")!=0){%>
<div class="ui-state-error">
	<%=error %>
</div>
<% } %>

(Escriba los datos m&aacute;s importantes de su familia o de otras personas que vivan con usted, así
como los problemas en su hogar: econ&oacute;micos, familiares, de salud o de otra índole, especialmente
aquellos que incidan en su salud o su rendimiento estudiantil).

			<textarea rows="4" name="descripcion" id="descripcion" cols="60"><%=ambiente %></textarea>
			<div style="clear: both;"></div>

<h2>GRUPO FAMILIAR (Miembros que est&aacute;n unidos)</h2>

*Parentesco: <select id="par_personal"  class="required" name="par_personal">
												<option value="0">SELECCIONE</option>	
												<%	Iterator<CParentesco> it3=paren.iterator();
												while(it3.hasNext()){
													CParentesco par=it3.next();
													
													%>
													<option value="<%= par.getIdparentesco() %>" <%= (idparen==par.getIdparentesco())?"SELECTED":"" %> ><%= par.getNombre() %></option>
												<% } %>
											</select>
*Edad: <input type="text" size="3" id="edad" class="required number" name="edad" value="<%=edad %>"/>
*Genero: 	<select id="genero" name="genero"  >
			<option value="0" <%= (genero==0)?"SELECTED":"" %> >MASCULINO</option>
			<option value="1" <%= (genero==1)?"SELECTED":"" %> >FEMENINO</option>
		</select>
*Salud: 		
		<select id="salud" name="salud" class="required">
			<option value="0" >SELECCIONE</option>
			<option value="1" <%= (salud==1)?"SELECTED":"" %> >BUENA</option>
			<option value="2"  <%= (salud==2)?"SELECTED":"" %> >REGULAR</option>
			<option value="3" <%= (salud==3)?"SELECTED":"" %> >MALA</option>
		</select>
		<br/>
Trabajo: ocupaci&oacute;n, profesi&oacute;n u oficio: <input type="text" id="trabajo" name="trabajo" value="<%=trabajo %>" size="20"/>
Aporte mensual: <input type="text" size="8" id="mensual" name="mensual"  value="<%=(mensual>0)?mensual:"" %>" /><br/>
Lugar de residencia: <input type="text" id="lugar" name="lugar" size="20" value="<%=lugar %>" />
<div style="clear: both;"></div>
<% if(grupo.size()<9){ %>
<div style="float:right">
	<input type="submit" name="a" class="siguiente" value="Guardar" />
</div>
<% } %>
<div style="clear: both;"></div>
</form>	


<table>		
		<tr style="background:powderBlue;" >
			<td style="width:60px;">Eliminar</td>
			<td style="width:100px;" >Parentesco</td>
			<td style="width:50px;" >Edad</td>
			<td style="width:50px;">Genero</td>
			<td style="width:200px;" >Ocupaci&oacute;n</td>
			<td style="width:50px;">Salud</td>
			<td style="width:200px;">Lugar</td>
		</tr>					
		<tr>
			<td colspan="7">
			<hr/>
			</td>
		</tr>
		
<% 
	Iterator<CGrupo_Familiar> it2=grupo.iterator();
	while(it2.hasNext()){
		CGrupo_Familiar g=it2.next();
		%>
		<tr>
			<td>
			<form  name="MainDelete<%= g.getIdgrupo_familiar() %>" action="../SDatoPersonal" method="post">
			<input type="submit"  name="eliminar" value="Eliminar"/>
			<input type="hidden" name="idestatus" value="4" id="idestatus"/>
			<input type="hidden" name="id" value="<%= g.getIdgrupo_familiar() %>" id="idestatus"/>
			</form>
			</td>
			<td><%=  dbo.getParentescoEspecifico(g.getIdparentesco()) %></td>
			<td><%= g.getEdad() %></td>
			<td><%= (g.getGenero()==1?"F":"M") %></td>
			<td><%= g.getOcupacion() %></td>
			<td><%= (g.getSalud()==1?"B":(g.getSalud()==2)?"R":"M") %></td>
			<td><%= g.getLugar() %></td>
		</tr>
		<tr>
			<td colspan="7">
			<hr/>
			</td>
		</tr>
	<%}%>
	
	
</table>					
<% 		}	} dbo.Close();	} %>
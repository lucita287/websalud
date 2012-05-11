<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CPaciente" %>
<%
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null){
	String user=(String)sessiones.getAttribute("resultado");
	user=(user==null)?"0":user;
CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
%>    
    <form id="MainForm" name="MainForm" action="../SEstudiante" method="post">
    	
    
    		<script  type="text/javascript">
				
			</script>
    			<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">Carnet</div>
								<div class="colc"><input type="text" name="user" size="20px" id="carne" value="<%=(pac==null)?"":pac.getUsuario() %>" /> <input type="submit" id="button_login" class="ui-state-default ui-corner-all" value="Buscar"/> </div>
							</div>
							<div class="fila">
							<hr/>
							</div>
							<div class="fila">
								<div class="col_titulo">Nombre</div>
								<div class="colc"><input type="text"  size="40px" value="<%=(pac==null)?"":pac.getNombre() %>" /></div>
							
								<div class="col_titulo">Apellido</div>
								<div class="colc"><input type="text" size="40px" value="<%=(pac==null)?"":pac.getApellido() %>" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Fecha de Nacimiento</div>
								<div class="colc"><input type="text" size="20px" value="<%= (pac==null)?"":pac.getddmmyyFecha()%>" /></div>
								<div class="col_titulo">Genero</div>
								<div class="colc"> <select id="fecha_nacimiento">
														<option value="1" <%=(pac!=null&&pac.getSexo()==2)?"selected":""%> >FEMENINO</option>
														<option value="2" <%=(pac!=null&&pac.getSexo()==1)?"selected":""%> >MASCULINO</option>
													</select> 
								</div>
							</div>
							<div class="fila">
								
								<div class="col_titulo">Telefono</div>
								<div class="colc"><input type="text" size="25px" value="<%=(pac==null)?"":pac.getTelefono() %>"  /> </div>
								<div class="col_titulo">Celular</div>
								<div class="colc"><input type="text"  size="25px" value="<%=(pac==null)?"":pac.getMovil() %>"  size="20px" /></div>
							</div>
							<div class="fila">	
								<div class="col_titulo">Correo Electronico</div>
								<div class="colc"><input type="text" size="40px" size="30px" value="<%=(pac==null)?"":pac.getEmail() %>" /></div>
								<div class="col_titulo">Direccion</div>
								<div class="colc">
								<textarea  rows="2" cols="35"><%=(pac==null)?"":pac.getDireccion() %></textarea>
								</div>
							</div>
							
				</div>
				</div>
				<div style="clear: both;"></div>
							<table id="fecha_citas" style="display:none"></table>
			<script>	
			 $(document).ready(function () {
				     $("#fecha_citas").flexigrid
						({
							method: 'POST',
							// url: '../SFecha_actividadTable',
							 dataType : 'xml',
						    colModel: [
							{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
							{ display: 'ID', name: 'idfecha_actividad', width: 40, sortable: true, align: 'left' },
							{ display: 'Fecha', name: 'fecha', width: 80, sortable: true, align: 'left' },
							{ display: 'Estado', name: 'hora_inicio', width: 90, sortable: true, align: 'left' },
							],
							showTableToggleBtn: true,
						    usepager: true,
						    sortname: "idfecha_actividad",
							sortorder: "desc",
						    title: 'FECHAS DE CITAS',
						    useRp: true,
						    rp: 30,
						    width: 600,
						    height: 300,
							params : [ 
							          {name: 'idactividad', value: 0},{name: 'f_ini', value: ''},{name: 'f_fin', value: ''} 
							        ]
						});
				  });  
			</script>
	</form>			
<% } %>			
package servlet_examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CCategoria_Interpretacion;
import data.CCondicion;
import data.CMenu;
import data.CPregunta;
import data.CResultado_Examen;
import data.CTipo_Interpretacion;
import data.CUsuarioPermiso;
import data.CEncabezado_Condicion;
import framework.CDataExam;
import framework.CValidation;

/**
 * Servlet implementation class SInterpretacion
 */
@WebServlet("/SInterpretacion")
public class SInterpretacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SInterpretacion() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); 
    	PrintWriter out = response.getWriter(); 
    	CValidation valid=new CValidation();
    	String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
    	String action=valid.ValidarRequest(request.getParameter("a"));
    	HttpSession sessiones = request.getSession(false);
    	
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
										CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
										CDataExam dbo=new CDataExam();
										dbo.Connect();
				if((user_permiso.getIdpermiso().indexOf(261)>-1  ||user_permiso.getIdpermiso().indexOf(256)>-1  || user_permiso.getIdpermiso().indexOf(257)>-1 || user_permiso.getIdusuario().getidusuario()==1)){						
										if(action.equalsIgnoreCase("guardartipo")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tipo")));
											int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
											String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
											String validacion=valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(nombre, "Descripcion"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
											
											
											if(validacion.compareTo("")==0){
												CTipo_Interpretacion tipo=new CTipo_Interpretacion(idtipo,nombre,orden);
												boolean b=dbo.UpdateTipo_Interpretacion(tipo);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}else if(action.equalsIgnoreCase("newtipo")){
											String result="";
											String nombre=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("nombre")),codificacion);
											String validacion=valid.ValidarCampoVacio(nombre, "Descripcion");
											int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(nombre, 100, "Descripcion"):validacion;
											
											if(validacion.compareTo("")==0){
												CTipo_Interpretacion tipo=new CTipo_Interpretacion(0,nombre,orden);
												boolean b=dbo.SafeTipo_Interpretacion(tipo);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
												
										}else if(action.equalsIgnoreCase("deletetipo")){
											String result="";
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_tipo")));
											String validacion=valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.deleteTipo_Interpretacion(idtipo);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
												}
											}else result=validacion;
											out.println(result);
												
										}else if(action.equalsIgnoreCase("safe_interpreta")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int id_interpre=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_interpre")));
											String interpretacion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("interpretacion")),codificacion);
											String titulo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("titulo")),codificacion);
											int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
											
											String validacion=valid.ValidarSiesMayor(id_interpre, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarCampoVacio(titulo, "Titulo"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 100, "Titulo"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(interpretacion, 5000, "Descripcion"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una tipo de interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												CResultado_Examen exam=new CResultado_Examen(id_interpre,titulo,interpretacion,idtipo,size,orden);
												boolean b=dbo.UpdateResultadoExamen(exam);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
											
											
										}else if(action.equalsIgnoreCase("new_interpreta")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											String interpretacion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("interpretacion")),codificacion);
											String titulo=valid.Limpiarvalor(valid.ValidarRequest(request.getParameter("titulo")),codificacion);
											int size=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("size")));
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											int orden=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("orden")));
											String validacion=valid.ValidarCampoVacio(titulo, "Titulo");
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(titulo, 100, "Titulo"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(interpretacion, 5000, "Descripcion"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una tipo de interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												CResultado_Examen exam=new CResultado_Examen(0,titulo,interpretacion,idtipo,size,orden);
												boolean b=dbo.SafeResultadoExamen(exam);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
										}else if(action.equalsIgnoreCase("deleteinter")){
											String result="";
											int idcate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_interpre")));
											String validacion=valid.ValidarSiesMayor(idcate, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.deleteResultadoExamen(idcate);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
												}
											}else result=validacion;
											out.println(result);
												
										}else if(action.equalsIgnoreCase("show_interpetar")){
											String result=" ";
											int id=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_interpre")));
											CResultado_Examen exam=dbo.getresultado_examenEspecifico(id);
											 if(exam!=null){							 
												 result= "{\"titulo\":\""+exam.getTitulo()+"\",\"size\":\""+exam.getSize()+"\",\"interpretacion\":\""+ valid.Limpiarvalor3(exam.getInterpretacion())+"\",\"tipo\":\""+exam.getIdtipo_interpretacion()+"\",\"orden\":\""+exam.getOrden()+"\"}";
											 }
											 out.println(result); 
										}else if(action.equalsIgnoreCase("NuevoEncabezado")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											String descripcion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("descripcion")),codificacion);
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											
											String validacion=valid.ValidarCampoVacio(descripcion, "Descripcion");
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(descripcion, 250, "Descripcion"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una tipo de interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												CEncabezado_Condicion exam=new CEncabezado_Condicion(0,descripcion,idtipo);
												boolean b=dbo.SafeEncabezado_Condicion(exam);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
										}else if(action.equalsIgnoreCase("EditarEncabezado")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											String descripcion=valid.Limpiarvalor2(valid.ValidarRequest(request.getParameter("descripcion")),codificacion);
											int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											int idencabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idencabezado")));
											String validacion=valid.ValidarCampoVacio(descripcion, "Descripcion");
											validacion=(validacion.compareTo("")==0)?valid.ValidarLongintud(descripcion, 250, "Descripcion"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idtipo, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una tipo de interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												CEncabezado_Condicion exam=new CEncabezado_Condicion(idencabezado,descripcion,idtipo);
												boolean b=dbo.UpdateEncabezado_Condicion(exam);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
										}else if(action.equalsIgnoreCase("showsubpreguntas")){
											int cate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcate")));
											ArrayList<CPregunta> preg=dbo.getListaPreguntas(cate);
					
											String data="";
											for(int i=0; i<preg.size(); i++){
												CPregunta pregunta=preg.get(i);
												data+=(data.equalsIgnoreCase("")?"":",");
												data+="{\"idmenu\":\""+pregunta.getIdpregunta()+"\",\"descripcion\": \""+pregunta.getOrden()+")"+pregunta.getPregunta()+"\"}";
											}
											
												String result=	" {\"menus\": [  "+data+" ] }";
												 out.println(result);
										}else if(action.equalsIgnoreCase("show_condicion")){
											String result=" ";
											int id=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											CEncabezado_Condicion exam=dbo.getEncabezado_CondicionEspecifico(id); 
											if(exam!=null){							 
												 result= "{\"descripcion\":\""+exam.getDescripcion()+"\"}";
											 }
											 out.println(result); 
										}else if(action.equalsIgnoreCase("guardarcond")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int idencab=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int idpregunta=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpregunta")));
											int signo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("signo")));
											int valor=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("valor")));
											
											String validacion=valid.ValidarSiesMayor(idencab, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idpregunta, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una pregunta\"}"):validacion;
											String dsigno="";
											if(signo==1) dsigno=">";
											else if(signo==2) dsigno="<";
											else if(signo==3) dsigno=">=";
											else if(signo==4) dsigno="<=";
											else if(signo==5) dsigno="=";
											else dsigno="!=";
												
												if(validacion.compareTo("")==0){
													int orden=dbo.getOrdenIdPregunta(idpregunta);
													CCondicion condi=new CCondicion(idpregunta,signo, valor,
															0, 0, idencab,
															null,null,null,"P"+orden+" "+dsigno+" "+valor );
													boolean b=dbo.SafeCondicion(condi);
													if(!b){
														result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
													}else{
														result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
													}
												}else result=validacion;
												out.println(result);
										}else if(action.compareTo("deletecondicion")==0){
											String result="";
											int id_condicion=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_condicion")));
											String validacion=valid.ValidarSiesMayor(id_condicion, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.deleteCondicion(id_condicion);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}else if(action.compareTo("deletetabla_condi")==0){
											String result="";
											int id_encabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											String validacion=valid.ValidarSiesMayor(id_encabezado, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item\"}");
											if(validacion.compareTo("")==0){
												boolean b=dbo.deleteEncabezado_Condicion(id_encabezado);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}else if(action.equalsIgnoreCase("showcondiciones")){
											int id_encabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idencabe")));
											ArrayList<CCondicion> preg=dbo.getListaCondicion3(id_encabezado);
											
											String data="";
											for(int i=0; i<preg.size(); i++){
												CCondicion pregunta=preg.get(i);
												data+=(data.equalsIgnoreCase("")?"":",");
												data+="{\"idmenu\":\""+pregunta.getIdcondicion()+"\",\"descripcion\": \""+pregunta.getIdcondicion()+"/"+pregunta.getDescripcion()+"\"}";
											}
											
												String result=	" {\"menus\": [  "+data+" ] }";
												 out.println(result);
										}else if(action.equalsIgnoreCase("guardar_and_or")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int idencab=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int idcondi1=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("condicion1")));
											int idcondi2=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("condicion2")));
											int tipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											
											String validacion=valid.ValidarSiesMayor(idencab, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idcondi1, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una condicion 1\"}"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idcondi2, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una condicion 2\"}"):validacion;
											String dtipo="";
											if(tipo==1) dtipo="AND";
											else if(tipo==2) dtipo="OR";
											
												if(validacion.compareTo("")==0){
													String descrip1=dbo.getDescripcionCondicion(idcondi1);
													String descrip2=dbo.getDescripcionCondicion(idcondi2);
													CCondicion condi1=new CCondicion(null,null,null,
															null, idcondi1,null,
															null,null,null,null);
													CCondicion condi2=new CCondicion(null,null,null,
															null, idcondi2,null,
															null,null,null,null);
													CCondicion condi=new CCondicion(null,null, null,
															tipo, 0, idencab,
															condi1,condi2,null,descrip1+" "+dtipo+" "+descrip2);
													boolean b=dbo.SafeCondicion(condi);
													if(!b){
														result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
													}else{
														result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
													}
												}else result=validacion;
												out.println(result);
										}else if(action.equalsIgnoreCase("guardar_paren")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int idencab=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int idcondi1=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("condicion")));
											int tipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("tipo")));
											
											String validacion=valid.ValidarSiesMayor(idencab, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(idcondi1, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una condicion 1\"}"):validacion;
											String dtipo="";
											if(tipo==3) dtipo="";
											else if(tipo==4) dtipo="NOT";
											
												if(validacion.compareTo("")==0){
													String descrip1=dbo.getDescripcionCondicion(idcondi1);
													CCondicion condi1=new CCondicion(null,null,null,
															null, idcondi1,null,
															null,null,null,null);
													CCondicion condi=new CCondicion(null,null, null,
															tipo, 0, idencab,
															condi1,null,null,dtipo+"("+descrip1+")");
													
													boolean b=dbo.SafeCondicion(condi);
													if(!b){
														result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado\"}";
													}else{
														result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
													}
												}else result=validacion;
												out.println(result);
										}else if(action.equalsIgnoreCase("showtipointer")){
											int cate=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idtipo")));
											ArrayList<CResultado_Examen> preg=dbo.getListaResultado_Examen (cate);
					
											String data="";
											for(int i=0; i<preg.size(); i++){
												CResultado_Examen pregunta=preg.get(i);
												data+=(data.equalsIgnoreCase("")?"":",");
												data+="{\"idmenu\":\""+pregunta.getIdresultado_examen()+"\",\"descripcion\": \""+pregunta.getTitulo()+"\"}";
											}
											
												String result=	" {\"menus\": [  "+data+" ] }";
												 out.println(result);
										}else if(action.equalsIgnoreCase("guardarresult")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int id_encabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int id_inter=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idinter")));
											
											
											String validacion=valid.ValidarSiesMayor(id_encabezado, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(id_encabezado, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}"):validacion;
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(id_inter, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.Saferesultado_condicion(id_encabezado,id_inter);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha almacenado, ya existe\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}else if(action.equalsIgnoreCase("deleteencabe_result")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int id_encabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int id_inter=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_inter")));
											String validacion=valid.ValidarSiesMayor(id_encabezado, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(id_inter, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una interpretacion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.deleteresultado_condicion(id_encabezado,id_inter);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha eliminado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Eliminado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}else if(action.equalsIgnoreCase("updateInicio")){
											String result="{\"resultado\":\"OK\",\"mensaje\":\"Almacenado\"}";
											int id_encabezado=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_encabezado")));
											int id_condicion=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("id_condicion")));
											String validacion=valid.ValidarSiesMayor(id_encabezado, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar un item de encabezado\"}");
											validacion=(validacion.compareTo("")==0)?valid.ValidarSiesMayor(id_condicion, 1,"{\"resultado\":\"ERROR\",\"mensaje\":\"Debe Seleccionar una condicion\"}"):validacion;
											
											if(validacion.compareTo("")==0){
												boolean b=dbo.update_condicion(id_encabezado,id_condicion);
												if(!b){
													result="{\"resultado\":\"ERROR\",\"mensaje\":\"No se ha actualizado\"}";
												}else{
													result="{\"resultado\":\"OK\",\"mensaje\":\"Actualizado\"}";
												}
											}else result=validacion;
											out.println(result);
											
										}
				}					
										dbo.Close();
		 }						 
    	
    
	}

}

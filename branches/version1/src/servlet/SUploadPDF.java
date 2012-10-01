package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import data.CConfiguracion;
import data.CMultimedia;
import data.CUsuario;
import data.CUsuarioPermiso;
import framework.CDataBase;

/**
 * Servlet implementation class SUploadPDF
 */
@WebServlet("/SUploadPDF")
public class SUploadPDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SUploadPDF() {
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
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!ServletFileUpload.isMultipartContent(request)) {
			throw new IllegalArgumentException("Request is not multipart, please 'multipart/form-data' enctype for your form.");
		}
		
		String codificacion=request.getCharacterEncoding();
		codificacion=(codificacion==null)?"ISO-8859-1":codificacion;
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		PrintWriter writer = response.getWriter();
		response.setContentType("text/plain");
		HttpSession sessiones = request.getSession(false);
		 if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
			 CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");			 
			 if( (user_permiso.getIdpermiso().indexOf(222)>-1  ||user_permiso.getIdpermiso().indexOf(226)>-1 ||user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1)){


			
			CDataBase dbo=new CDataBase();
			 dbo.Connect();
			CUsuario usuario=user_permiso.getIdusuario(); 
			
			
			CConfiguracion config=dbo.getConfiguracion();
			String realpath=getServletContext().getRealPath("/");
			String repositorio=realpath+config.getdireccion_pdf();
			String repositorio_relativo=config.getdir_rel_pdf();
			repositorio_relativo=repositorio_relativo.replace("\\", "\\\\");
			int tam_max=config.gettamanio_sub();
			///////////ESCRIBIR ARCHIVOS
			try {
				
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						if(item.getSize()<=(tam_max*1048576)){
								String name= item.getName();
								File file2 = new File(name);
								int id=dbo.getMultimediaTotal();
								name=file2.getName();
								name=name.toLowerCase();
								java.util.GregorianCalendar gre=new java.util.GregorianCalendar();
								String name2=id+"usalud"+gre.getTimeInMillis()+".pdf";
								if(name.endsWith(".pdf")){
										CMultimedia imagen=new CMultimedia(0, repositorio+name2,repositorio_relativo+ name2,item.getSize(),2,usuario);						
										File file = new File(imagen.getdireccion());
										item.write(file);
										boolean b=dbo.SafeMultimedia(imagen);
										int safe=dbo.getMultimediaEspecifica(imagen.getdireccion()).getidimagen();
										if(b)
											writer.write("{\"result\":\"OK\",\"name\":\""+imagen.getdireccion_relativa() + "\",\"idsafe\":" + safe + ",\"Mensaje\":\"Almacenado\"}");
										else
											writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"idsafe\":0,\"Mensaje\":\"Error al guardar\"}");	
										break; // assume we only get one file at a time
								}else{
									writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"idsafe\":0,\"Mensaje\":\"Unicamente se aceptan imagenes del tipo PDF\"}");
								}	
						}else{
							writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"idsafe\":0,\"Mensaje\":\"El pdf es mas grande de lo permitido, el maximo permitido es "+tam_max+"MB \"}");
						}	
					} 
				}
			} catch (FileUploadException e) {
				writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"idsafe\":0,\"Mensaje\":\"Error al guardar\"}");
			} catch (Exception e) {
				writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"idsafe\":0,\"Mensaje\":\"Error al guardar\"}");
			} finally {
				writer.close();
				dbo.Close();
			}
			
		}
	}	 

	}
}

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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import framework.CDataBase;

/**
 * Servlet implementation class SUploadImagen
 */
@WebServlet("/SUploadImagen")
public class SUploadImagen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SUploadImagen() {
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
		
		CDataBase dbo=new CDataBase();
		 dbo.Connect();
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		PrintWriter writer = response.getWriter();
		response.setContentType("text/plain");
		String repositorio="C:\\Users\\lucita\\Desktop\\PATH_IMAGEN\\";
		String repositorio_relativo="C:\\Users\\lucita\\Desktop\\PATH_IMAGEN\\";
		repositorio_relativo=repositorio_relativo.replace("\\", "\\\\");
		///////////ESCRIBIR ARCHIVOS
		try {
			
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) {
					String name=item.getName();
					File file2 = new File(name);
					name=file2.getName();
					File file = new File(repositorio+name);
					item.write(file);
					writer.write("{\"result\":\"OK\",\"name\":\""+repositorio_relativo+ name + "\",\"type\":\"" + item.getContentType() + "\",\"size\":\"" + item.getSize() + "\"}");
					break; // assume we only get one file at a time
				} 
			}
		} catch (FileUploadException e) {
			writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"type\":\"\",\"size\":\"\"}");
		} catch (Exception e) {
			writer.write("{\"result\":\"ERROR\",\"name\":\"\",\"type\":\"\",\"size\":\"\"}");
		} finally {
			writer.close();
		}

	}

}

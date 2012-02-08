package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * uploadFichero.java
 *
 * Created on 4 de agosto de 2003, 22:26
 */

import java.io.*;
import org.apache.commons.fileupload.*;
import java.util.*;
/**
 * Servlet implementation class uploadFichero
 */
@WebServlet("/uploadFichero")
public class uploadFichero extends HttpServlet {
	 protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			    throws ServletException, IOException {
			        response.setContentType("text/html");
			        PrintWriter out = response.getWriter();
			        out.println("<html>");
			        out.println("<head>");
			        out.println("<title>Servlet</title>");
			        out.println("</head>");
			        out.println("<body>");

			        System.out.println("Comenzamos procesamiento ficheros");

			        procesaFicheros(request,out);

			        out.println("</body>");
			        out.println("</html>");

			        out.close();
			    }


			    void depura(String cadena)
			    {
			        System.out.println("El error es " + cadena);
			    }

			    public boolean procesaFicheros(HttpServletRequest req, PrintWriter out ) {
			        try {
			            // construimos el objeto que es capaz de parsear la perici�n
			            DiskFileUpload fu = new DiskFileUpload();
			            int size=1024*512*5;
			            // maximo numero de bytes
			            fu.setSizeMax(1024*512*5); // 512 K

			            depura("Ponemos el tama�o m�ximo");
			            // tama�o por encima del cual los ficheros son escritos directamente en disco
			            fu.setSizeThreshold(size);

			            // directorio en el que se escribir�n los ficheros con tama�o superior al soportado en memoria
			            fu.setRepositoryPath("C:\\Users\\lucita\\Desktop\\prueba\\");

			            // ordenamos procesar los ficheros
			            List fileItems = fu.parseRequest(req);

			            if(fileItems == null)
			            {
			                depura("La lista es nula");
			                return false;
			            }

			            out.print("<br>El n�mero de ficheros subidos es: " +  fileItems.size());

			            // Iteramos por cada fichero
				    Iterator i = fileItems.iterator();
			            FileItem actual = null;
			            depura("estamos en la iteraci�n");

			            while (i.hasNext())
			            {
			                actual = (FileItem)i.next();
			                String fileName = actual.getName();
			                out.println("<br>Nos han subido el fichero" + fileName);

			                // construimos un objeto file para recuperar el trayecto completo
			                File fichero = new File(fileName);
			                depura("El nombre del fichero es " + fichero.getName());

			                // nos quedamos solo con el nombre y descartamos el path
			                fichero = new  File("C:\\Users\\lucita\\workspace\\websalud\\WebContent\\images\\final_user\\" + fichero.getName());

			                // escribimos el fichero colgando del nuevo path
			                actual.write(fichero);
			            }

			        }
			        catch(Exception e) {
			            depura("Error de Aplicaci�n " + e.getMessage());
			            return false;
			        }

			        return true;
			    }

			    /** Handles the HTTP <code>POST</code> method.
			     * @param request servlet request
			     * @param response servlet response
			     */
			    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			    throws ServletException, IOException {
			        processRequest(request, response);
			    }

}

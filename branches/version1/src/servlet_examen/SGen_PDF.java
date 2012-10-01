package servlet_examen;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import framework.CDataBase;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;

/**
 * Servlet implementation class SGen_PDF
 */
@WebServlet("/SGen_PDF")
public class SGen_PDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGen_PDF() {
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
		//HttpSession session=request.getSession(false);
			response.setHeader( "Content-Disposition", "attachment; filename=\"" + request.getParameter("report_name")+".pdf" + "\"" );
			response.setContentType("application/pdf");
			try{
				String realpath=getServletContext().getRealPath("/");
				File reportFile = new File(realpath+"/secretaria/report_view/"+request.getParameter("report")+".jasper");
				if (!reportFile.exists())
					throw new JRRuntimeException("El archivo "+request.getParameter("report")+".jasper no se encontro.");
				@SuppressWarnings("deprecation")
				JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			
				Map<String,Object> parameters = new HashMap<String,Object>();
				String[] params;
				params=(request.getParameter("parameters")!="") ? request.getParameter("parameters").toString().split(",") :  null;
				if(params!=null){
					String[] values=request.getParameter("values").toString().split("\\|");
					for(int i=0; i<params.length;i++){
						String param=params[i];
						parameters.put(param, values[i]);
					}
				}
				parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/secretaria/report_view/")));
				CDataBase db=new CDataBase();
				if(db.Connect()){
					JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,db.getconnection());
					response.setContentType("application/pdf");
					JRPdfExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					
					OutputStream ouputStream = response.getOutputStream();
					exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
					try {
						exporter.exportReport();
					} 
					catch (JRException e) {
						e.printStackTrace();
					}
					finally
					{
						if (ouputStream != null)
						{
							try
							{
								ouputStream.close();
							}
							catch (IOException ex)
							{
								ex.printStackTrace();
							}
						}
					}
					db.Close();
				}
			}
			catch (Throwable e)
			{
				e.printStackTrace();
			}
	}
}

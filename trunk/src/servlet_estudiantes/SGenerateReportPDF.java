package servlet_estudiantes;


import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import framework.CDataBase;

/**
 * Servlet implementation class SGenerateReportPDF
 */
@WebServlet("/SGenerateReportPDF")
public class SGenerateReportPDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGenerateReportPDF() {
        super();
        // TODO Auto-generated constructor stub
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
		HttpSession session=request.getSession(false);
			response.setHeader( "Content-Disposition", "attachment; filename=\"" + request.getParameter("report_name")+".pdf" + "\"" );
			response.setContentType("application/pdf");
			try{
				String realpath=getServletContext().getRealPath("/");
				File reportFile = new File(realpath+"/estudiante/report_view/"+request.getParameter("report")+".jasper");
				File r2 = new File(realpath+"/estudiante/report_view/examen_fisico.jrprint");
				File r3 = new File(realpath+"/estudiante/report_view/medicina.jrprint");
				if (!reportFile.exists())
					throw new JRRuntimeException("El archivo "+request.getParameter("report")+".jasper no se encontro.");

				JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
				
				Map parameters = new HashMap();
				String[] params;
				params=(request.getParameter("parameters")!="") ? request.getParameter("parameters").toString().split(",") :  null;
					String[] values=request.getParameter("values").toString().split("\\|");
					parameters.put("idpaciente", 1);
					parameters.put("SUBREPORT_DIR","./");
				
				parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/estudiante/report_view/")));
				
				CDataBase db=new CDataBase();
				if(db.Connect()){
					JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,db.getconnection());
					JasperPrint jp2 =(JasperPrint) JRLoader.loadObject(r2);
					JasperPrint jp3 =(JasperPrint) JRLoader.loadObject(r3);
					//=JasperFillManager.fillReport(r2.getPath(), null, db.getconnection());
					List pages = jp2 .getPages();
					
					for (int j = 0; j < pages.size(); j++) {
			            JRPrintPage object = (JRPrintPage)pages.get(j);
			            jasperPrint.addPage(object);

					}
					pages = jp3 .getPages();
					for (int j = 0; j < pages.size(); j++) {
			            JRPrintPage object = (JRPrintPage)pages.get(j);
			            jasperPrint.addPage(object);

					}

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

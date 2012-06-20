package servlet_estudiantes;

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
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import data.CPaciente;
import framework.CDataExam;

/**
 * Servlet implementation class SGenerateReportAutoPDF
 */
@WebServlet("/SGenerateReportAutoPDF2")
public class SGenerateReportAutoPDF2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SGenerateReportAutoPDF2() {
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
				HttpSession sessiones=request.getSession(false); 
				if(sessiones!=null && ( sessiones.getAttribute("paci_consulta")!=null )) {
					CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");	;		
					response.setHeader( "Content-Disposition", "attachment; filename=\"ExamAutoevaluacion.pdf" + "\"" );
					response.setContentType("application/pdf");
					try{
						String realpath=getServletContext().getRealPath("/");
						File reportFile = new File(realpath+"/estudiante/report_view/RTituloAuto.jasper");
						
						@SuppressWarnings("deprecation")
						JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
						
						Map<String,Object> parameters = new HashMap<String,Object>();
							parameters.put("idpaciente",pac.getIdpaciente() );
							String result=request.getParameter("resultado").trim();
							parameters.put("result_exam",result);
							parameters.put("SUBREPORT_DIR","./");
						
						parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/estudiante/report_view/")));
						
						CDataExam db=new CDataExam();
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
				}else{
					response.sendRedirect("index.jsp");
				}
	}

}

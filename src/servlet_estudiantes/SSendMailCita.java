package servlet_estudiantes;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


import data.CAnuncio;
import data.CCita;
import data.CConfiguracion;
import data.CPaciente;
import framework.CDataExam;
import framework.CValidation;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.SimpleFileResolver;

/**
 * Servlet implementation class SSendMailCita
 */
@WebServlet("/SSendMailCita")
public class SSendMailCita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SSendMailCita() {
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
		CDataExam db=new CDataExam();
		CValidation valid =new CValidation();
		HttpSession sessiones=request.getSession(false); 
		
		if(db.Connect()){	
			if(sessiones!=null && ( sessiones.getAttribute("paci_consulta")!=null )) {
				CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
				if(pac.getEmail()!=null && !pac.getEmail().equalsIgnoreCase("")){
				String realpath=getServletContext().getRealPath("/");
					CCita cita=db.getCita(valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita"))));
					File reportFile =null;
					if(cita.getTipo_examen()==2)
					reportFile = new File(realpath+"/estudiante/report_view/multi_cita.jasper");
					else reportFile = new File(realpath+"/estudiante/report_view/auto_cita.jasper");
					
					CConfiguracion config=db.getConfiguracion();
					@SuppressWarnings("deprecation")
					JasperReport jasperReport=null;
					try {
						jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
					} catch (JRException e1) {
						e1.printStackTrace();
					}
					
					Map<String,Object> parameters = new HashMap<String,Object>();
						parameters.put("idpaciente",pac.getIdpaciente() );
						parameters.put("idcita",cita.getIdcita());
						parameters.put("SUBREPORT_DIR","./");
					
					parameters.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(realpath+"/estudiante/report_view/")));
					
					
					CAnuncio anuncio=db.getAnuncioEspecifico(12);
						JasperPrint jasperPrint;
						try {
							jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,db.getconnection());
							ByteArrayOutputStream baos = new ByteArrayOutputStream();
							JasperExportManager.exportReportToPdfStream(jasperPrint, baos);
							DataSource aAttachment =  new ByteArrayDataSource(baos.toByteArray(), "application/pdf");
						
							
							
							Properties props = new Properties();
				            props.put("mail.smtp.host", config.getSmtp_javamail());
				            props.setProperty("mail.smtp.starttls.enable", "true");
				            props.setProperty("mail.smtp.port", config.getPort_javamail());
				            props.setProperty("mail.smtp.user", config.getCorreo_javamail());
				            props.setProperty("mail.smtp.auth", "true");

				            Session session = Session.getDefaultInstance(props, null);
				            // session.setDebug(true);

				            // Se compone la parte del texto
				            BodyPart texto = new MimeBodyPart();
				            //texto.setText(anuncio.getContenido());
				            texto.setContent("<html><body>"+anuncio.getContenido()+"</body></html>","text/html");
				            // Se compone el adjunto con la imagen
				            BodyPart adjunto = new MimeBodyPart();
				            adjunto.setDataHandler(
				                new DataHandler(aAttachment));
				            adjunto.setFileName("CitaExamenSalud.pdf");

				            // Una MultiParte para agrupar texto e imagen.
				            MimeMultipart multiParte = new MimeMultipart();
				            
				            multiParte.addBodyPart(texto);
				            multiParte.addBodyPart(adjunto);

				            // Se compone el correo, dando to, from, subject y el
				            // contenido.
				            MimeMessage message = new MimeMessage(session);
				            
				            message.setFrom(new InternetAddress(config.getCorreo_javamail()));
				            message.addRecipient(
				                Message.RecipientType.TO,
				                new InternetAddress(pac.getEmail()));
				            message.setSubject("Cita Examen de Salud / USAC");
				            message.setContent(multiParte);

				            // Se envia el correo.
				            Transport t = session.getTransport("smtp");
				            t.connect(config.getCorreo_javamail(), config.getPass_javamail());
				            t.sendMessage(message, message.getAllRecipients());
				            t.close();
							
							
							
							
							
							
							
							
						}  catch (Exception e) {
				                e.printStackTrace();
				            }					
					
					}		
			}
			db.Close();
		}	
	}

}

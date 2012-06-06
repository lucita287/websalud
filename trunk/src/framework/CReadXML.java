package framework;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import data.CPaciente;
import data.CPacienteWebService;


public class CReadXML {
	CValidation valid=new CValidation();
	public int status_verificar_pin(String xml){
		ByteArrayInputStream input = null;
	    SAXBuilder builder = new SAXBuilder();
        try {
        	input = new ByteArrayInputStream(xml.getBytes("UTF8"));
			Document document = (Document) builder.build(input);
            
			Element node=getNode("STATUS",document);
            
            int status=valid.ConvertEntero(node.getText());
            return status;
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		}
		return 0;
	}
	public CPaciente verificar_Inscrito(String xml,CDataExam dbo,CPacienteWebService datapac){
		ByteArrayInputStream input = null;
	    SAXBuilder builder = new SAXBuilder();
        try {
        	input = new ByteArrayInputStream(xml.getBytes("UTF8"));
			Document document = (Document) builder.build(input);
            
        	Element node1=getNode("STATUS",document);
        	int status=valid.ConvertEntero(node1.getText());
        	CPaciente paciente =null;
        	if(status==1){
        	
        	Element node=getNode("DATOS",document);
            int carne=valid.ConvertEntero(node.getChildText("CARNET"));
            int sexo=valid.ConvertEntero(node.getChildText("SEXO"));
            Date fecha=valid.CambiarFormatoyyyymmdd(node.getChildText("FECHA_NACIMIENTO"));
            int cod_nac=valid.ConvertEntero(node.getChildText("CODIGO_NACIONALIDAD"));
            int cod_depto=valid.ConvertEntero(node.getChildText("DEPTO_RECIDENCIA"));
            int nacionalidad=dbo.SafeNacionalidad(cod_nac,node.getChildText("NACIONALIDAD"));
            int departamento=dbo.SafeDepartamento(cod_depto,node.getChildText("DEPARTAMENTO_RECIDENCIA"));
            int idunidad=dbo.SafeUnidadAcademica(datapac.getCodigo_unidad(),datapac.getUnidad_academica());
            
          
            paciente =new CPaciente(0,node.getChildText("NOMBRES"), fecha,
        			carne, node.getChildText("DIRECCION")+", "+node.getChildText("MUNICIPIO_RECIDENCIA"), node.getChildText("TELEFONO"),node.getChildText("CELULAR"),
        			sexo, node.getChildText("CORREO"),carne+"",node.getChildText("APELLIDOS"),nacionalidad,departamento,
        			1, 0, idunidad);
        	}
            return paciente;
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public CPacienteWebService ReadDatosGenerales(String xml,String carne){
		ByteArrayInputStream input = null;
	    SAXBuilder builder = new SAXBuilder();
	    CValidation valid=new CValidation();
        try {
        	input = new ByteArrayInputStream(xml.getBytes("UTF8"));
			Document document = (Document) builder.build(input);
			CPacienteWebService pac=new CPacienteWebService(valid.ConvertEntero(carne), 0,"", 0, "",0);
        	Element node1=getNode("DETALLE_ACADEMICO",document);
        	List lista=(node1!=null)?node1.getChildren():null;
		    if(lista!=null){    	
        		Iterator<Element> it=lista.iterator();
		        	while(it.hasNext()){
		        		Element node=it.next();
		        		if(node.getName().compareTo("UNIDAD")==0){
		        			pac.setCodigo_unidad(valid.ConvertEntero(node.getText()));
		        		}else if(node.getName().compareTo("EXTENSION")==0){
		        			pac.setExtension(valid.ConvertEntero(node.getText()));
		        		}else if(node.getName().compareTo("CARRERA")==0){
		        			pac.setCodigo_carrera(valid.ConvertEntero(node.getText()));
		        		}else if(node.getName().compareTo("NOMBRE_UNIDAD")==0){
		        			pac.setUnidad_academica(node.getText());
		        		}else if(node.getName().compareTo("NOMBRE_CARRERA")==0){
		        			pac.setCarrera(node.getText());
		        		}
		        	}		
		        		
		        	}
        	return pac;
		} catch (JDOMException | IOException e) {
			
		}
		return null;
	}
	
	private Element getNode(String label,Document document){
		Element rootNode = document.getRootElement();
        Element node = rootNode.getChild(label);
        return node;
	}
}

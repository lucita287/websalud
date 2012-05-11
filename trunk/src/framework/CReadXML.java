package framework;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Date;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import data.CPaciente;


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
	public CPaciente verificar_Inscrito(String xml,CDataExam dbo){
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
            paciente =new CPaciente(0, node.getChildText("NOMBRES"), fecha,
        			carne, node.getChildText("DIRECCION")+", "+node.getChildText("MUNICIPIO_RECIDENCIA"), node.getChildText("TELEFONO"),node.getChildText("CELULAR"),
        			 0,sexo,"", node.getChildText("CORREO"),
        			carne+"",0,node.getChildText("APELLIDOS"),nacionalidad,departamento,
        			1, 0);
        	}
            return paciente;
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	private Element getNode(String label,Document document){
		Element rootNode = document.getRootElement();
        Element node = rootNode.getChild(label);
        return node;
	}
}

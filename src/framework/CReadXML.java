package framework;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;


public class CReadXML {
	public int status_verificar_pin(String xml){
	    ByteArrayInputStream input = null;
	    SAXBuilder builder = new SAXBuilder();
        try {
        	input = new ByteArrayInputStream(xml.getBytes("UTF8"));
			Document document = (Document) builder.build(input);
            Element rootNode = document.getRootElement();
            Element node = rootNode.getChild("STATUS");
            
            CValidation valid=new CValidation();
            int status=valid.ConvertEntero(node.getText());
            return status;
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		}
		return 0;
	}
}

package general.xml;

import java.io.StringWriter;
import java.util.List;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.namespace.QName;
import javax.xml.transform.stream.StreamSource;

/**
 * http://blog.bdoughan.com/2012/11/creating-generic-list-wrapper-in-jaxb.html
 * 
 */
public final class XMLUtil {
    /**
     * Unmarshal XML to XMLWrapper and return List value.
     */
    @SuppressWarnings("unchecked")
    public static <T> List<T> unmarshal(Unmarshaller unmarshaller, Class<T> clazz, String xmlLocation) throws JAXBException {
        StreamSource xml = new StreamSource(xmlLocation);
        XMLWrapper<T> wrapper = (XMLWrapper<T>) unmarshaller.unmarshal(xml, XMLWrapper.class).getValue();
        return wrapper.getItems();
    }

    /**
     * Wrap List in XMLWrapper, then leverage JAXBElement to supply root element information.
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static String marshal(Marshaller marshaller, List<?> list, String name) throws JAXBException {
        QName qName = new QName(name);
        XMLWrapper wrapper = new XMLWrapper(list);
        JAXBElement<XMLWrapper> jaxbElement = new JAXBElement<XMLWrapper>(qName, XMLWrapper.class, wrapper);
        StringWriter sw = new StringWriter();
        marshaller.marshal(jaxbElement, sw);

        return sw.toString();
    }
}

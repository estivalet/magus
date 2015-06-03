package sandbox.xml;

import java.io.FileReader;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.sax.SAXSource;

import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

public class DataFileTest2 {

    public static void main(String[] args) throws Exception {

        JAXBContext context = JAXBContext.newInstance(DataFile.class);

        SAXParserFactory spf = SAXParserFactory.newInstance();
        spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
        spf.setFeature("http://xml.org/sax/features/validation", false);
        XMLReader xmlReader = spf.newSAXParser().getXMLReader();
        InputSource inputSource = new InputSource(new FileReader("Nintendo - GameCube (20130305 08-49-35).dat"));
        SAXSource source = new SAXSource(xmlReader, inputSource);

        Unmarshaller um = context.createUnmarshaller();
        DataFile dataFile = (DataFile) um.unmarshal(source);
        System.out.println(dataFile.getHeader().getName());

        List<Game> games = dataFile.getGames();
        for (Game game : games) {
            System.out.println(game.getName() + " " + game.getRom().getSha1());
        }

    }

}

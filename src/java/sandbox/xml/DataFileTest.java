package sandbox.xml;

import java.util.ArrayList;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

public class DataFileTest {

    public static void main(String[] args) throws Exception {
        ArrayList<Game> games = new ArrayList<Game>();

        // Header.
        Header header = new Header();
        header.setName("Nintendo - GameCube");
        header.setDescription("Nintendo - GameCube 20130305 08-49-35");
        header.setVersion("20130305 08-49-35");
        header.setDate("20130305 08-49-35");
        header.setAuthor("redump.org");
        header.setHomepage("redump.org");
        header.setUrl("http://redump.org/");

        // Game
        Game game1 = new Game();
        game1.setName("Resident Evil 4 (USA) (Disc 1)");
        game1.setCategory("Games");
        game1.setDescription("Resident Evil 4 (USA) (Disc 1)");

        Rom rom = new Rom();
        rom.setName("Resident Evil 4 (USA) (Disc 1).iso");
        rom.setSize("1459978240");
        rom.setCrc("f5c51b40");
        rom.setMd5("ca749757e3b9d119f3feb1f9f0f81bd7");
        rom.setSha1("9de89c7f6d8ffb2e27423900a39d4aec1439f4e3");
        game1.setRom(rom);
        games.add(game1);

        // DataFile
        DataFile dataFile = new DataFile();
        dataFile.setHeader(header);
        dataFile.setGames(games);

        // create JAXB context and instantiate marshaller
        JAXBContext context = JAXBContext.newInstance(DataFile.class);
        Marshaller m = context.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

        // Write to System.out
        m.marshal(dataFile, System.out);

    }

}

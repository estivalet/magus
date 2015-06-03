package sandbox.xml;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "datafile")
@XmlAccessorType(XmlAccessType.FIELD)
public class DataFile {

    private Header header;

    @XmlElement(name = "game")
    private List<Game> games;

    /**
     * @return the header
     */
    public Header getHeader() {
        return header;
    }

    /**
     * @param header
     *            the header to set
     */
    public void setHeader(Header header) {
        this.header = header;
    }

    /**
     * @return the games
     */
    public List<Game> getGames() {
        return games;
    }

    /**
     * @param games
     *            the games to set
     */
    public void setGames(List<Game> games) {
        this.games = games;
    }

}

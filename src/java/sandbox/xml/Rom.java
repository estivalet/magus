package sandbox.xml;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;

@XmlAccessorType(XmlAccessType.FIELD)
public class Rom {

    @XmlAttribute
    private String name;

    @XmlAttribute
    private String size;

    @XmlAttribute
    private String crc;

    @XmlAttribute
    private String md5;

    @XmlAttribute
    private String sha1;

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name
     *            the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the size
     */
    public String getSize() {
        return size;
    }

    /**
     * @param size
     *            the size to set
     */
    public void setSize(String size) {
        this.size = size;
    }

    /**
     * @return the crc
     */
    public String getCrc() {
        return crc;
    }

    /**
     * @param crc
     *            the crc to set
     */
    public void setCrc(String crc) {
        this.crc = crc;
    }

    /**
     * @return the md5
     */
    public String getMd5() {
        return md5;
    }

    /**
     * @param md5
     *            the md5 to set
     */
    public void setMd5(String md5) {
        this.md5 = md5;
    }

    /**
     * @return the sha1
     */
    public String getSha1() {
        return sha1;
    }

    /**
     * @param sha1
     *            the sha1 to set
     */
    public void setSha1(String sha1) {
        this.sha1 = sha1;
    }

}

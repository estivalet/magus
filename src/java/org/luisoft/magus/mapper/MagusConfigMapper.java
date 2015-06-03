package org.luisoft.magus.mapper;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.luisoft.magus.domain.Database;
import org.luisoft.magus.domain.MagusConfig;
import org.luisoft.magus.domain.Parameter;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class MagusConfigMapper {

    private MagusConfig mc = new MagusConfig();
    private Document doc;

    public MagusConfigMapper() {
        try {
            InputStream in = this.getClass().getResourceAsStream("/magus.xml");
            DocumentBuilder dBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            this.doc = dBuilder.parse(in);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public MagusConfig fetch() {
        mc.setParameters(fetchAllParameters());
        mc.setDatabases(fetchSupportedDatabases());

        return mc;
    }

    private List<Parameter> fetchAllParameters() {
        List<Parameter> parameters = new ArrayList<Parameter>();

        try {
            XPath xPath = XPathFactory.newInstance().newXPath();
            String expression = "//parameter";
            NodeList nl = (NodeList) xPath.compile(expression).evaluate(doc, XPathConstants.NODESET);

            for (int count = 0; count < nl.getLength(); count++) {
                Node node = nl.item(count);
                String name = node.getAttributes().getNamedItem("name").getNodeValue();
                String value = node.getChildNodes().item(1).getFirstChild().getNodeValue();
                System.out.println(name + " " + value);
                String description = node.getChildNodes().item(3).getFirstChild().getNodeValue();

                Parameter p = new Parameter();
                p.setParameter(name);
                p.setValue(value);
                p.setDescription(description);

                parameters.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return parameters;
    }

    private List<Database> fetchSupportedDatabases() {
        List<Database> databases = new ArrayList<Database>();

        try {
            InputStream in = this.getClass().getResourceAsStream("/magus.xml");
            DocumentBuilder dBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            Document doc = dBuilder.parse(in);

            XPath xPath = XPathFactory.newInstance().newXPath();
            String expression = "//database";
            NodeList nl = (NodeList) xPath.compile(expression).evaluate(doc, XPathConstants.NODESET);

            for (int count = 0; count < nl.getLength(); count++) {
                Node node = nl.item(count);
                String type = node.getAttributes().getNamedItem("type").getNodeValue();
                String connectionImpl = node.getChildNodes().item(1).getFirstChild().getNodeValue();
                String driver = node.getChildNodes().item(3).getFirstChild().getNodeValue();

                Database db = new Database();
                db.setType(type);
                db.setConnectionImpl(connectionImpl);
                db.setDriver(driver);

                databases.add(db);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return databases;
    }

    public static void main(String[] args) {
        MagusConfigMapper pm = new MagusConfigMapper();
        // pm.fetchAllParameters();
        pm.fetchSupportedDatabases();
    }

}

package org.luisoft.magus.domain;

import general.db.annotations.MappedColumn;
import general.db.annotations.MappedTable;

import java.util.ArrayList;
import java.util.List;

import org.luisoft.magus.core.TableWrapper;

@MappedTable(name = "MW_APPLICATION")
public class Application {

    @MappedColumn(name = "id")
    private Long id;

    @MappedColumn(name = "name")
    private String name;

    @MappedColumn(name = "short_name")
    private String shortName;

    @MappedColumn(name = "description")
    private String description;

    @MappedColumn(name = "path")
    private String path;

    @MappedColumn(name = "template")
    private String template;

    @MappedColumn(name = "src_folder")
    private String srcFolder = "/src/main/java/";

    private String testFolder = "/src/test/java/";

    @MappedColumn(name = "java_package")
    private String javaPackage;

    @MappedColumn(name = "user")
    private String user = "defaultUser";

    @MappedColumn(name = "copyright")
    private String copyright = "Copyright (C) 2014 L.F.Estivalet <luiz.f.estivalet@gmail.com>";

    @MappedColumn(name = "license_file")
    private String licenseFile = "/license.ftl";

    @MappedTable(name = "MW_APPLICATION_DATABASE")
    private ApplicationDatabase applicationDatabase;

    private List<TableWrapper> tables = new ArrayList<TableWrapper>();

    /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

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
     * @return the shortName
     */
    public String getShortName() {
        return shortName;
    }

    /**
     * @param shortName
     *            the shortName to set
     */
    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    /**
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * @param path
     *            the path to set
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * @return the srcFolder
     */
    public String getSrcFolder() {
        return srcFolder;
    }

    /**
     * @param srcFolder
     *            the srcFolder to set
     */
    public void setSrcFolder(String srcFolder) {
        this.srcFolder = srcFolder;
    }

    /**
     * @return the javaPackage
     */
    public String getJavaPackage() {
        if (javaPackage == null) {
            return this.shortName;
        }
        return javaPackage;
    }

    /**
     * @param javaPackage
     *            the javaPackage to set
     */
    public void setJavaPackage(String javaPackage) {
        this.javaPackage = javaPackage;
    }

    /**
     * @return the user
     */
    public String getUser() {
        return user;
    }

    /**
     * @param user
     *            the user to set
     */
    public void setUser(String user) {
        this.user = user;
    }

    /**
     * @return the copyright
     */
    public String getCopyright() {
        return copyright;
    }

    /**
     * @param copyright
     *            the copyright to set
     */
    public void setCopyright(String copyright) {
        this.copyright = copyright;
    }

    /**
     * @return the licenseFile
     */
    public String getLicenseFile() {
        return licenseFile;
    }

    /**
     * @param licenseFile
     *            the licenseFile to set
     */
    public void setLicenseFile(String licenseFile) {
        this.licenseFile = licenseFile;
    }

    /**
     * @return the testFolder
     */
    public String getTestFolder() {
        return testFolder;
    }

    /**
     * @param testFolder
     *            the testFolder to set
     */
    public void setTestFolder(String testFolder) {
        this.testFolder = testFolder;
    }

    public void addTable(TableWrapper t) {
        this.tables.add(t);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        // sb.append("<?xml version=\"1.0\"?>\n\n");
        sb.append("<application id=\"" + id + "\" shortName=\"" + shortName + "\">\n");
        sb.append("    <name>" + name + "</name>\n");
        sb.append("    <path>" + path + "</path>\n");
        sb.append("    <template>" + template + "</template>\n");
        if (applicationDatabase != null) {
            sb.append(applicationDatabase);
        }
        if (tables != null) {
            sb.append("    <tables>\n");
            for (TableWrapper tw : tables) {
                sb.append(tw);
            }
            sb.append("    </tables>\n");
        }
        sb.append("</application>");

        return sb.toString();
    }

    /**
     * @return the applicationDatabase
     */
    public ApplicationDatabase getApplicationDatabase() {
        return applicationDatabase;
    }

    /**
     * @param applicationDatabase
     *            the applicationDatabase to set
     */
    public void setApplicationDatabase(ApplicationDatabase applicationDatabase) {
        this.applicationDatabase = applicationDatabase;
    }

    /**
     * @return the template
     */
    public String getTemplate() {
        return template;
    }

    /**
     * @param template
     *            the template to set
     */
    public void setTemplate(String template) {
        this.template = template;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description
     *            the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

}

package org.luisoft.commons.sql.criteria;

public class Column {

    private String name;
    private String value;

    public Column(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return this.name;
    }

    public Object sqlValue(Object value) {
        return this.value;
    }

}

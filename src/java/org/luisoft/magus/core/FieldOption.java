package org.luisoft.magus.core;

public class FieldOption {
    private String value;
    private String text;
    private Integer displayOrder;

    public FieldOption(String value, String text, Integer displayOrder) {
        this.value = value;
        this.text = text;
        this.displayOrder = displayOrder;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

}
package org.luisoft.commons.xml;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAnyElement;

/**
 * http://blog.bdoughan.com/2012/11/creating-generic-list-wrapper-in-jaxb.html
 * 
 * @param <T>
 */
public class XMLWrapper<T> {

    private List<T> items;

    public XMLWrapper() {
        items = new ArrayList<T>();
    }

    public XMLWrapper(List<T> items) {
        this.items = items;
    }

    @XmlAnyElement(lax = true)
    public List<T> getItems() {
        return items;
    }

}

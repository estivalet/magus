<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://java.sun.com/jsf/html">
    <h:body>
        <h1>Novo ${clazz.getAlias(true)}</h1>
        <h:form>
            <fieldset>
                <legend>Dados do ${clazz.getAlias(true)}</legend>
                <h:panelGrid columns="2">
                    <#list allColumns as column><#t>
                    <h:outputLabel value="${column.getAlias()}:" for="${column.getAlias()}" />
                    <h:inputText id="${column.getAlias()}" value="${"#{"}${clazz.getAlias()}Bean.${clazz.getAlias()}.${column.getAlias()}${"}"}"/>
                    </#list>
                    <h:commandButton value="Gravar" action="${"#{"}${clazz.getAlias()}Bean.gravar${"}"}"/>
                </h:panelGrid>
            </fieldset>
        </h:form>
    </h:body>
</html>

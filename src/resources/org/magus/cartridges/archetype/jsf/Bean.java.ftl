<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.bean;

import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import ${app.shortName}.dao.DAO;
import ${app.shortName}.model.${clazz.getAlias(true)};

@ManagedBean
@ViewScoped
public class ${clazz.getAlias(true)}Bean {

    private ${clazz.getAlias(true)} ${clazz.getAlias()} = new ${clazz.getAlias(true)}();
    
    <#assign id="">
    <#list allColumns as column><#t>
    <#if (column.isColumnInPrimaryKey())>
    <#assign id="${column.getAlias()}">
    private ${column.getTypeName()} ${column.getAlias()}${column.getDefaultValue()};
    </#if>
    </#list>
    

    public ${clazz.getAlias(true)} get${clazz.getAlias(true)}() {
        return ${clazz.getAlias()};
    }

    public List<${clazz.getAlias(true)}> get${clazz.getAlias(true)}s() {
        return new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).listaTodos();
    }

    public String gravar() {
        if (this.${clazz.getAlias()}.getId() == null) {
            new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).adiciona(this.${clazz.getAlias()});
        } else {
            new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).atualiza(this.${clazz.getAlias()});
        }

        this.autor = new ${clazz.getAlias(true)}();

        return "livro?faces-redirect=true";
    }

    public void carregar(${clazz.getAlias(true)} ${clazz.getAlias()}) {
        System.out.println("Carregando ${clazz.getAlias()}");
        this.${clazz.getAlias()} = ${clazz.getAlias()};
    }

    public void remover(${clazz.getAlias(true)} ${clazz.getAlias()}) {
        System.out.println("Removendo ${clazz.getAlias()}");
        new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).remove(${clazz.getAlias()});
    }

    public void carregar${clazz.getAlias(true)}PelaId() {
        this.${clazz.getAlias()} = new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).buscaPorId(${id});
    }
    
   <#list allColumns as column><#t>
   <#if (column.isColumnInPrimaryKey())>
    /**
     * @param ${column.getCamelCaseName()}
     *            the ${column.getCamelCaseName()} to set.
     */
    public void set${column.getAlias()?cap_first}(${column.getTypeName()} ${column.getCamelCaseName()}) {
        this.${column.getAlias()} = ${column.getCamelCaseName()};
    }

    /**
     * @return the ${column.getCamelCaseName()}
     */
    public ${column.getTypeName()} get${column.getAlias()?cap_first}() {
        return this.${column.getAlias()};
    }
    </#if>
    </#list>    
}

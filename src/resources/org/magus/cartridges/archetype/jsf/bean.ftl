<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.bean;

import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.caelum.livraria.dao.DAO;
import br.com.caelum.livraria.modelo.Autor;

@ManagedBean
@ViewScoped
public class ${clazz.getAlias(true)}Bean {

    private ${clazz.getAlias(true)} ${clazz.getAlias()} = new ${clazz.getAlias(true)}();
    
    private Integer autorId;

    public ${clazz.getAlias(true)} get${clazz.getAlias(true)}() {
        return ${clazz.getAlias()};
    }

    public List<${clazz.getAlias(true)}> getAutores() {
        return new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).listaTodos();
    }

    public String gravar() {
        System.out.println("Gravando ${clazz.getAlias()} " + this.${clazz.getAlias()}.getNome());

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

    public Integer getAutorId() {
        return autorId;
    }

    public void setAutorId(Integer autorId) {
        this.autorId = autorId;
    }
    
    public void carregar${clazz.getAlias(true)}PelaId() {
        this.${clazz.getAlias()} = new DAO<${clazz.getAlias(true)}>(${clazz.getAlias(true)}.class).buscaPorId(autorId);
    }
}

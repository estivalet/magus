<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.package}.bean;

import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.caelum.livraria.dao.DAO;
import br.com.caelum.livraria.modelo.Autor;

@ManagedBean
@ViewScoped
public class ${clazzDomainName}Bean {

    private ${clazzDomainName} ${objectDomainName} = new ${clazzDomainName}();
    
    private Integer autorId;

    public ${clazzDomainName} get${clazzDomainName}() {
        return ${objectDomainName};
    }

    public List<${clazzDomainName}> getAutores() {
        return new DAO<${clazzDomainName}>(${clazzDomainName}.class).listaTodos();
    }

    public String gravar() {
        System.out.println("Gravando ${objectDomainName} " + this.${objectDomainName}.getNome());

        if (this.${objectDomainName}.getId() == null) {
            new DAO<${clazzDomainName}>(${clazzDomainName}.class).adiciona(this.${objectDomainName});
        } else {
            new DAO<${clazzDomainName}>(${clazzDomainName}.class).atualiza(this.${objectDomainName});
        }

        this.autor = new ${clazzDomainName}();

        return "livro?faces-redirect=true";
    }

    public void carregar(${clazzDomainName} ${objectDomainName}) {
        System.out.println("Carregando ${objectDomainName}");
        this.${objectDomainName} = ${objectDomainName};
    }

    public void remover(${clazzDomainName} ${objectDomainName}) {
        System.out.println("Removendo ${objectDomainName}");
        new DAO<${clazzDomainName}>(${clazzDomainName}.class).remove(${objectDomainName});
    }

    public Integer getAutorId() {
        return autorId;
    }

    public void setAutorId(Integer autorId) {
        this.autorId = autorId;
    }
    
    public void carregar${clazzDomainName}PelaId() {
        this.${objectDomainName} = new DAO<${clazzDomainName}>(${clazzDomainName}.class).buscaPorId(autorId);
    }
}

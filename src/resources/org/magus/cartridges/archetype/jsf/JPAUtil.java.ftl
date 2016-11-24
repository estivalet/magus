<#include app.licenseFile>

/*
 * Created on ${date} by ${app.user}
 */

package ${app.shortName}.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JPAUtil {

    private static EntityManagerFactory emf = Persistence
            .createEntityManagerFactory("livraria");

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void close(EntityManager em) {
        em.close();
    }
}

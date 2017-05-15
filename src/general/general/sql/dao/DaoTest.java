package general.sql.dao;

import java.util.ArrayList;
import java.util.List;

import org.luisoft.magus.domain.Application;

import dbreveng.database.meta.Column;
import general.db.mapper.DatabaseConnecter;
import general.sql.criteria.Criteria;
import general.sql.criteria.Equals;
import test.db.local.HSQLDBDatabaseConnecter;

public class DaoTest {

    public static void main(String[] args) {
        DatabaseConnecter connecter = new HSQLDBDatabaseConnecter();
        List<Application> list = new ArrayList<Application>();
        Dao<Application> dao = new Dao<Application>(Application.class, connecter);

        Column column = new Column();
        column.setName("parameter");
        Criteria criteria = new Equals(column, "folder.paths");

        list = dao.loadAll();
        // list = dao.getListByCriteria(criteria);

        System.out.println(criteria.sqlString());

        for (Application test : list) {
            System.out.println(test.getName());
        }

    }
}

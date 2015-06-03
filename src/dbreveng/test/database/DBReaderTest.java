package test.database;

import dbreveng.DBReader;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.PrimaryKey;
import dbreveng.database.meta.Table;

public class DBReaderTest {

    public static void main(String[] args) throws Exception {
        DBReader dbr = new DBReader();
        dbr.setDbConnectionImplementation("dbreveng.database.impl.hsqldb.HSQLDBDatabaseConnection");
        dbr.readDatabase("org.hsqldb.jdbcDriver", "jdbc:hsqldb:hsql://localhost/magusdb", "sa", "");

        dbr.getDatabase().setCurrentSchema("RBAC");

        Table t = dbr.getDatabase().getCurrentSchema().getTable("USER");
        System.out.println(t);

        for (PrimaryKey pk : t.getPks().values()) {
            System.out.println(pk.getColumn().getName());
        }

        System.out.println(t.hasExportedKeys());

        for (ForeignKey fk : t.getFks().values()) {
            System.out.println("-->" + fk.getFkTableName() + " " + fk.getPkTableName());
            System.out.println("-->" + fk.getFkCamelCaseName(true) + " " + fk.getFkColumnCamelCase(false));
        }

        ForeignKey f0 = (ForeignKey) t.getFks().values().iterator().next();
        System.out.println("xxx--->" + f0.getFkCamelCaseName(true));

        System.out.println(t.getSQLFKsSelect());
    }

}

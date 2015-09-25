package test.database;

import dbreveng.DBReader;
import dbreveng.database.meta.Column;
import dbreveng.database.meta.ForeignKey;
import dbreveng.database.meta.PrimaryKey;
import dbreveng.database.meta.Table;

public class DBReaderTest {

    public static void main(String[] args) throws Exception {
        DBReader dbr = new DBReader();
        dbr.setDbConnectionImplementation("dbreveng.database.impl.hsqldb.HSQLDBDatabaseConnection");
        dbr.readDatabase("org.hsqldb.jdbcDriver", "jdbc:hsqldb:hsql://localhost/magusdb", "sa", "");

        dbr.getDatabase().setCurrentSchema("RECIPE");

        Table t = dbr.getDatabase().getCurrentSchema().getTable("RECEITA");
        System.out.println(t);

        System.out.println("********************************");

        System.out.println("PRIMARY KEYS:");
        for (PrimaryKey pk : t.getPks().values()) {
            System.out.println(pk.getColumn().getName());
        }

        System.out.println("********************************");
        System.out.println("exported keys=" + t.hasExportedKeys());

        for (ForeignKey fk : t.getExportedForeignKey()) {
            System.out.println("zzzzzzzz-------->" + fk.getFkCamelCaseName());
        }

        for (Column c : t.getExportedKeyColumns()) {
            System.out.println(c.getName());
        }

        System.out.println("********************************");
        System.out.println("FKS:");
        for (ForeignKey fk : t.getFks().values()) {
            System.out.println("-->" + fk.getFkTableName() + " " + fk.getPkTableName());
            // System.out.println("-->" + fk.getFkCamelCaseName(true) + " " + fk.getFkColumnCamelCase(false));
        }
        System.out.println("********************************");

        ForeignKey f0 = (ForeignKey) t.getFks().values().iterator().next();
        System.out.println("xxx--->" + f0.getFkCamelCaseName(true));

        System.out.println(t.getSQLFKsSelect());

        System.out.println("---------------------------------------------------");

        ForeignKey fk = (ForeignKey) t.getExportedForeignKey().iterator().next();
        System.out.println(fk.getFkTable().getCamelCaseName());
        for (Column c : fk.getFkTable().getColumns().values()) {
            System.out.println(c.getName());
        }
    }

}

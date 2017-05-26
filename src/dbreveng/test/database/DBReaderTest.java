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
        dbr.getDatabase().setCurrentSchema("LIVRARIA");

        String table = "AUTOR";
        Table t = dbr.getDatabase().getCurrentSchema().getTable(table);
        System.out.println(t);

        for (Column c : t.getColumns(true)) {
            if (c.isColumnInExportedKey()) {
                System.out.println(c.getName() + " " + c.isColumnInExportedKey() + " " + c.getExportedTable().getName() + " " + c.getColumnInExportedKey() + " " + t.getImportedTableOfExportedTable(c.getExportedTable(), c.getColumnInExportedKey()));

                System.out.println(t.getSQLMxN(c.getExportedTable(), c.getColumnInExportedKey()));
            }
        }

        // FIND MxN RELATIONSHIP
        for (Column c : t.getExportedKeyColumns()) {
            System.out.println("\n\n\n\nTABLE REFERENCED BY (M):");
            System.out.println(c.getTable().getName());
            Table t2 = c.getTable();
            for (ForeignKey fk : t2.getFks().values()) {
                if (!fk.getFkColumnName().equals(c.getName())) {
                    System.out.println(fk.getFkColumnName() + " " + fk.getPkTableName());
                }
            }
        }

        System.out.println("\n\n\n\n");

        // TODO SELECT MxN CREATE A METHOD FOR IT SOMEWHERE...
        String select = "SELECT " + t.listColumnsAsCommaSeparated(t, t.getName() + ".");
        String from = " FROM " + dbr.getDatabase().getCurrentSchema().getName() + "." + t.getName();
        String cols = ", ";
        String where = " WHERE ";
        System.out.println("FOREIGN KEYS:");
        for (ForeignKey fk : t.getFks().values()) {
            System.out.println(fk.getFkTableName() + "." + fk.getFkColumnName() + " = " + t.getName() + "." + fk.getPkColumnName());
            where += fk.getFkTableName() + "." + fk.getFkColumnName() + " = " + t.getName() + "." + fk.getPkColumnName();
            Table t2 = dbr.getDatabase().getCurrentSchema().getTable(fk.getFkTableName());
            System.out.println(t2);
            for (ForeignKey fk2 : t2.getFks().values()) {
                if (!fk2.getPkTableName().equals(table)) {
                    from += "," + dbr.getDatabase().getCurrentSchema().getName() + "." + t2.getName();
                    System.out.println(fk2.getPkTableName() + "." + fk2.getPkColumnName());
                    Table t3 = dbr.getDatabase().getCurrentSchema().getTable(fk2.getPkTableName());
                    System.out.println(t3);
                    from += "," + dbr.getDatabase().getCurrentSchema().getName() + "." + t3.getName() + " " + t3.getName();
                    cols += t3.listColumnsAsCommaSeparated(t3, t3.getName() + ".");
                    for (ForeignKey fk3 : t3.getFks().values()) {
                        System.out.println(fk3.getFkTableName() + "." + fk3.getFkColumnName() + " = " + t3.getName() + "." + fk3.getPkColumnName());
                        where += " AND " + fk3.getFkTableName() + "." + fk3.getFkColumnName() + " = " + t3.getName() + "." + fk3.getPkColumnName();
                    }
                }
            }
        }
        System.out.println(select + cols + "\n" + from + "\n" + where);

        System.out.println("\n\n\n\n");

        System.out.println("********************************");

        System.out.println("PRIMARY KEYS:");
        for (PrimaryKey pk : t.getPks().values()) {
            System.out.println(pk.getColumn().getName());
        }

        System.out.println("********************************");
        System.out.println("exported keys=" + t.hasExportedKeys());

        for (ForeignKey fk : t.getExportedForeignKey()) {
            System.out.println("zzzzzzzz-------->" + fk.getFkColumnName());
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

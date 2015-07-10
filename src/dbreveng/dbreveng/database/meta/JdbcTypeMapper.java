package dbreveng.database.meta;

import java.sql.Types;

/**
 * Mapping based on http://java.sun.com/j2se/1.5.0/docs/guide/jdbc/getstart/mapping.html
 * 
 * Should be placed in generator project.
 */
public abstract class JdbcTypeMapper {

    public static String getJavaType(int sqlType) {
        switch (sqlType) {
        case Types.LONGVARCHAR:
        case Types.CHAR:
        case Types.VARCHAR:
            return "String";
        case Types.NUMERIC:
        case Types.DECIMAL:
            return "java.math.BigDecimal";
        case Types.BIT:
        case Types.BOOLEAN:
            return "Boolean";
        case Types.TINYINT:
            return "Byte";
        case Types.SMALLINT:
            return "Short";
        case Types.INTEGER:
            return "Integer";
        case Types.BIGINT:
            return "Long";
        case Types.REAL:
            return "Float";
        case Types.FLOAT:
        case Types.DOUBLE:
            return "Double";
        case Types.BINARY:
        case Types.VARBINARY:
        case Types.LONGVARBINARY:
            return "byte[]";
        case Types.DATE:
            return "java.sql.Date";
        case Types.TIME:
            return "java.sql.Time";
        case Types.TIMESTAMP:
            return "java.sql.Timestamp";
        }
        return null;
    }

    /**
     * Method used mainly for the code generation templates. Based on the type, it returns the name of corresponding method used in PreparedStatement. For example, to set an Integer the method in
     * PreparedStatement is ps.setInt(count, <int to set>).
     * 
     * @param sqlType
     * @return
     */
    public static String getPSJavaMethod(int sqlType) {
        switch (sqlType) {
        case Types.LONGVARCHAR:
        case Types.CHAR:
        case Types.VARCHAR:
            return "String";
        case Types.NUMERIC:
        case Types.DECIMAL:
            return "BigDecimal";
        case Types.BIT:
        case Types.BOOLEAN:
            return "Boolean";
        case Types.TINYINT:
            return "Byte";
        case Types.SMALLINT:
            return "Short";
        case Types.INTEGER:
            return "Int";
        case Types.BIGINT:
            return "Long";
        case Types.REAL:
            return "Float";
        case Types.FLOAT:
        case Types.DOUBLE:
            return "Double";
        case Types.BINARY:
        case Types.VARBINARY:
        case Types.LONGVARBINARY:
            return "Bytes";
        case Types.DATE: // java.sql.Date
            return "Date";
        case Types.TIME: // java.sql.Time
            return "Time";
        case Types.TIMESTAMP: // java.sql.Timestamp
            return "Timestamp";
        }
        return null;
    }

    public static Integer getJavaTypeSize(int sqlType) {
        switch (sqlType) {
        case Types.NUMERIC:
        case Types.DECIMAL:
            return 16;
        case Types.BIT:
            return 1;
        case Types.TINYINT:
            return 8;
        case Types.SMALLINT:
            return 16;
        case Types.INTEGER:
            return 32;
        case Types.BIGINT:
            return 64;
        case Types.REAL:
            return 64;
        case Types.FLOAT:
        case Types.DOUBLE:
            return 64;
        }
        return -1;
    }

}

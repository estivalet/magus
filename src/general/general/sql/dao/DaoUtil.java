package general.sql.dao;

import general.db.annotations.MappedColumn;

import java.lang.reflect.Field;

public class DaoUtil {

	/**
	 * 
	 * Creates a comma-separated-String with the names of the variables in this
	 * class
	 * 
	 * @param usePlaceHolders
	 *            true, if PreparedStatement-placeholders ('?') should be used
	 *            instead of the names of the variables
	 * @param type
	 * @return
	 */
	public static String getColumns(Class<?> type, boolean usePlaceHolders) {
		StringBuilder sb = new StringBuilder();

		boolean first = true;
		/* Iterate the column-names */
		for (Field f : type.getDeclaredFields()) {
			if (first) {
				first = false;
			} else {
				if (f.getAnnotation(MappedColumn.class) != null) {
					sb.append(", ");
				}
			}
			if (usePlaceHolders) {
				sb.append("?");
			} else {
				if (f.getAnnotation(MappedColumn.class) != null) {
					sb.append(f.getAnnotation(MappedColumn.class).name());
				}
			}
		}

		return sb.toString();

	}

}

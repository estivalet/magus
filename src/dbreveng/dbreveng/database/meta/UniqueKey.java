package dbreveng.database.meta;

public class UniqueKey {

	private String name;

	private Column column;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the columnName
	 */
	public Column getColumn() {
		return column;
	}

	/**
	 * @param columnName
	 *            the columnName to set
	 */
	public void setColumn(Column column) {
		this.column = column;
	}

}

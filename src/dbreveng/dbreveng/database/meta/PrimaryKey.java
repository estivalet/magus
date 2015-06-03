package dbreveng.database.meta;

public class PrimaryKey {

	private String name;

	// private String columnName;
	private Column column;

	private Short sequence;

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

	/**
	 * @return the sequence
	 */
	public Short getSequence() {
		return sequence;
	}

	/**
	 * @param sequence
	 *            the sequence to set
	 */
	public void setSequence(Short sequence) {
		this.sequence = sequence;
	}

}

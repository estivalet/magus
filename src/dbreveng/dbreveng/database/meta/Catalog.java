package dbreveng.database.meta;

import java.util.Formatter;
import java.util.TreeMap;

public class Catalog {

	private String name;

	private TreeMap<String, Schema> schemas = new TreeMap<String, Schema>();

	public Catalog(String name) {
		this.name = name;
	}

	public Catalog() {
	}

	public void addSchema(Schema schema) {
		this.schemas.put(schema.getName(), schema);
	}

	public Schema getSchema(String schemaName) {
		return this.schemas.get(schemaName);
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the schemas
	 */
	public TreeMap<String, Schema> getSchemas() {
		return schemas;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		Formatter fmt = new Formatter(sb);
		fmt.format("%nCatalog: %s%n", this.name);

		return sb.toString();
	}
}

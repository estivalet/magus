package org.luisoft.magus.domain;

import java.util.List;

public class MagusConfig {

	/** Supported databases. */
	private List<Database> databases;

	/** Parameters. */
	private List<Parameter> parameters;

	public String getParameter(String parameter) {
		for (Parameter p : this.getParameters()) {
			if (p.getParameter().equals(parameter)) {
				return p.getValue();
			}
		}

		return null;
	}

	public Database getDatabase(String dbType) {
		for (Database db : this.databases) {
			if (db.getType().equals(dbType)) {
				return db;
			}
		}
		return null;
	}

	/**
	 * @return the databases
	 */
	public List<Database> getDatabases() {
		return databases;
	}

	/**
	 * @param databases
	 *            the databases to set
	 */
	public void setDatabases(List<Database> databases) {
		this.databases = databases;
	}

	/**
	 * @return the parameters
	 */
	public List<Parameter> getParameters() {
		return parameters;
	}

	/**
	 * @param parameters
	 *            the parameters to set
	 */
	public void setParameters(List<Parameter> parameters) {
		this.parameters = parameters;
	}

}

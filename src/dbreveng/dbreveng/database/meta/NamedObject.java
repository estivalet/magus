/*
 * DBRevEng - Digital Howler Entertainment
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 * Created on Aug 6, 2009 at 9:54:51 PM by luisoft
 */
package dbreveng.database.meta;

import general.util.StringUtils;

/**
 * @author luisoft
 * 
 */
public abstract class NamedObject {

	protected String name;

	public String getCamelCaseName() {
		return getCamelCaseName(false);
	}

	public String getCamelCaseName(Boolean capitalize) {
		return StringUtils.toCamelCase(this.name, capitalize);
	}

	public String getHumanReadable() {
		return StringUtils.toHumanReadble(this.name);
	}

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

}

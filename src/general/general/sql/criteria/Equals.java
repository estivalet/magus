/*
 * General Tools - Digital Howler Entertainment
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
 * Created on 21/08/2009 at 11:25:10 by 88758559000
 */
package general.sql.criteria;

import dbreveng.database.meta.Column;

/**
 * @author 88758559000
 * 
 */
public class Equals implements Criteria {

	private Column column;

	private Object value;

	public Equals(Column column, Object value) {
		this.column = column;
		this.value = value;
	}

	public String sqlString() {
		return String.format("%s = %s", column.getName(), column
				.sqlValue(value));
	}

}

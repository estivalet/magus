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
 * Created on 21/08/2009 at 11:26:38 by 88758559000
 */
package org.luisoft.commons.sql.criteria;

/**
 * @author 88758559000
 * 
 */
public class Like implements Criteria {

    private Column column;

    private String value;

    public Like(Column column, String value) {
        this.column = column;
        this.value = value;
    }

    public String sqlString() {
        return column.getName() + " like '%" + column.sqlValue(value) + "%'";
    }
}

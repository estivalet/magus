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
 * Created on 21/08/2009 at 11:34:38 by 88758559000
 */
package test.sql.criteria;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import dbreveng.database.meta.Column;
import general.sql.criteria.Criteria;
import general.sql.criteria.Like;

/**
 * @author 88758559000
 * 
 */
public class LikeTest {

	@Test
	public void simple() {
		Column column = new Column();
		column.setName("name");
		Criteria like = new Like(column, "Joe%");
		assertEquals("name like 'Joe%'", like.sqlString());
	}

	public static void main(String[] args) {
		Column column = new Column();
		column.setName("name");
		Criteria like = new Like(column, "Joe%");

		System.out.println(like.sqlString());
	}

}

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
 * Created on Jul 22, 2009 at 11:33:19 PM by luisoft
 */
package test.util;

/**
 * @author luisoft
 *
 */
import static org.junit.Assert.assertEquals;

import java.util.Arrays;
import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import general.util.StringUtils;

@RunWith(Parameterized.class)
public class StringUtilsTester {

	String input;

	String expectedOutcome;

	@Parameterized.Parameters
	public static Collection<String[]> regExValues() {
		return Arrays.asList(new String[][] { { "CAMEL", "camel" },
				{ "CAMEL_CASE", "camelCase" },
				{ "CAMEL_CERTAINLY_CASE", "camelCertainlyCase" }, });
	}

	public StringUtilsTester(String input, String expectedOutcome) {
		this.input = input;
		this.expectedOutcome = expectedOutcome;
	}

	@Test
	public void testConvertToCamelCase() {
		assertEquals(expectedOutcome, StringUtils.toCamelCase(input));
	}

	@Test
	public void testCountChars() {
		assertEquals(3, StringUtils.countChars("c1,c2,c3,c4", ','));
	}

	public static void main(String[] args) {
		System.out.println(StringUtils.repeatChar(',', 5, null));
		System.out.println(StringUtils.repeatChar('*', 5, ","));
		System.out.println(StringUtils.countChars("c1,c2,c3,c4", ','));
	}
}
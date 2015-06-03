/*
 * General Tools - Digital Howler Entertainment
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 */

/*
 * Created on Jul 5, 2009 at 10:42:08 AM by luisoft
 */
package test.util;

import general.util.PropertyLoader;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * @author luisoft
 */
public class PropertyLoaderTester {

	/**
	 * @param args
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		// Creates a property file in current folder.
		String fileName = "test.properties";
		File f1 = new File(fileName);
		f1.createNewFile();
		BufferedWriter bw = new BufferedWriter(new FileWriter(fileName));
		bw.write("database.driver.name = postgresql\n");
		bw.write("database.use.transactions = true\n");
		bw
				.write("database.driver.config = ${database.driver.name}.properties\n");
		bw.close();

		// Creates a second property file that is referenced from the first one.
		fileName = "postgresql.properties";
		File f2 = new File(fileName);
		f2.createNewFile();
		bw = new BufferedWriter(new FileWriter(fileName));
		bw.write("postgresql.property1 = value1\n");
		bw.write("postgresql.property2 = value2\n");
		bw
				.write("postgresql.property3 = ${postgresql.property1} + ${postgresql.property2}\n");
		bw.close();

		// Read first property file.
		PropertyLoader p = new PropertyLoader("test.properties");
		// Add second property file based on the configuration of the first one.
		p.addProperties(p.getProperty("database.driver.config"));

		// Print properties from the first file.
		System.out.println(p.getProperty("database.driver.name"));
		System.out.println(p.getProperty("database.use.transactions"));
		System.out.println(p.getProperty("database.driver.config"));

		// Print properties from the second file.
		System.out.println(p.getProperty("postgresql.property1"));
		System.out.println(p.getProperty("postgresql.property2"));
		System.out.println(p.getProperty("postgresql.property3"));

		// Remove property file from the file system.
		f1.delete();
		f2.delete();
	}
}

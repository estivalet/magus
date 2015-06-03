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
 * Created on Jul 5, 2009 at 10:37:46 AM by luisoft
 */
package general.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;

/**
 * Enhanced property loader. Can use an already defined property name to be
 * replaced in another property. See example below:<br>
 * <code>
 * application.name=GeneralTools
 * application.path=/projects/${application.name}
 * </code>
 * 
 * @author luisoft
 */
public class PropertyLoader {

	/** Store properties. */
	private Properties properties;

	/** String used for prefixing the property. */
	private static final String PREFIX = "${";

	/** String used for post fixing the property; */
	private static final String POSTFIX = "}";

	/**
	 * Create a new PropertyReplacer object.
	 * 
	 * @param pFileName
	 *            File name containing the properties.
	 * @throws IOException
	 *             Problems reading properties file.
	 */
	public PropertyLoader(String pFileName) throws IOException {
		this.properties = new Properties();
		this.readPropertiesFile(PropertyLoader.class.getResourceAsStream("/"
				+ pFileName));
	}

	/**
	 * Read the property file.
	 * 
	 * @param pInputStream
	 *            InputStream to read from.
	 * @throws IOException
	 *             If something goes wrong throw an exception.
	 */
	private void readPropertiesFile(InputStream pInputStream)
			throws IOException {
		this.properties.load(pInputStream);
		pInputStream.close();
		this.replaceProperties();
	}

	/**
	 * Read an additional properties file.
	 * 
	 * @param pFileName
	 *            File name containing the properties.
	 * @throws IOException
	 *             Problems reading properties file.
	 */
	public void addProperties(String pFileName) throws IOException {
		this.readPropertiesFile(PropertyLoader.class.getResourceAsStream("/"
				+ pFileName));
	}

	/**
	 * Get a property.
	 * 
	 * @param pKey
	 *            Key used to retrieve a property.
	 * @return String value of the given key.
	 */
	public String getProperty(String pKey) {
		if (this.properties.getProperty(pKey) == null) {
			// System.out.println("Property " + pKey + " not found!");
			return null;
		}
		return this.properties.getProperty(pKey);
	}

	/**
	 * Set a property.
	 * 
	 * @param pKey
	 *            Key used to retrieve a property.
	 * @param pValue
	 *            Value used to set the property.
	 */
	public void setProperty(String pKey, String pValue) {
		this.properties.put(pKey, pValue);
	}

	/**
	 * Read all properties and check if there is any property value that needs
	 * to be replaced.
	 * 
	 * @throws IOException
	 *             When a property could not be replaced.
	 */
	private void replaceProperties() throws IOException {

		Enumeration<Object> e = this.properties.keys();
		while (e.hasMoreElements()) {
			String key = (String) e.nextElement();
			String value = this.properties.getProperty(key);

			// Check if we find the prefix.
			int preIndex = value.indexOf(PREFIX);
			if (preIndex == -1) {
				// Value does not have a prefix so it doesn't need any
				// replacement.
				continue;
			}

			// We found a prefix. Creates a buffer for replacing property
			// values.
			StringBuffer buffer = new StringBuffer(value);

			// Keep looping until we find no more properties to replace.
			while (preIndex > -1) {

				// Check if we have a post fix in the property value.
				int postIndex = buffer.indexOf(POSTFIX);
				// Calculates the start position just after the prefix used.
				int start = preIndex + PREFIX.length();

				// If the prefix was found in the beginning of the property
				// value.
				if (preIndex == 0) {
					// Extracts the property value that actually is
					// another property key.
					String keyValue = buffer.substring(start, start + postIndex
							- PREFIX.length());
					String propertyValue = this.properties
							.getProperty(keyValue);
					if (propertyValue == null) {
						throw new IOException("Property " + PREFIX + keyValue
								+ POSTFIX + " not defined.");
					}
					// Execute the replacement.
					buffer.replace(preIndex, preIndex + postIndex + 1,
							propertyValue);
				} else {
					// Extracts the property value that actually is
					// another property key.
					String keyValue = buffer.substring(start, postIndex);
					String propertyValue = this.properties
							.getProperty(keyValue);
					if (propertyValue == null) {
						throw new IOException("Property " + keyValue
								+ " not defined.");
					}
					// Execute the replacement.
					buffer.replace(preIndex, postIndex + 1, propertyValue);
				}

				preIndex = buffer.indexOf(PREFIX);
			}

			// Store the replacement in the property object.
			this.properties.put(key, buffer.toString());
		}
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		Enumeration<Object> e = this.properties.keys();
		while (e.hasMoreElements()) {
			String key = (String) e.nextElement();
			String value = this.properties.getProperty(key);
			buffer.append(key + " = " + value
					+ System.getProperty("line.separator"));
		}
		return buffer.toString();
	}
}

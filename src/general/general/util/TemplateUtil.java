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
 * Created on 05/08/2009 at 16:01:41 by 88758559000
 */
package general.util;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 88758559000
 * 
 */
public class TemplateUtil {

	private String templateFullPath;

	private Map<String, String> properties = new HashMap<String, String>();

	/**
	 * 
	 */
	public TemplateUtil(String templateFullPath) {
		this.templateFullPath = templateFullPath;
	}

	public String replace() {
		String template = IOUtil.readFully(TemplateUtil.class
				.getResourceAsStream(templateFullPath));

		for (String key : properties.keySet()) {
			template = template.replaceAll("\\$\\{" + key + "\\}", properties
					.get(key));
		}

		return template;

	}

	public void addProperty(String key, String value) {
		this.properties.put(key, value);
	}
}

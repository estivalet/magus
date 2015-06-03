/*
 * DBRevEng - Digital Howler Entertainment 
 * Copyright (C) 2008 L.F.Estivalet <luizfernando_estivalet@yahoo.com>
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/*
 * Created on Jul 14, 2009 at 6:58:12 PM by luisoft
 */
package dbreveng.database.impl.generic;

import dbreveng.database.DatabaseFactory;
import dbreveng.database.DatabaseInfoDAO;

/**
 * @author luisoft
 * 
 */
public class GenericDatabaseFactory extends DatabaseFactory {

	/* (non-Javadoc)
	* @see dbreveng.database.DatabaseFactory#getDatabaseInfoDAO()
	*/
	@Override
	public DatabaseInfoDAO getDatabaseInfoDAO() {
		return new GenericDatabaseInfoDAO();
	}

}

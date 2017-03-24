/*
 * recipe
 * Copyright (C) 2014 L.F.Estivalet <luiz.f.estivalet@gmail.com>
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
 */

/*
 * Created on Ter, 12 Jul 2016 16:06:05 by defaultUser
 */

package org.luisoft.commons.core;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Mapper {
    private static DataSource ds;

    /** Limit number of rows to return in a query. */
    protected Integer limit;

    /** Skip that many rows before beginning to return rows. */
    protected Integer offset;

    protected Integer totalRecords;

    protected String message;

    public Connection getConnection(String dsn) throws Exception {
        if (ds == null) {
            DataSource ds = (DataSource) new InitialContext().lookup(dsn);
            Mapper.setDataSource(ds);
        }
        return ds.getConnection();
    }

    public static void setDataSource(DataSource dataSource) {
        ds = dataSource;
    }

    /**
     * @return the limit
     */
    public Integer getLimit() {
        return limit;
    }

    /**
     * @param limit
     *            the limit to set
     */
    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    /**
     * @return the offset
     */
    public Integer getOffset() {
        return offset;
    }

    /**
     * @param offset
     *            the offset to set
     */
    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    /**
     * @return the totalRecords
     */
    public Integer getTotalRecords() {
        return totalRecords;
    }

    /**
     * @param offset
     *            the totalRecords to set
     */
    public void setTotalRecords(Integer totalRecords) {
        this.totalRecords = totalRecords;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message
     *            the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }
}

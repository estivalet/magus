package test.db.local;

import general.db.mapper.DatabaseConnecter;
import general.db.mapper.DatabaseSelecter;

import java.util.ArrayList;
import java.util.List;

import org.luisoft.magus.domain.Parameter;

public class Main {

	/**
	 * For testing purposes
	 * 
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		try {

			DatabaseConnecter connecter = new HSQLDBDatabaseConnecter();

			List<Parameter> list = new ArrayList<Parameter>();

			DatabaseSelecter<Parameter> selecter = new DatabaseSelecter<Parameter>(Parameter.class, connecter);

			list = selecter.selectObjects();

			for (Parameter test : list)
				System.out.println(test.getParameter() + " " + test.getValue());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

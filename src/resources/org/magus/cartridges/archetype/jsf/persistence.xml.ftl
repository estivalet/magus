<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://java.sun.com/xml/ns/persistence"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/persistence http://java.sun.com/xml/ns/persistence/persistence_2_0.xsd"
	version="2.0">

	<persistence-unit name="${app.shortName}" transaction-type="RESOURCE_LOCAL">

   		<provider>org.hibernate.ejb.HibernatePersistence</provider>
		<#list app.tables as table><#t>
		<class>${app.shortName}.model.${table.getAlias(true)}</class>
        </#list>
		<properties>
			<property name="javax.persistence.jdbc.driver" value="com.mysql.jdbc.Driver" />
			<property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost/livrariadb" />
			<property name="javax.persistence.jdbc.user" value="root" />
			<property name="javax.persistence.jdbc.password" value="root" />

			<property name="hibernate.hbm2ddl.auto" value="update" />
			<property name="hibernate.show_sql" value="true" />
			<property name="hibernate.dialect" value="org.hibernate.dialect.MySQL5InnoDBDialect" />
		</properties>
	</persistence-unit>

</persistence>
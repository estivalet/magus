<?xml version="1.0" encoding="UTF-8"?>
<classpath>
	<classpathentry kind="src" path="src/java"/>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
    <#list classpath as cp><#t>
	<classpathentry kind="lib" path="${cp}"/>
	</#list>
	<classpathentry kind="output" path="WebContent/WEB-INF/classes"/>
</classpath>
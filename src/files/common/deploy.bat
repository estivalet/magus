set java_home=c:\users\lestivalet\jdk7
set catalina_home=c:\apache-tomcat-7.0.53
\users\lestivalet\apache-maven-3.2.3\bin\mvn compile war:exploded
c:\apache-tomcat-7.0.53\bin\shutdown.bat
c:\apache-tomcat-7.0.53\bin\run.bat
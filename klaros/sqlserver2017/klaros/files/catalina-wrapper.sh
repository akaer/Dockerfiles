#!/bin/sh

(
echo "hibernate.dialect=org.hibernate.dialect.SQLServer2008Dialect";
echo "hibernate.connection.driver_class=com.microsoft.sqlserver.jdbc.SQLServerDriver";
echo "hibernate.connection.url=jdbc:sqlserver://db:1433;databaseName=klaros";
echo "hibernate.connection.username=sa";
echo "hibernate.connection.password=P@ssw0rd";
)> /klaros-data/hibernate.properties

# Wait for SQL Server
sleep 60

/root/klaros-testmanagement/bin/catalina.sh run

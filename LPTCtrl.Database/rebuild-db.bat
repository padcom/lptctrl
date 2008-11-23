@echo off
call isql -q -u SYSDBA -p masterkey LPTCTRL < lptctrl-database-drop.sql
call isql -q < lptctrl-database-create.sql
call isql -q -u SYSDBA -p masterkey LPTCTRL -i lptctrl-tables.sql
call isql -q -u SYSDBA -p masterkey LPTCTRL -i lptctrl-triggers.sql
call isql -q -u SYSDBA -p masterkey LPTCTRL -i lptctrl-data.sql
call isql -q -u SYSDBA -p masterkey LPTCTRL -i lptctrl-data-example.sql

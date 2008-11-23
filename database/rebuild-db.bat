@echo off
call isql -u SYSDBA -p masterkey LPTCTRL < lptctrl-database-drop.sql
call isql < lptctrl-database-create.sql
call isql -u SYSDBA -p masterkey LPTCTRL -i lptctrl-tables.sql
call isql -u SYSDBA -p masterkey LPTCTRL -i lptctrl-triggers.sql
call isql -u SYSDBA -p masterkey LPTCTRL -i lptctrl-data.sql

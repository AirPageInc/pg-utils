\echo Use "CREATE EXTENSION skitch-extension-defaults" to load this file. \quit
ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS  FROM PUBLIC;

DO $$
  DECLARE
  sql text;
BEGIN
select format('REVOKE ALL ON DATABASE %I FROM PUBLIC', current_database()) into sql;
execute sql;
END $$;

REVOKE ALL ON SCHEMA public FROM PUBLIC;
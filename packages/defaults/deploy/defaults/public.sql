-- Deploy skitch-extension-defaults:defaults/public to pg

BEGIN;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;

DO $$
DECLARE
  sql text;
BEGIN
select format('REVOKE ALL ON DATABASE %I FROM PUBLIC', current_database()) into sql;
execute sql;
END $$;

REVOKE ALL ON SCHEMA public FROM PUBLIC;

COMMIT;

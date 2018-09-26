-- Revert skitch-extension-defaults:defaults/public from pg

BEGIN;

ALTER DEFAULT privileges GRANT EXECUTE ON functions
TO public;

GRANT ALL ON SCHEMA public TO PUBLIC;

COMMIT;

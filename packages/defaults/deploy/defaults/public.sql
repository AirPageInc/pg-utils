-- Deploy skitch-extension-defaults:defaults/public to pg

BEGIN;

ALTER DEFAULT privileges REVOKE EXECUTE ON functions
FROM
    public;

REVOKE ALL ON SCHEMA public FROM PUBLIC;

COMMIT;

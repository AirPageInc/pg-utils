-- NOTE: this is generated by skitch, extensions are not actually bundled in final output, just used for testing
-- Revert extensions/app-extensions from pg
BEGIN;

DROP EXTENSION IF EXISTS "pg-utilities";

COMMIT;
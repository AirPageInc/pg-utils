-- Revert procedures/stamp_created_by_column from pg

BEGIN;

DROP FUNCTION stamp_updated_at_column;

COMMIT;

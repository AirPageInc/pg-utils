-- Verify procedures/tg_update_timestamps on pg

BEGIN;

SELECT verify_function('public.stamp_updated_at_column', 'postgres');

ROLLBACK;

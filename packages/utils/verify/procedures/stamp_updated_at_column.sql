-- Verify procedures/stamp_updated_at_column on pg

BEGIN;

SELECT verify_function('public.stamp_updated_at_column', 'postgres');

ROLLBACK;

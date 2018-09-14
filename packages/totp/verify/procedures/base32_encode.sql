-- Verify procedures/base32_encode  on pg

BEGIN;

SELECT verify_function ('public.base32_encode', 'postgres');

ROLLBACK;

-- Revert procedures/base32_encode from pg

BEGIN;

DROP FUNCTION public.base32_encode;

COMMIT;

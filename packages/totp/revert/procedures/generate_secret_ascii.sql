-- Revert procedures/generate_secret_ascii from pg

BEGIN;

DROP FUNCTION public.generate_secret_ascii;

COMMIT;

-- Verify procedures/generate_secret_ascii  on pg

BEGIN;

SELECT verify_function ('public.generateSecretASCII', 'postgres');

ROLLBACK;

-- Verify procedures/list_indexes on pg

BEGIN;

SELECT
    1/count(has_function_privilege('postgres', p.oid, 'execute'))
FROM
    pg_catalog.pg_proc p
    JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
WHERE
    n.nspname = 'public' AND p.proname = 'list_indexes';

ROLLBACK;
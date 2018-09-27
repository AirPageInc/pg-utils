-- Deploy roles/authenticated/role to pg


BEGIN;

DO $$
  BEGIN
    IF NOT EXISTS (
            SELECT
                1
            FROM
                pg_roles
            WHERE
                rolname = 'authenticated') THEN
            CREATE ROLE authenticated;
            COMMENT ON ROLE authenticated IS 'Authenticated group';

            GRANT USAGE ON SCHEMA public TO authenticated;

            GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO authenticated;

            GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO authenticated;

            ALTER DEFAULT PRIVILEGES FOR ROLE authenticated IN SCHEMA public
                GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated;

            ALTER DEFAULT PRIVILEGES FOR ROLE authenticated IN SCHEMA public
                GRANT SELECT, USAGE ON SEQUENCES TO authenticated;

    END IF;
END $$;

COMMIT;

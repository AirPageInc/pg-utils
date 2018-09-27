-- Deploy roles/anonymous/role to pg


BEGIN;

DO $$
  BEGIN
    IF NOT EXISTS (
            SELECT
                1
            FROM
                pg_roles
            WHERE
                rolname = 'anonymous') THEN
            CREATE ROLE anonymous;
            COMMENT ON ROLE anonymous IS 'Anonymous group';

            GRANT USAGE ON SCHEMA public TO anonymous;

            GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO anonymous;

            GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO anonymous;

            ALTER DEFAULT PRIVILEGES FOR ROLE anonymous IN SCHEMA public
                GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO anonymous;

            ALTER DEFAULT PRIVILEGES FOR ROLE anonymous IN SCHEMA public
                GRANT SELECT, USAGE ON SEQUENCES TO anonymous;

    END IF;
END $$;

COMMIT;

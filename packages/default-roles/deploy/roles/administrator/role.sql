-- Deploy roles/administrator/role to pg


BEGIN;

DO $$
  BEGIN
    IF NOT EXISTS (
            SELECT
                1
            FROM
                pg_roles
            WHERE
                rolname = 'administrator') THEN
            CREATE ROLE administrator;
            COMMENT ON ROLE administrator IS 'Administration group';

            GRANT USAGE ON SCHEMA public TO administrator;

            GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO administrator;

            GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO administrator;

            ALTER DEFAULT PRIVILEGES FOR ROLE administrator IN SCHEMA public
                GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO administrator;

            ALTER DEFAULT PRIVILEGES FOR ROLE administrator IN SCHEMA public
                GRANT SELECT, USAGE ON SEQUENCES TO administrator;
    END IF;
END $$;

COMMIT;

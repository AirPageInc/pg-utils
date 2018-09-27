\echo Use "CREATE EXTENSION skitch-extension-default-roles" to load this file. \quit
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
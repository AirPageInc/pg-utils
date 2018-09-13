-- Deploy procedures/stamp_updated_at_column to pg

BEGIN;

CREATE FUNCTION stamp_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    -- cheap way to ensure created_at is immutable
    NEW.created_at = OLD.created_at;

    -- updated_at
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

COMMIT;

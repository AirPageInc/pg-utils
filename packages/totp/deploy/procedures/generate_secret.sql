-- Deploy procedures/generate_secret to pg

-- requires: procedures/generate_secret_ascii
-- requires: procedures/base32_encode

BEGIN;

CREATE FUNCTION generate_secret(
  len int default 32,
  symbols boolean default false
) returns json as $$
DECLARE
  v_secret text;
  v_base32 text;
  v_hex text;
BEGIN
  SELECT
    generate_secret_ascii(len, symbols)
    INTO v_secret;

  SELECT
    encode(v_secret::bytea, 'hex')
    INTO v_hex;

  SELECT
    base32_encode(v_secret)
    INTO v_base32;

  RETURN json_build_object('secret', v_secret, 'hex', v_hex, 'base32', v_base32);
END;
$$
LANGUAGE 'plpgsql' STABLE;

COMMIT;

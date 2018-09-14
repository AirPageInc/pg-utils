\echo Use "CREATE EXTENSION pg-totp" to load this file. \quit
CREATE FUNCTION base32_encode ( input text ) RETURNS text AS $EOFCODE$
DECLARE
  skip int = 0;
  bits int = 0;
  output text = '';
  x int = 0;
  input_length int = length(input);
  byte int;
  alphabet text = '0123456789abcdefghjkmnpqrtuvwxyz';
BEGIN

  WHILE (x < input_length) LOOP
    -- coerce the byte to an int
    byte := ascii(substring(input from x for 1));

    IF (skip < 0) THEN
      -- we have a carry from the previous byte
      bits := bits | (byte >> (-skip));
    ELSE
      -- no carry
      bits := (byte << skip) & 248;
    END IF;

    IF (skip > 3) THEN
      -- not enough data to produce a character, get us another one
      skip := skip - 8;
      x:= x + 1;
    END IF;

    IF (skip < 4) THEN
      -- produce a character
      output := output || substring(alphabet from (bits >> 3) for 1);
      skip := skip + 5;
    END IF;

  END LOOP;

  IF (skip < 0) THEN
    output := output || substring(alphabet from (bits >> 3) for 1);
  END IF;

  RETURN output;
END;
$EOFCODE$ LANGUAGE plpgsql IMMUTABLE;

CREATE FUNCTION generate_secret_ascii ( len int DEFAULT 32, symbols boolean DEFAULT (FALSE) ) RETURNS text AS $EOFCODE$
DECLARE
  v_set text;

  v_bytea bytea;
  v_output text;

  x int;
  y int;
  b_index int;
BEGIN
  v_set = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
  v_output = '';
  v_bytea = gen_random_bytes(len);

  IF (symbols IS NOT NULL) THEN
    v_set = v_set || '!@#$%^&*()<>?/[]{},.:;';
  END IF;

  FOR x IN 0 .. len-1 LOOP
    y := get_byte(v_bytea, x);
    b_index := floor(y/255.0 * (length(v_set)-1));
	  v_output := v_output || substring(v_set from b_index for 1);
  END LOOP;

  RETURN v_output;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION generate_secret ( len int DEFAULT 32, symbols boolean DEFAULT (FALSE) ) RETURNS json AS $EOFCODE$
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
$EOFCODE$ LANGUAGE plpgsql STABLE;
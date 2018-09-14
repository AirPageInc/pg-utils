import {
  createUser,
  getConnections,
  closeConnections,
} from '../../utils';

let db, conn;

describe('totp', () => {
  beforeEach(async () => {
    ({db, conn} = await getConnections());
  });
  afterEach(async () => {
    await closeConnections({db, conn});
  });
  describe('basics', () => {
    it('generate_secret', async () => {
      const secret = await db.one(
        `SELECT * FROM generate_secret(20)`
      );
      console.log(secret);
    });
    it('generate_secret_ascii', async () => {
      const secret = await db.one(
        `SELECT * FROM generate_secret_ascii(20)`
      );
      console.log(secret);
    });
    it('hex', async () => {
      const {base32_encode: secret} = await db.one(
        `SELECT * FROM base32_encode($1)`, [
          'Hello World'
        ]
      );
      console.log(secret);
    });
  });
});

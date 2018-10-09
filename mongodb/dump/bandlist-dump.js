/**
 * Creates pre-filled demo data
 */

print('dump start');

use bandlist;

db.createCollection("band");

db.band.insert(
    {
    "name": "almafuerte",
    "genre": "heavy metal"
    },
    { upsert: true }
);

print('dump complete');

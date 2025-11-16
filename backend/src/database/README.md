# Database Setup

## Quick Start (Neon, Supabase, or Any PostgreSQL)

### Option 1: One-Click Setup (Recommended)

Use the **COMBINED_MIGRATION.sql** file - it contains everything:

1. Go to your database (Neon, Supabase, Vercel Postgres, etc.)
2. Open the SQL query editor
3. Copy the contents of `COMBINED_MIGRATION.sql`
4. Paste and run it
5. Done! ✅

### Option 2: Step-by-Step

Run these files in order:

1. `schema.sql` - Creates all tables
2. `seeds/001_initial_seed.sql` - Adds 78 tarot cards + Rider-Waite deck
3. `seeds/002_card_meanings.sql` - Adds Rider-Waite card meanings
4. `seeds/003_spread_types.sql` - Adds spread types (Single Card, 3-Card, Celtic Cross, etc.)
5. `seeds/004_add_marseille_deck.sql` - Adds Marseille Tarot (78 cards)
6. `seeds/005_add_thoth_deck.sql` - Adds Thoth Tarot (22 Major Arcana)
7. `seeds/006_add_wild_unknown_deck.sql` - Adds Wild Unknown Tarot (22 Major Arcana)
8. `seeds/007_add_modern_witch_deck.sql` - Adds Modern Witch Tarot (22 Major Arcana)

## For Neon Database

### Using Neon's SQL Editor

1. Log into [neon.tech](https://neon.tech)
2. Select your project
3. Click "SQL Editor" in the sidebar
4. Copy contents of `COMBINED_MIGRATION.sql`
5. Paste into the editor
6. Click "Run" or press Cmd/Ctrl + Enter
7. Wait for completion (should take ~5 seconds)

### Using psql (Command Line)

```bash
# Get your connection string from Neon dashboard
export DATABASE_URL="postgresql://user:pass@host.neon.tech/dbname?sslmode=require"

# Run the combined migration
psql $DATABASE_URL -f COMBINED_MIGRATION.sql
```

## For Vercel Postgres

### Using Vercel Dashboard

1. Go to your Vercel project
2. Click Storage → Your Postgres database
3. Click "Query" tab
4. Copy contents of `COMBINED_MIGRATION.sql`
5. Paste and run

### Using Vercel CLI

```bash
# Pull environment variables
vercel env pull .env.local

# Run migration
psql $(grep DATABASE_URL .env.local | cut -d '=' -f2-) -f backend/src/database/COMBINED_MIGRATION.sql
```

## For Supabase

1. Go to [supabase.com](https://supabase.com)
2. Select your project
3. Click "SQL Editor" in the sidebar
4. Click "New Query"
5. Copy contents of `COMBINED_MIGRATION.sql`
6. Paste and run

## Verify Setup

Run this query to verify everything loaded:

```sql
-- Should return 5 decks
SELECT id, name FROM decks ORDER BY id;

-- Should return 78 cards
SELECT COUNT(*) FROM cards;

-- Should return card meanings (varies by deck)
SELECT deck_id, COUNT(*) as card_count
FROM card_meanings
GROUP BY deck_id
ORDER BY deck_id;

-- Should return 8 spread types
SELECT id, name FROM spread_types ORDER BY id;
```

Expected results:
- 5 decks (Rider-Waite, Marseille, Thoth, Wild Unknown, Modern Witch)
- 78 cards (22 Major Arcana + 56 Minor Arcana)
- Card meanings: Deck 1 & 2 have 78 each, Decks 3-5 have 22 each
- 8 spread types

## Troubleshooting

### "relation already exists"

The database already has tables. Either:
- Drop all tables first: `DROP SCHEMA public CASCADE; CREATE SCHEMA public;`
- Or start fresh with a new database

### "permission denied"

Your database user needs CREATE privileges. Check with your database provider.

### Connection timeout

For large migrations on free tiers, try:
1. Run schema.sql first
2. Run each seed file individually
3. Or use psql locally instead of web editors

## File Structure

```
database/
├── README.md                           # This file
├── COMBINED_MIGRATION.sql             # ⭐ All-in-one migration (USE THIS)
├── schema.sql                         # Tables only
├── seeds/
│   ├── 001_initial_seed.sql          # Core cards + Rider-Waite deck
│   ├── 002_card_meanings.sql         # Rider-Waite meanings
│   ├── 003_spread_types.sql          # Spread configurations
│   ├── 004_add_marseille_deck.sql    # Marseille deck (78 cards)
│   ├── 005_add_thoth_deck.sql        # Thoth deck (22 cards)
│   ├── 006_add_wild_unknown_deck.sql # Wild Unknown (22 cards)
│   └── 007_add_modern_witch_deck.sql # Modern Witch (22 cards)
└── db.ts                              # Database connection (backend code)
```

import fs from 'fs';
import path from 'path';
import pool from '../database/db';

async function runMigration() {
  try {
    const migrationPath = path.join(__dirname, 'COMBINED_MIGRATION.sql');
    const sql = fs.readFileSync(migrationPath, 'utf-8');

    console.log('Starting database migration...');

    // Split by semicolons but be careful with multiline statements
    const statements = sql
      .split(';')
      .map(s => s.trim())
      .filter(s => s && !s.startsWith('--'));

    for (const statement of statements) {
      try {
        console.log(`Executing: ${statement.substring(0, 80)}...`);
        await pool.query(statement);
      } catch (error: any) {
        // Ignore "table already exists" errors
        if (error.message && error.message.includes('already exists')) {
          console.log(`  (already exists, skipping)`);
        } else {
          throw error;
        }
      }
    }

    console.log('✅ Migration completed successfully!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Migration failed:', error);
    process.exit(1);
  }
}

runMigration();

-- Incremental update script for StratFlow AI
-- Version: v2
-- Date: 2026-03-16
-- Purpose: Extract JSONB fields into fixed columns for better retrieval performance.

-- 1. Create tasks table
CREATE TABLE IF NOT EXISTS tasks (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  pad_id TEXT REFERENCES weekly_pads(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  status TEXT NOT NULL,
  priority TEXT NOT NULL,
  owner_id TEXT NOT NULL,
  department_id TEXT REFERENCES departments(id) ON DELETE SET NULL,
  visibility TEXT NOT NULL,
  aligned_kr_id TEXT,
  target_weeks JSONB,
  start_date BIGINT,
  due_date BIGINT,
  tags JSONB,
  participant_ids JSONB,
  approver_ids JSONB,
  logs JSONB,
  plan TEXT,
  action TEXT,
  deliverable TEXT
);

-- 2. Create reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  target_type TEXT NOT NULL, -- 'department' or 'user'
  target_id TEXT NOT NULL,
  period_id TEXT NOT NULL,
  date BIGINT NOT NULL,
  content TEXT,
  score INTEGER,
  reviewer TEXT,
  okr_progress JSONB,
  okr_details JSONB,
  pad_entries JSONB
);

-- 3. Create roles table
CREATE TABLE IF NOT EXISTS roles (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  department_id TEXT REFERENCES departments(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  members JSONB
);

-- 4. Add missing columns to weekly_pads
ALTER TABLE weekly_pads ADD COLUMN IF NOT EXISTS owner_id TEXT;
ALTER TABLE weekly_pads ADD COLUMN IF NOT EXISTS type TEXT;

-- 5. Fix strategy table schema
-- The application code expects a 'strategy' table with specific columns, but 01_init.sql created 'strategies' with different columns.
CREATE TABLE IF NOT EXISTS strategy (
  ent_name TEXT PRIMARY KEY REFERENCES enterprises(name) ON DELETE CASCADE,
  mission TEXT,
  vision TEXT,
  customer_issues TEXT,
  employee_issues TEXT,
  company_okrs JSONB
);

-- 6. Fix businesses table schema
-- The application code expects different columns for the businesses table.
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS business_format TEXT;
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS customer_persona TEXT;
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS customer_needs TEXT;
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS surface_product_power TEXT;
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS core_product_power TEXT;

-- Note: We are keeping the old JSONB columns in the original tables for now to avoid breaking changes during migration,
-- but the application will start reading/writing from the new tables.
-- You can drop the old columns later once data migration is verified.
-- ALTER TABLE weekly_pads DROP COLUMN entries;
-- ALTER TABLE departments DROP COLUMN roles;
-- ALTER TABLE departments DROP COLUMN role_members;
-- ALTER TABLE departments DROP COLUMN reviews;
-- ALTER TABLE users DROP COLUMN reviews;

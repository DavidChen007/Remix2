-- Initialization script for StratFlow AI Supabase database

CREATE TABLE IF NOT EXISTS enterprises (
  name TEXT PRIMARY KEY,
  displayName TEXT NOT NULL,
  password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  username TEXT NOT NULL,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  role TEXT NOT NULL,
  department_id TEXT,
  pad_permissions JSONB,
  reviews JSONB,
  system_role_ids JSONB,
  custom_permissions JSONB
);

CREATE TABLE IF NOT EXISTS departments (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  name TEXT NOT NULL,
  manager_name TEXT,
  responsibilities TEXT,
  roles JSONB,
  role_members JSONB,
  attributes TEXT,
  sub_departments JSONB,
  okrs JSONB,
  reviews JSONB
);

CREATE TABLE IF NOT EXISTS processes (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  level INTEGER NOT NULL,
  version TEXT NOT NULL,
  is_active BOOLEAN NOT NULL,
  type TEXT NOT NULL,
  owner TEXT,
  co_owner TEXT,
  objective TEXT,
  nodes JSONB,
  links JSONB,
  history JSONB,
  updated_at BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS strategies (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  year INTEGER NOT NULL,
  content JSONB NOT NULL
);

CREATE TABLE IF NOT EXISTS businesses (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  customer_segments JSONB,
  value_propositions JSONB,
  channels JSONB,
  customer_relationships JSONB,
  revenue_streams JSONB,
  key_resources JSONB,
  key_activities JSONB,
  key_partnerships JSONB,
  cost_structure JSONB,
  updated_at BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS weekly_pads (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  week_id TEXT NOT NULL,
  entries JSONB NOT NULL
);

CREATE TABLE IF NOT EXISTS system_roles (
  id TEXT PRIMARY KEY,
  ent_name TEXT REFERENCES enterprises(name) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  permissions JSONB NOT NULL
);

-- Incremental update script for StratFlow AI
-- Version: v3
-- Date: 2026-03-16
-- Purpose: Add department_id to tasks table for better permission control and default assignment.

ALTER TABLE tasks ADD COLUMN IF NOT EXISTS department_id TEXT REFERENCES departments(id) ON DELETE SET NULL;

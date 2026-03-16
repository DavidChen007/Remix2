-- Incremental update script for StratFlow AI
-- Version: v1
-- Date: 2026-03-16

-- Note: The recent changes involved adding `taskScores` to `KRReview` and `targetWeeks` to `PADEntry`.
-- Since these fields are stored within the existing JSONB columns (`departments.reviews` and `weekly_pads.entries`),
-- no structural schema changes (like ADD COLUMN) are required for the relational tables.
-- The application code handles the new JSON fields gracefully.

-- If you need to backfill existing JSONB data, you could run an UPDATE statement here, for example:
-- UPDATE weekly_pads SET entries = (
--   SELECT jsonb_agg(
--     CASE 
--       WHEN entry->'targetWeeks' IS NULL THEN jsonb_set(entry, '{targetWeeks}', '[]'::jsonb)
--       ELSE entry
--     END
--   )
--   FROM jsonb_array_elements(entries) AS entry
-- );

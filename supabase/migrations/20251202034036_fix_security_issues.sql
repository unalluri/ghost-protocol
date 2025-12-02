/*
  # Fix Security Issues

  1. Removed Unused Indexes
    - Drop `idx_content_posts_content_type` - not being used by queries
    - Drop `idx_content_posts_status` - not being used by queries

  2. Security Improvements
    - Fix mutable search_path vulnerability in `update_updated_at_column` function
    - Add `SET search_path = ''` to prevent search path injection attacks
    
  ## Notes
  - Keeping `idx_content_posts_created_at` and `idx_content_posts_scheduled_date` as they are likely used for ordering and filtering
  - The function security fix prevents potential privilege escalation attacks
*/

-- Drop unused indexes
DROP INDEX IF EXISTS public.idx_content_posts_content_type;
DROP INDEX IF EXISTS public.idx_content_posts_status;

-- Recreate function with secure search_path
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- Update comment
COMMENT ON FUNCTION public.update_updated_at_column() IS 'Automatically updates updated_at timestamp on row update (secure: immutable search_path)';

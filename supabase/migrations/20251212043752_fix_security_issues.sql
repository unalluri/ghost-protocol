/*
  # Fix Security Issues

  1. Changes
    - Drop unused indexes: `idx_content_posts_content_type` and `idx_content_posts_status`
    - Fix function `update_updated_at_column` to have secure search_path
  
  2. Security Improvements
    - Removes unused indexes that add unnecessary overhead
    - Sets explicit search_path on function to prevent search_path hijacking attacks
  
  3. Notes
    - The Auth DB connection strategy must be changed manually in Supabase Dashboard
    - Navigate to: Project Settings > Database > Connection Pooling
    - Change from fixed number to percentage-based allocation
*/

-- Drop unused indexes
DROP INDEX IF EXISTS public.idx_content_posts_content_type;
DROP INDEX IF EXISTS public.idx_content_posts_status;

-- Recreate function with secure search_path
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- Update comment
COMMENT ON FUNCTION public.update_updated_at_column() IS 'Automatically updates updated_at timestamp on row update (secure search_path set)';

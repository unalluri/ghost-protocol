-- Migration: RLS Policies for content_posts
-- Description: Enables Row Level Security with basic open access
-- Created: 2024-01-01

-- Enable Row Level Security
ALTER TABLE public.content_posts ENABLE ROW LEVEL SECURITY;

-- Policy: Allow all operations (no authentication required)
-- Note: This is appropriate for apps without user authentication
-- If you add authentication later, modify this policy accordingly
CREATE POLICY "Allow all operations on content_posts"
  ON public.content_posts
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Optional: If you add authentication later, use these policies instead:
-- 
-- -- Allow authenticated users to view all posts
-- CREATE POLICY "Allow authenticated users to view posts"
--   ON public.content_posts
--   FOR SELECT
--   TO authenticated
--   USING (true);
-- 
-- -- Allow authenticated users to insert posts
-- CREATE POLICY "Allow authenticated users to insert posts"
--   ON public.content_posts
--   FOR INSERT
--   TO authenticated
--   WITH CHECK (true);
-- 
-- -- Allow authenticated users to update posts
-- CREATE POLICY "Allow authenticated users to update posts"
--   ON public.content_posts
--   FOR UPDATE
--   TO authenticated
--   USING (true)
--   WITH CHECK (true);
-- 
-- -- Allow authenticated users to delete posts
-- CREATE POLICY "Allow authenticated users to delete posts"
--   ON public.content_posts
--   FOR DELETE
--   TO authenticated
--   USING (true);

-- Add comment
COMMENT ON TABLE public.content_posts IS 'RLS enabled: Open access policy (modify when adding authentication)';

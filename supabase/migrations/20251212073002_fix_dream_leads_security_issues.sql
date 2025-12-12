/*
  # Fix Security Issues for dream_leads Table

  1. Changes
    - Drop 8 unused indexes on dream_leads table
    - Fix function `update_updated_at_column` to have secure search_path
  
  2. Security Improvements
    - Removes unused indexes that add unnecessary overhead and maintenance cost
    - Sets explicit search_path on function to prevent search_path hijacking attacks
  
  3. Indexes Removed
    - idx_dream_leads_updated_at
    - idx_dream_leads_industry
    - idx_dream_leads_job_title
    - idx_dream_leads_booked_meeting
    - idx_dream_leads_connection_status
    - idx_dream_leads_lead_name
    - idx_dream_leads_company_name
    - idx_dream_leads_status
*/

-- Drop unused indexes on dream_leads table
DROP INDEX IF EXISTS public.idx_dream_leads_updated_at;
DROP INDEX IF EXISTS public.idx_dream_leads_industry;
DROP INDEX IF EXISTS public.idx_dream_leads_job_title;
DROP INDEX IF EXISTS public.idx_dream_leads_booked_meeting;
DROP INDEX IF EXISTS public.idx_dream_leads_connection_status;
DROP INDEX IF EXISTS public.idx_dream_leads_lead_name;
DROP INDEX IF EXISTS public.idx_dream_leads_company_name;
DROP INDEX IF EXISTS public.idx_dream_leads_status;

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

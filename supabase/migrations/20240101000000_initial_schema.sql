-- Migration: Initial Schema for Content Posts
-- Description: Creates the content_posts table with all columns, constraints, and indexes
-- Created: 2024-01-01

-- Create content_posts table
CREATE TABLE IF NOT EXISTS public.content_posts (
  id UUID NOT NULL DEFAULT gen_random_uuid(),
  title VARCHAR(255) NULL,
  content TEXT NOT NULL,
  content_type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'draft',
  source_data JSONB NOT NULL DEFAULT '{}',
  original_content TEXT NULL,
  edit_history JSONB NOT NULL DEFAULT '[]',
  scheduled_date TIMESTAMP WITH TIME ZONE NULL,
  platform VARCHAR(50) NULL,
  tags TEXT[] NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  CONSTRAINT content_posts_pkey PRIMARY KEY (id),
  CONSTRAINT content_posts_content_type_check CHECK (
    content_type IN ('create_post', 'lead_magnet')
  ),
  CONSTRAINT content_posts_status_check CHECK (
    status IN ('draft', 'scheduled', 'published', 'archived')
  )
);

-- Create indexes for performance optimization
CREATE INDEX IF NOT EXISTS idx_content_posts_content_type 
  ON public.content_posts USING BTREE (content_type);

CREATE INDEX IF NOT EXISTS idx_content_posts_status 
  ON public.content_posts USING BTREE (status);

CREATE INDEX IF NOT EXISTS idx_content_posts_created_at 
  ON public.content_posts USING BTREE (created_at DESC);

CREATE INDEX IF NOT EXISTS idx_content_posts_scheduled_date 
  ON public.content_posts USING BTREE (scheduled_date);

-- Add comment to table
COMMENT ON TABLE public.content_posts IS 'Stores content posts with scheduling, status tracking, and version history';

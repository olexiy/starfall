-- Drop existing tables if they exist
DROP TABLE IF EXISTS public.task_lists;
DROP TABLE IF EXISTS public.users;

-- Create users table
CREATE TABLE public.users (
    id UUID REFERENCES auth.users NOT NULL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS) on users table
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Create policy to allow users to read and update their own data
CREATE POLICY "Users can view and update own data" ON public.users
    FOR ALL USING (auth.uid() = id);

-- Create task_lists table
CREATE TABLE public.task_lists (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.users(id) NOT NULL,
    week_start DATE NOT NULL,
    template_id TEXT NOT NULL,
    child_name TEXT NOT NULL,
    tasks JSONB[] NOT NULL DEFAULT '{}',
    notes TEXT,
    stars BOOLEAN[] NOT NULL DEFAULT ARRAY[false, false, false, false, false, false, false],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS) on task_lists table
ALTER TABLE public.task_lists ENABLE ROW LEVEL SECURITY;

-- Create policy to allow users to manage their own task lists
CREATE POLICY "Users can manage own task lists" ON public.task_lists
    FOR ALL USING (auth.uid() = user_id);

-- Create indexes for better query performance
CREATE INDEX task_lists_user_id_idx ON public.task_lists(user_id);
CREATE INDEX task_lists_week_start_idx ON public.task_lists(week_start);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER handle_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER handle_task_lists_updated_at
    BEFORE UPDATE ON public.task_lists
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

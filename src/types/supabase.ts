export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
        }
      }
      task_lists: {
        Row: {
          id: string
          user_id: string
          week_start: string
          template_id: string
          child_name: string
          tasks: Json[]
          notes: string | null
          stars: boolean[]
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          week_start: string
          template_id: string
          child_name: string
          tasks: Json[]
          notes?: string | null
          stars: boolean[]
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          week_start?: string
          template_id?: string
          child_name?: string
          tasks?: Json[]
          notes?: string | null
          stars?: boolean[]
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}

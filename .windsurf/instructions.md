# Project Development Instructions

## Project Overview

Starfall is a children's task list generator that helps parents create and manage weekly task lists. The application generates beautiful, printable PDF documents with customizable task lists featuring different designs for boys and girls.

## Project Architecture

### Core Technologies

- Next.js 14+ (App Router)
- TypeScript (strict mode)
- Tailwind CSS for styling
- shadcn/ui + Radix UI for components
- Supabase for authentication and data storage
- React PDF for document generation
- Zod for form validation
- Playwright for testing

### Project Structure

```
├── app/                  # Next.js app router pages
├── components/
│   ├── layout/          # Layout components (header, footer)
│   ├── sections/        # Page sections (task lists, profile)
│   └── ui/              # Reusable UI components
├── lib/
│   ├── pdf/            # PDF generation logic
│   ├── supabase/       # Supabase client and utilities
│   └── utils/          # Helper functions
├── types/               # TypeScript type definitions
├── styles/             # Global styles and Tailwind config
├── public/             # Static assets (images, icons)
└── tests/              # Playwright E2E tests
```

## Development Standards

### TypeScript Usage

- Enable strict mode in tsconfig.json
- Define interfaces for all data structures including Supabase tables
- Use proper type annotations for API responses and database queries
- Implement proper error handling with custom error types
- Use Zod schemas for form validation and data parsing

### Component Development

1. Create components using the following pattern:

```typescript
'use client';

import * as React from 'react';
import { cn } from '@/lib/utils';

interface TaskListProps {
  className?: string;
  children?: React.ReactNode;
  tasks: Task[];
  onTaskComplete?: (taskId: string) => void;
}

export function TaskList({ 
  className, 
  children, 
  tasks,
  onTaskComplete 
}: TaskListProps) {
  return (
    <div className={cn('space-y-4 p-4', className)}>
      {tasks.map((task) => (
        <TaskItem 
          key={task.id}
          task={task}
          onComplete={onTaskComplete}
        />
      ))}
      {children}
    </div>
  );
}
```

2. Follow these principles:
   - Make components reusable and self-contained
   - Implement proper loading and error states
   - Add proper ARIA attributes for accessibility
   - Ensure responsive design for all screen sizes
   - Include print-specific styles for PDF generation

### Styling Guidelines

1. Use Tailwind CSS with consistent patterns:

```typescript
className={cn(
  'base-styles',
  'responsive-styles md:styles lg:styles',
  'state-styles hover:styles focus:styles',
  'print:styles',
  className
)}
```

2. Follow the Starfall color scheme:

```typescript
colors: {
  primary: '#4F46E5', // Indigo
  secondary: '#10B981', // Emerald
  accent: '#F59E0B', // Amber
  background: '#FFFFFF',
  text: '#111827',
}
```

### Database and API Guidelines

1. Supabase Type Safety:
   - Generate and maintain up-to-date types using Supabase CLI
   - Use RLS policies for data security
   - Implement proper error handling for database operations

2. API Routes:
   - Use Next.js API routes with proper TypeScript types
   - Implement request validation using Zod
   - Handle errors gracefully with proper status codes

### Testing Requirements

1. Write E2E tests for critical paths:

```typescript
test.describe('Task List Generation', () => {
  test('should create a new task list', async ({ page }) => {
    await page.goto('/');
    await page.click('[data-test="create-list"]');
    await page.fill('[data-test="list-name"]', 'Weekly Tasks');
    await page.click('[data-test="save-list"]');
    
    await expect(page.locator('[data-test="list-title"]'))
      .toHaveText('Weekly Tasks');
  });
});
```

2. Test Coverage Requirements:
   - User authentication flows
   - Task list creation and editing
   - PDF generation
   - Responsive design
   - Print layout

## Deployment Guidelines

1. Pre-deployment Checklist:
   - Run type checking: `npm run type-check`
   - Run tests: `npm run test`
   - Build project: `npm run build`
   - Check bundle size: `npm run analyze`

2. Environment Setup:
   - Ensure all required environment variables are set
   - Configure proper Supabase RLS policies
   - Set up proper CORS headers

## Documentation Requirements

1. Code Documentation:
   - Add JSDoc comments for complex functions
   - Document database schema changes
   - Keep README up to date with new features

2. User Documentation:
   - Maintain user guide for task list creation
   - Document PDF generation options
   - Provide troubleshooting guides

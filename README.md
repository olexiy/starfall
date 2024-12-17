# Starfall - Children's Task List Generator

A web application designed to help parents create and manage weekly task lists for their children. Generate beautiful, printable PDF documents with customizable task lists featuring different designs for boys and girls.

## Features

- Create and manage daily and weekly tasks
- Customizable task list templates
- PDF generation for printing
- Progress tracking with stars
- Mobile-friendly interface
- Secure user authentication

## Tech Stack

- Next.js 14+ (App Router)
- TypeScript
- Supabase for authentication and data storage
- React PDF for PDF generation
- Tailwind CSS for styling
- shadcn/ui for UI components
- Zod for form validation

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Copy `.env.local.example` to `.env.local` and fill in your Supabase credentials
4. Run the development server:
   ```bash
   npm run dev
   ```
5. Open [http://localhost:3000](http://localhost:3000) in your browser

## Development

### Prerequisites

- Node.js 18+ 
- npm
- Supabase account

### Environment Variables

Create a `.env.local` file with the following variables:

```
NEXT_PUBLIC_SUPABASE_URL=your-supabase-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

## License

MIT

# PackGuard

**Production packing verification** for warehouse staff. Scan shipping labels, verify product barcodes, block wrong SKUs, capture photo/video evidence, and measure protection impact.

Built with **React · TypeScript · Tailwind CSS · Vite · Supabase-ready**.

## Repository

https://github.com/benz1sa2smanagement-hue/packguard

## Quick start

```bash
git clone https://github.com/benz1sa2smanagement-hue/packguard.git
cd packguard
npm install
npm run dev
```

Works in **demo mode** (localStorage) with sample SKUs:
- KIY-ROLL-250 / 885900100001
- KIY-PULL-1150 / 885900100002
- KIY-KITCHEN-400 / 885900100003

## Environment variables

```env
VITE_SUPABASE_URL=https://YOUR_PROJECT.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_public_key
```

Never put the service_role key in the frontend.

## Connect Supabase

1. Create a project at supabase.com
2. Run `supabase/schema.sql` in the SQL Editor
3. Create Storage bucket `evidence`
4. Enable Auth (Email)
5. Set the two VITE_ env vars on Netlify / local `.env.local`

## Import BigSeller

Orders & Import → upload CSV/XLSX → map columns → Import.

## Test wrong scans

Packing → load ML-260925-001 → scan `999999` → blocked, counted on Dashboard and Error Log.

## Deploy

Netlify: build `npm run build`, publish `dist`, SPA redirect in `netlify.toml`.

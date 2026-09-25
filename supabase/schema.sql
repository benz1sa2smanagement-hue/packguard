-- PackGuard schema — run in Supabase SQL Editor
create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  full_name text not null default '',
  role text not null default 'packer' check (role in ('admin', 'supervisor', 'packer')),
  created_at timestamptz not null default now()
);

create table if not exists public.orders (
  id text primary key,
  tracking text not null,
  package_id text,
  customer text,
  platform text,
  completed boolean not null default false,
  completed_at timestamptz,
  completed_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

create index if not exists orders_tracking_idx on public.orders (tracking);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id text not null references public.orders(id) on delete cascade,
  sku text not null,
  name text not null,
  qty int not null check (qty > 0),
  barcode text,
  unique (order_id, sku)
);

create table if not exists public.scan_events (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('correct', 'wrong_scan', 'order_load', 'complete')),
  order_id text not null references public.orders(id) on delete cascade,
  value text not null,
  expected_sku text,
  expected_barcode text,
  staff_id uuid references public.profiles(id),
  device_id text,
  device_name text,
  created_at timestamptz not null default now()
);

create table if not exists public.evidence_files (
  id uuid primary key default gen_random_uuid(),
  order_id text not null references public.orders(id) on delete cascade,
  type text not null check (type in ('photo', 'video')),
  storage_path text not null,
  public_url text,
  staff_id uuid references public.profiles(id),
  device_id text,
  created_at timestamptz not null default now()
);

create table if not exists public.devices (
  id text primary key,
  name text,
  browser text,
  last_active timestamptz not null default now(),
  user_id uuid references public.profiles(id),
  status text not null default 'online'
);

alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.scan_events enable row level security;
alter table public.evidence_files enable row level security;

create policy "auth all orders" on public.orders for all to authenticated using (true) with check (true);
create policy "auth all order_items" on public.order_items for all to authenticated using (true) with check (true);
create policy "auth all scan_events" on public.scan_events for all to authenticated using (true) with check (true);
create policy "auth all evidence" on public.evidence_files for all to authenticated using (true) with check (true);

-- Выполните один раз в Supabase: SQL Editor → New query → Run
create table if not exists public.boards (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.boards enable row level security;

-- Простой режим: любой, кто знает URL, anon key и ID доски, может читать и писать.
-- Поэтому ID доски лучше сделать длинным и неочевидным (например, "team-7f3k9q2x").
create policy "boards read"   on public.boards for select to anon using (true);
create policy "boards insert" on public.boards for insert to anon with check (true);
create policy "boards update" on public.boards for update to anon using (true) with check (true);

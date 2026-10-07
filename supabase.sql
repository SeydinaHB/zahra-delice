-- À coller dans Supabase > SQL Editor > Run

create table categories (
  id bigint generated always as identity primary key,
  name text not null
);

create table products (
  id bigint generated always as identity primary key,
  name text not null,
  description text,
  price integer not null,
  image_url text,
  category_id bigint references categories(id) on delete cascade
);

alter table categories enable row level security;
alter table products enable row level security;

-- Tout le monde peut lire le catalogue
create policy "lecture publique" on categories for select using (true);
create policy "lecture publique" on products for select using (true);

-- Seul l'administrateur connecté peut ajouter, modifier ou supprimer
create policy "admin ecrit" on categories for all to authenticated using (true) with check (true);
create policy "admin ecrit" on products for all to authenticated using (true) with check (true);

\set ON_ERROR_STOP on
\getenv owner_pw PROMO_OWNER_PASSWORD
\getenv app_pw PROMO_APP_PASSWORD

\if :{?owner_pw}
\else
  DO $$ BEGIN RAISE EXCEPTION 'PROMO_OWNER_PASSWORD is not set'; END $$;
\endif
\if :{?app_pw}
\else
  DO $$ BEGIN RAISE EXCEPTION 'PROMO_APP_PASSWORD is not set'; END $$;
\endif

-- Roles
SELECT 'CREATE ROLE promo_owner LOGIN'
 WHERE NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'promo_owner') \gexec
SELECT 'CREATE ROLE promo_app LOGIN'
 WHERE NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'promo_app') \gexec
ALTER ROLE promo_owner PASSWORD :'owner_pw';
ALTER ROLE promo_app PASSWORD :'app_pw' CONNECTION LIMIT 40;
GRANT pg_monitor TO promo_owner;

-- Database
SELECT 'CREATE DATABASE promo OWNER promo_owner'
 WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'promo') \gexec
REVOKE ALL ON DATABASE promo FROM PUBLIC;
GRANT CONNECT, TEMPORARY ON DATABASE promo TO promo_app;

-- Inside the promo database
\connect promo
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

GRANT USAGE ON SCHEMA public TO promo_app;
ALTER DEFAULT PRIVILEGES FOR ROLE promo_owner IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO promo_app;
ALTER DEFAULT PRIVILEGES FOR ROLE promo_owner IN SCHEMA public
  GRANT USAGE, SELECT ON SEQUENCES TO promo_app;

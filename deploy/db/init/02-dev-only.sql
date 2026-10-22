-- Dev only: a disposable database for integration tests.
-- Tests run migrations from scratch here as promo_owner.
\set ON_ERROR_STOP on
SELECT 'CREATE DATABASE promo_test OWNER promo_owner'
 WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'promo_test') \gexec

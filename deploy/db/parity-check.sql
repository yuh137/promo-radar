\pset footer off
SELECT version();
SELECT datname, datlocprovider, datlocale, datcollate, datctype,
       pg_encoding_to_char(encoding) AS encoding
  FROM pg_database WHERE datname IN ('promo', 'template1') ORDER BY datname;
SELECT name, setting, unit FROM pg_settings
 WHERE lower(name) IN ('timezone', 'log_timezone', 'shared_preload_libraries', 'work_mem',
                'effective_cache_size', 'random_page_cost', 'data_checksums',
                'password_encryption', 'shared_buffers', 'idle_in_transaction_session_timeout')
 ORDER BY name;
SELECT extname, extversion FROM pg_extension ORDER BY extname;
SELECT rolname, rolsuper, rolconnlimit FROM pg_roles WHERE rolname LIKE 'promo%' OR rolname = 'postgres' ORDER BY 1;
SELECT upper('phở bò đà lạt') AS upper_vi,
       unaccent('Phở Bò Đà Lạt') AS unaccented,
       round(similarity('pho bo', 'pho bo da lat')::numeric, 3) AS trgm;
SELECT 'Đà Nẵng' < 'Zoo' AS codepoint_order,
       'Đà Nẵng' < 'Zoo' COLLATE "vi-x-icu" AS vietnamese_order;
SELECT left(uuidv7()::text, 8) AS uuidv7_prefix, now()::date AS today;

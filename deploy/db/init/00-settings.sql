\set ON_ERROR_STOP on

ALTER SYSTEM SET timezone = 'Asia/Ho_Chi_Minh';
ALTER SYSTEM SET log_timezone = 'Asia/Ho_Chi_Minh';

ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';
ALTER SYSTEM SET track_io_timing = on;

ALTER SYSTEM SET log_line_prefix = '%m [%p] %q%u@%d %a ';
ALTER SYSTEM SET log_min_duration_statement = '250ms';
ALTER SYSTEM SET log_lock_waits = on;
ALTER SYSTEM SET log_temp_files = 0;

ALTER SYSTEM SET idle_in_transaction_session_timeout = '5min';

ALTER SYSTEM SET work_mem = '16MB';
ALTER SYSTEM SET effective_cache_size = '4GB';
ALTER SYSTEM SET random_page_cost = 1.1;

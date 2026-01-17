CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time       TIMESTAMP;
    end_time         TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time   TIMESTAMP;
BEGIN
    batch_start_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    -- ========================================================================
    -- CRM tables
    RAISE NOTICE 'Loading CRM Tables';

    -- CRM customer info
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_cust_info;

    COPY bronze.crm_cust_info
    FROM 'C:/sql/dwh_project/datasets/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'crm_cust_info load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    -- CRM product info
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_prd_info;

    COPY bronze.crm_prd_info
    FROM 'C:/sql/dwh_project/datasets/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'crm_prd_info load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    -- CRM sales details
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_sales_details;

    COPY bronze.crm_sales_details
    FROM 'C:/sql/dwh_project/datasets/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'crm_sales_details load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    -- ========================================================================
    -- ERP tables
    RAISE NOTICE 'Loading ERP Tables';

    -- ERP location
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_loc_a101;

    COPY bronze.erp_loc_a101
    FROM 'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'erp_loc_a101 load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    -- ERP customer
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_cust_az12;

    COPY bronze.erp_cust_az12
    FROM 'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'erp_cust_az12 load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    -- ERP product category
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    COPY bronze.erp_px_cat_g1v2
    FROM 'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv'
    WITH (FORMAT csv, HEADER true);

    end_time := clock_timestamp();
    RAISE NOTICE 'erp_px_cat_g1v2 load time: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));

    batch_end_time := clock_timestamp();

    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Bronze load completed';
    RAISE NOTICE 'Total duration: % seconds',
        EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
    RAISE NOTICE '==========================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR during bronze load: %', SQLERRM;
        RAISE;
END;
$$;

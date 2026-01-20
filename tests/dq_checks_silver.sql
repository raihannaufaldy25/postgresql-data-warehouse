-- ============================================================
-- silver.crm_cust_info

-- Duplicate or NULL primary keys
SELECT cust_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cust_id
HAVING COUNT(*) > 1 OR cust_id IS NULL;

-- Unwanted spaces
SELECT cust_key
FROM silver.crm_cust_info
WHERE cust_key <> TRIM(cust_key);

-- Standardization check
SELECT DISTINCT cust_marital_status
FROM silver.crm_cust_info;

-- ============================================================
-- silver.crm_prd_info
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ============================================================
-- silver.crm_sales_details
-- Invalid raw dates (bronze)
SELECT sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
   OR LENGTH(sls_due_dt::TEXT) != 8
   OR sls_due_dt > 20500101
   OR sls_due_dt < 19000101;

-- Invalid date order
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Sales consistency
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0;

-- ============================================================
-- silver.erp_cust_az12
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate < DATE '1924-01-01'
   OR bdate > CURRENT_DATE;

SELECT DISTINCT gen
FROM silver.erp_cust_az12;

-- ============================================================
-- silver.erp_loc_a101
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ============================================================
-- silver.erp_px_cat_g1v2
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat <> TRIM(cat)
   OR subcat <> TRIM(subcat)
   OR maintenance <> TRIM(maintenance);

SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;

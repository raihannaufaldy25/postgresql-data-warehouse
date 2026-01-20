-- ====================================================================
-- gold.dim_customers

-- Check uniqueness of customer surrogate key
-- Expectation: 0 rows
SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- gold.dim_products

-- Check uniqueness of product surrogate key
-- Expectation: 0 rows
SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- gold.fact_sales

-- Check referential integrity between fact and dimensions
-- Expectation: 0 rows (no orphan facts)
SELECT
    f.*
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE c.customer_key IS NULL
   OR p.product_key IS NULL;

-- =========================================
-- Procurement Supplier Concentration Analysis
-- =========================================

-- Step 0: Create analytical base table
CREATE TABLE procurement_base AS
SELECT
    c.main_ocid,
    m.buyer_name,
    s.name AS supplier_name,
    c.value_amount AS contract_value
FROM contracts c
JOIN awards a
    ON c.awardID = a.id
JOIN awards_suppliers s
    ON a.id = s.awards_id
JOIN main m
    ON c.main_ocid = m.ocid;


-- =========================================
-- Final Analysis: Top Supplier per Agency + Dominance Level
-- =========================================

-- Step 1–6 combined:
-- - Aggregate supplier totals
-- - Calculate agency totals
-- - Compute supplier share
-- - Identify max share per agency
-- - Match to get top supplier
-- - Classify dominance

SELECT 
    t.buyer_name,
    t.supplier_name,
    t.share,
    CASE
        WHEN t.share > 0.60 THEN 'High'
        WHEN t.share >= 0.30 THEN 'Medium'
        ELSE 'Low'
    END AS dominance_level
FROM 
    (
        SELECT
            s.buyer_name,
            s.supplier_name,
            s.supplier_value,
            a.total_value,
            s.supplier_value / a.total_value AS share
        FROM
            (
                SELECT
                    buyer_name,
                    supplier_name,
                    SUM(contract_value) AS supplier_value
                FROM procurement_base
                WHERE supplier_name <> ''
                GROUP BY buyer_name, supplier_name
            ) s
        JOIN
            (
                SELECT
                    buyer_name,
                    SUM(contract_value) AS total_value
                FROM procurement_base
                WHERE supplier_name <> ''
                GROUP BY buyer_name
            ) a
        ON s.buyer_name = a.buyer_name
    ) t
JOIN
    (
        SELECT
            buyer_name,
            MAX(share) AS max_share
        FROM
            (
                SELECT
                    s.buyer_name,
                    s.supplier_name,
                    s.supplier_value,
                    a.total_value,
                    s.supplier_value / a.total_value AS share
                FROM
                    (
                        SELECT
                            buyer_name,
                            supplier_name,
                            SUM(contract_value) AS supplier_value
                        FROM procurement_base
                        WHERE supplier_name <> ''
                        GROUP BY buyer_name, supplier_name
                    ) s
                JOIN
                    (
                        SELECT
                            buyer_name,
                            SUM(contract_value) AS total_value
                        FROM procurement_base
                        WHERE supplier_name <> ''
                        GROUP BY buyer_name
                    ) a
                ON s.buyer_name = a.buyer_name
            ) m
        GROUP BY buyer_name
    ) max_table
ON t.buyer_name = max_table.buyer_name
AND t.share = max_table.max_share;

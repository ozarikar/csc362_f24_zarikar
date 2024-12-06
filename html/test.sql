SELECT 
    p.product_id,
    p.product_name,
    pb.product_brand_name,
    GROUP_CONCAT(DISTINCT pl.product_length ORDER BY pl.product_length ASC) AS product_lengths,
    GROUP_CONCAT(DISTINCT ps.product_size ORDER BY ps.product_size ASC) AS product_sizes
FROM 
    products p
LEFT JOIN 
    product_brands pb ON p.product_brand_id = pb.product_brand_id
LEFT JOIN 
    products_length pl ON p.product_id = pl.product_id
LEFT JOIN 
    products_size ps ON p.product_id = ps.product_id
GROUP BY 
    p.product_id, p.product_name, pb.product_brand_name;

SELECT * from product_size
SELECT
        p.product_id,
        p.product_name,
        p.product_sale_price,
        p.product_description,
        p.product_warranty_length,
        pb.product_brand_name,
        pc.product_category_name,
        p.product_discontinued,
        p.product_discount_pct,
        GROUP_CONCAT(DISTINCT pl.product_length ORDER BY pl.product_length ASC) AS product_lengths,
        GROUP_CONCAT(DISTINCT ps.product_size ORDER BY ps.product_size ASC) AS product_sizes,
        GROUP_CONCAT(DISTINCT pss.product_shoe_size ORDER BY pss.product_shoe_size ASC) AS product_shoe_sizes,
        GROUP_CONCAT(DISTINCT pcap.product_capacity ORDER BY pcap.product_capacity ASC) AS product_capacities
    FROM
        products p
    LEFT JOIN
        product_brands pb ON p.product_brand_id = pb.product_brand_id
    LEFT JOIN
        product_categories pc ON p.product_category_id = pc.product_category_id
    LEFT JOIN
        products_length pl ON p.product_id = pl.product_id
    LEFT JOIN
        products_size ps ON p.product_id = ps.product_id
    LEFT JOIN
        products_shoe_size pss ON p.product_id = pss.product_id
    LEFT JOIN
        products_capacity pcap ON p.product_id = pcap.product_id
    GROUP BY
        p.product_id, p.product_name, p.product_sale_price, p.product_description,
        p.product_warranty_length, pb.product_brand_name, pc.product_category_name,
        p.product_discontinued, p.product_discount_pct";
    
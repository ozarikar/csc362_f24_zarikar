<?php
$config = parse_ini_file('/home/omkarzarikar/mysql.ini');
$dbname = 'upward_outfitters';
$conn = new mysqli(
    $config['mysqli.default_host'],
    $config['mysqli.default_user'],
    $config['mysqli.default_pw'],
    $dbname
);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

//  Retrieve the Product Data
$products = getProducts($conn); 

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Catalog</title>
</head>
<body>
    <h1>Product Catalog</h1>

    <!--  Product Category Filter -->
    <form method="GET" action="">
        <label for="category">Filter by Category:</label>
        <select name="category" id="category">
            <option value="">All Categories</option>
            <?php
            // Get categories from the database
            $categories = getCategories($conn); 
            foreach ($categories as $category) {
                echo '<option value="' . htmlspecialchars($category['id']) . '">' . htmlspecialchars($category['name']) . '</option>';
            }
            ?>
        </select>
        <button type="submit">Filter</button>
    </form>


    <div class="product-list">
        <?php
        if (!empty($products)) {
            foreach ($products as $product) {
                // Filter by selected category if necessary
                if (!empty($_GET['category']) && $_GET['category'] != $product['category_id']) {
                    continue;
                }

                echo '<div class="product-item">';
                echo '<h2>' . htmlspecialchars($product['name']) . '</h2>';
                echo '<p>Price: $' . htmlspecialchars($product['sale_price']) . '</p>';
                echo '<p>' . htmlspecialchars($product['description']) . '</p>';
                echo '<p>Warranty Length: ' . htmlspecialchars($product['warranty_length']) . ' months</p>';
                echo '</div>';
            }
        } else {
            echo '<p>No products available.</p>';
        }
        ?>
    </div>
</body>
</html>

<?php

// Function to retrieve products from the database
function getProducts($conn) {
    $sql = "SELECT * FROM products";
    $result = $conn->query($sql);

    $products = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $products[] = [
                'id' => $row['product_id'],
                'name' => $row['product_name'],
                'sale_price' => $row['product_sale_price'],
                'description' => $row['product_description'],
                'warranty_length' => $row['product_warranty_length'],
                'category_id' => $row['product_category_id'],
            ];
        }
    }
    return $products;
}

// Function to retrieve categories from the database
function getCategories($conn) {
    $sql = "SELECT * FROM product_categories";
    $result = $conn->query($sql);

    $categories = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $categories[] = [
                'id' => $row['product_category_id'],
                'name' => $row['product_category_name'],
            ];
        }
    }
    return $categories;
}

// Close the database connection
$conn->close();
?>

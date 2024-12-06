<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>
    <!-- Include Navigation Bar function php-->
    <?php 
    require 'navbar.php'; 
    ?>


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

//Retrieve the Product Data
$products = getProducts($conn); 

//  Display Products
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Product Catalog</title> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP and Bootstrap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<?php   show_navbar($conn);   ?>
    <h1>Product Catalog</h1>

    <!--  Product Category Filter -->
    <form method="GET" action="">
        <label for="category">Filter by Category:</label>
        <select name="category" id="category">
            <option value="">All Categories</option>
            <?php
            // Get categories from the database
            foreach ($categories as $category) {
                echo '<option value="' . htmlspecialchars($category['id']) . '">' . htmlspecialchars($category['name']) . '</option>';
            }
            ?>
        </select>
        <button type="submit">Filter</button>
    </form>

    <!-- Display Products in a Table with Add to Cart Option -->
    <form method="POST" action="cart.php">
        <table border="1" cellpadding="10" cellspacing="0">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Warranty Length (Months)</th>
                    <th>product_length</th>
                    <th>Quantity</th>
                    <th>Select</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (!empty($products)) {
                    foreach ($products as $product) {
                        // Filter by selected category if necessary
                        if (!empty($_GET['category']) && $_GET['category'] != $product['category_id']) {
                            continue;
                        }

                        echo '<tr>';
                        echo '<td>' . htmlspecialchars($product['name']) . '</td>';
                        echo '<td>$' . htmlspecialchars($product['sale_price']) . '</td>';
                        echo '<td>' . htmlspecialchars($product['description']) . '</td>';
                        echo '<td>' . htmlspecialchars($product['warranty_length']) . '</td>';
                        if($product['product_length'] !== null){
                            echo '<td>' . htmlspecialchars($product['product_length']) . '</td>';
                        }
                        echo '<td><input type="number" name="quantity[' . htmlspecialchars($product['id']) . ']" min="1" value="1"></td>';
                        echo '<td><input type="checkbox" name="product_ids[]" value="' . htmlspecialchars($product['id']) . '"></td>';
                        echo '</tr>';
                    }
                } else {
                    echo '<tr><td colspan="6">No products available.</td></tr>';
                }
                ?>
            </tbody>
        </table>
        <button type="submit">Add to Cart</button>
    </form>
</body>
</html>

<?php

// Function to retrieve products from the database
function getProducts($conn) {
    $sql = "
        SELECT 
            p.product_id, 
            p.product_name, 
            p.product_sale_price, 
            p.product_description, 
            p.product_warranty_length, 
            p.product_category_id,
            pl.product_length,
            pc.product_capacity,
            psz.product_size
        FROM 
            products p
        LEFT JOIN 
            products_length pl ON p.product_id = pl.product_id
        LEFT JOIN 
            products_capacity pc ON p.product_id = pc.product_id
        LEFT JOIN 
            products_size psz ON p.product_id = psz.product_id
        GROUP BY 
            p.product_id
    ";
   
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
                'product_size' => $row['product_size'],
                'product_length' => $row['product_length'],
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

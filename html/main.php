<?php
// Include database connection
require_once 'db_connection.php';

// Function to retrieve products with optional category filtering
function getProducts($category = null) {
    global $conn;
    
    // SQL query to retrieve products with optional category filtering
    $sql = "SELECT p.id, p.name, p.price, p.description, c.category_name 
            FROM products p
            LEFT JOIN product_categories c ON p.category_id = c.id";
    
    if ($category) {
        $sql .= " WHERE c.category_name = ?";
    }
    
    $stmt = $conn->prepare($sql);
    if ($category) {
        $stmt->bind_param('s', $category);
    }
    
    $stmt->execute();
    $result = $stmt->get_result();
    
    $products = [];
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    
    return $products;
}

// Retrieve category from GET request if available
$category = isset($_GET['category']) ? $_GET['category'] : null;

// Get the list of products
$products = getProducts($category);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Catalog</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Product Catalog</h1>
    
    <form method="GET" action="">
        <label for="category">Filter by Category:</label>
        <select name="category" id="category">
            <option value="">All</option>
            <?php
            // Fetch distinct categories for the dropdown
            $categorySql = "SELECT DISTINCT category_name FROM product_categories";
            $categoryResult = $conn->query($categorySql);
            while ($catRow = $categoryResult->fetch_assoc()) {
                $selected = ($category == $catRow['category_name']) ? 'selected' : '';
                echo "<option value='" . htmlspecialchars($catRow['category_name']) . "' $selected>" . htmlspecialchars($catRow['category_name']) . "</option>";
            }
            ?>
        </select>
        <button type="submit">Filter</button>
    </form>

    <div class="product-list">
        <?php if (count($products) > 0): ?>
            <?php foreach ($products as $product): ?>
                <div class="product">
                    <h2><?php echo htmlspecialchars($product['name']); ?></h2>
                    <p>Price: $<?php echo htmlspecialchars($product['price']); ?></p>
                    <p>Description: <?php echo htmlspecialchars($product['description']); ?></p>
                    <p>Category: <?php echo htmlspecialchars($product['category_name']); ?></p>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p>No products available.</p>
        <?php endif; ?>
    </div>
</body>
</html>

<?php
// Close the database connection
$conn->close();
?>

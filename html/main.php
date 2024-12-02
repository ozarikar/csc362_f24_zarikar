<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        a {
            text-decoration: none;
            font-size: 1.2em;
            color: #ffffff;
            background-color: #007bff;
            padding: 15px 30px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Management Dashboard</h1>
        <div class="nav-links">
            <a href="inventory.php">Inventory Management</a>
            <a href="partners.php">Partner Management</a>
            <a href="transactions.php">Transactions</a>
        </div>
    </div>
</body>
</html>

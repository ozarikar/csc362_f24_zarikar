<?php
    // Show all errors from the PHP interpreter.
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Show all errors from the MySQLi Extension.
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);  

    $dbhost = 'localhost';
    $dbuser = 'omkarzarikar'; // Hard-coding credentials directly in code is not ideal: (1) we might have to 
    $dbpass = '631163';       // change them in multiple places, and (2) this creates security concerns. 
    $conn = new mysqli($dbhost, $dbuser, $dbpass);

    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    } 
    else {
        echo "Connected Successfully!" . "<br>";
        echo "YAY!" . "<br>";
    }

    $dblist = "SHOW databases";
    $result = $conn->query($dblist);

    while ($dbname = $result->fetch_array()) {
        echo "<li>" .$dbname['Database'] . "</li>";
    }
    $conn->close();
?>

<form action="details.php" method="post">
    <label for="database"> database:</label>
    <input name="database" id="database" type="text">
    <button type="submit">Submit</button>
</form>



<h2>Check back soon!</h2>

<!DOCTYPE html>
<html>
<head>
    <title>Databases Available</title>
</head>
<body>
    <h1>Databases Available</h1>

</body>
</html>

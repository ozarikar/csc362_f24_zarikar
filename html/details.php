<?php
    // Show all errors from the PHP interpreter.
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Show all errors from the MySQLi Extension.
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);  

    $dbhost = 'localhost';
    $dbuser = 'omkarzarikar';  
    $dbpass = '631163';
    $database = $_POST['database']; 
$conn = new mysqli($dbhost, $dbuser, $dbpass,$database);

if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    } else {
        echo "Connected Successfully!" . "<br>";
    }

    $tblist = "SHOW TABLES";
    $result = $conn->query($tblist);
    echo "<ul>";
    while ($tbname = $result->fetch_array()) {
        echo   "<li>" .$tbname[0]. "</li>";
    }
    echo "</ul>";
    $conn->close();
?>

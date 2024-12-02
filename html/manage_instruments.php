<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>


<?php

function result_to_html_table($result) {
        $qryres = $result->fetch_all();
        $n_rows = $result->num_rows;
        $n_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <!-- Using default action (this page). -->
        <form method="POST">
        <table>
        <thead>
        <tr>
        <td><b>Delete?</b></td>    
        <?php for ($i=0; $i<$n_cols; $i++){ ?>
            <td><b><?php echo $fields[$i]->name; ?></b></td>
        <?php } ?>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$n_rows; $i++){ ?>
            <?php $id = $qryres[$i][0]; ?>
            <tr>
            <td><input type="checkbox" name="checkbox<?php echo $id;?>" value="<?php echo $id;?>" /></td>     
            <?php for($j=0; $j<$n_cols; $j++){ ?>
                <td><?php echo $qryres[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>
         <!-- submit button input -->
        <p><input type="submit" name="delbtn" value="Delete Selected Records" /></p>
         </form>
<?php } ?>

<?php
    $sql_location = '/home/omkarzarikar/csc362_f24_zarikar/html/';
    $conn = new mysqli( 'localhost', 'omkarzarikar', '631163', 'instrument_rentals');    // 1
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    $sel_tbl = file_get_contents($sql_location . 'select_instruments.sql');   // 2
    $result = $conn->query($sel_tbl);   // 3
    result_to_html_table($result);      // 4
?>

<!-- HTML Form for adding records -->
<form method="POST">
    <input type="submit" name="add_records" value="Add extra records" />
</form>

<?php
// Add form with button to add records
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_records'])) {
    // Load SQL command for adding instruments
    $add_sql = file_get_contents('/home/omkarzarikar/csc362_f24_zarikar/html/add_instruments.sql');
    $conn->query($add_sql);

    // Redirect to avoid duplicate submission
    header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
    exit();
}
?>


<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['delete_records'])) {
    // Prepare the deletion statement
    $del_stmt = file_get_contents("delete_instrument.sql");
    $del_stmt = $conn->prepare($del_stmt);
    $del_stmt->bind_param('i', $id);

    // Loop through POST data to find selected checkboxes
    foreach ($_POST as $key => $value) {
        if (strpos($key, 'checkbox') === 0) {
            $id = (int)$value;
            $del_stmt->execute();
        }
    }

    // Redirect to avoid duplicate deletion on refresh
    header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
    exit();
}
?>



<?php

function result_to_html_table($result) {
        $qryres = $result->fetch_all();
        $n_rows = $result->num_rows;
        $n_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        <!-- <p>This table has <?php //echo $n_rows; ?> and <?php //echo $n_cols; ?> columns.</p> -->
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <!-- Using default action (this page). -->
        <table>
        <thead>
        <tr>
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
            <?php for($j=0; $j<$n_cols; $j++){ ?>
                <td><?php echo $qryres[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>
<?php } ?>

<?php
    $sql_location = '/home/omkarzarikar/csc362_f24_zarikar/lab8/';
    $conn = new mysqli( 'localhost', 'webuser', 'fraudsters', 'instrument_rentals');    // 1
    $sel_tbl = file_get_contents($sql_location . 'select_instruments.sql');         // 2
    $result = $conn->query($sel_tbl);   // 3
    result_to_html_table($result);      // 4
?>

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

<!-- HTML Form for adding records -->
<form method="POST">
    <input type="submit" name="add_records" value="Add extra records" />
</form>
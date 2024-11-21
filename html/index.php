<html>
    <head>
    <title>PHP Test Page</title>
    </head>
    <body>
    <?php echo "Hello world!"; ?>
    </body>
</html>


<?php
if (str_contains($_SERVER['HTTP_USER_AGENT'], 'Mac')) {
?>
<h3>str_contains() returned true</h3>
<p>You are using Mac</p>
<?php
} else {
?>
<h1>str_contains() returned false</h1>
<p>You are not using Mac</p>
<?php
}
?>

<form action="index.php" method="post">
    <label for="name">Your name:</label>
    <input name="name" id="name" type="text">

    <label for="age">Your age:</label>
    <input name="age" id="age" type="number">

    <button type="submit">Submit</button>
</form>

Hi <?php echo htmlspecialchars($_POST['name']); ?>.
You are <?php echo (int) $_POST['age']; ?> years old.


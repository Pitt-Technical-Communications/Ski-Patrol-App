<?php

$ini = parse_ini_file('../config.ini');

$servername = $ini['server_name'];
$username = $ini['db_user'];
$password = $ini['db_password'];
$dbname = $ini['db_name'];

$conn = new mysqli($servername, $username, $password, $dbname);

if($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}


$sql = $conn->prepare("INSERT INTO report_table (slope_name, slope_location) VALUES (?, ?)");

$sql->bind_param("ss", $slope, $location);

$slope = $_POST['name'];
$location = $_POST['location'];

if($sql->execute() == TRUE) {
	echo "Form successfully submitted";
	$sql->close();
	$conn->close();
} else {
	echo "Error: <br>" . $conn->error;
	$conn->close();
}
echo "<br><a href=\"index.html\">Return Home</a>";

?>
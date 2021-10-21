<?php
try {
    $dns = 'mysql:host=localhost;dbname=id17804692_carparking';
    $user = 'id17804692_carpark';
    $pass = '123car-parkFYP';
    $db = new PDO($dns,$user,$pass);
    $db->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    //echo'connected';
} catch (PDOException $e) {
    $error = $e->getMessage();
    echo $error;
}
?>
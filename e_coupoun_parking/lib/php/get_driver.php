<?php
require_once('db.php');
$query = 'SELECT * FROM Driver';
$stm = $db->prepare($query);
$stm->execute();

$myarray = array();

while ($resultsFrom = $stm ->fetch()){
    array_push(
        $myarray,array(
            "driverId"=>$resultsFrom['driverId'],
            "icNum"=>$resultsFrom['NRIC_num'],
            "name"=>$resultsFrom['name'],
            "icNum"=>$resultsFrom['NRIC_num'],
            "phone_num"=>$resultsFrom['phone_num'],
            "email"=>$resultsFrom['email'],
            "birth_date"=>$resultsFrom['date_of_birth']
        )
    );
}
echo json_encode($myarray);

?>
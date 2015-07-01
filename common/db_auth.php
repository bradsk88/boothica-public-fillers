<?php
function connect_boothDB() {

    if (isset($dblink) && $dblink !== false) {
        return $dblink;
    }

    $dblink = mysqli_connect('localhost', 'root', '', 'clicar5_boothsite') or death("Error " . mysqli_error($dblink));
    if (!$dblink) {
        mysql_error();
    }
    return $dblink;

}
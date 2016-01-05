<?php
function connect_boothDB() {

    if (isset($dblink) && $dblink !== false) {
        return $dblink;
    }

    if (!function_exists('mysqli_connect')) {
        // Will be true on localhost if the user hasn't installed mysql and enabled it in php.ini
        error_log("FATAL ERROR: No MYSQLI installation detected!");
        return null;
    }

    $dblink = mysqli_connect('localhost', 'root', '', 'clicar5_boothsite')
      or death("Error.  Unable to connect to database named: 'clicar5_boothsite'.  " . mysqli_error($dblink));
    if (!$dblink) {
        mysql_error();
    }
    return $dblink;

}
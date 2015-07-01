<?PHP

require_once "{$_SERVER['DOCUMENT_ROOT']}/common/boiler.php";
require_once "{$_SERVER['DOCUMENT_ROOT']}/actions/registerConstants.php";
require_common("utils");
require_common("db");
require_common("internal_utils");

$dblink = connect_boothDB();

$result = $dblink->query("SELECT `username` FROM `logintbl` WHERE `username` = '" . $dblink->escape_string(strtolower($_POST['username'])) . "';");
$r2sql = "SELECT `username` FROM `registertbl` WHERE `username` = '" .  $dblink->escape_string(strtolower($_POST['username'])) . "'  AND `expiry` > (NOW() - INTERVAL 5 DAY);";
$result2 = $dblink->query($r2sql);

$failed = false;

$errors = array();

if ( $result->num_rows != 0 || $result2->num_rows != 0) {
    $failed = true;
    $errors[] = RegisterConstants::TAKEN_NAME;
}

if (preg_match("/[^-a-z0-9_-]/i", strtolower($_POST['username'])) || strlen($_POST['username']) == 0) {
    $failed = true;
    $errors[] = RegisterConstants::INVALID_USERNAME;
}

if (strlen(strtolower($_POST['username'])) > 32) {
    $failed = true;
    $errors[] = RegisterConstants::USERNAME_TOO_LONG;
}

if ( $_POST['password'] != $_POST['passwordconfirm'] ) {
    $failed = true;
    $errors[] = RegisterConstants::PASSWORDS_DONT_MATCH;
} else {
    if ( strlen($_POST['password']) < 8) {
        $failed = true;
        $errors[] = RegisterConstants::PASSWORD_TOO_SHORT;
    }
}

if (filter_var($_POST['email'], FILTER_VALIDATE_EMAIL) == false) {
    $failed = true;
    $errors[] = RegisterConstants::EMAIL_FORMAT_INCORRECT;
}

if ($failed) {
    $dblink->close();
    header( 'Location: /user-registration?email='.$_REQUEST['email']."&errors=".json_encode($errors));
} else {

    $username = $_POST['username'];

    $hash = $_POST['password'];
    $unique_code = microtime();

    if ((!isset($_REQUEST['visibility'])) || $_REQUEST['visibility'] == 'public') {

        $sql = "INSERT INTO `registertbl`
					(`username`, `password`, `email`, `code`, `public`, `expiry`)
					VALUES
					('".$_POST['username']."','" . $hash . "','".$_POST['email']."','".$unique_code."', 1, NOW() + INTERVAL 5 DAY);";
    } else {
        $sql = "INSERT INTO `registertbl`
					(`username`, `password`, `email`, `code`, `public`, `expiry`)
					VALUES
					('".$_POST['username']."','" . $hash . "','".$_POST['email']."','".$unique_code."', 0, NOW() + INTERVAL 5 DAY);";
    }
    $dblink->query($sql);

    $site = $_SERVER['HTTP_HOST'];
    $headers = "MIME-Version: 1.0\r\n";
    $sitename = basePretty();
    $headers .= "From: $sitename<noreply@$site>\r\n";
    $headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
    $msg = "To activate your Boothi.ca account <b>$username</b> <a href= 'http://$site/actions/confirmregistration.php?z=$unique_code&username=$username'>Click here</a>.<br/>If left unactivated, this account will become available for registration at this time in <b>5 days</b>.";
    $email = $_POST['email'];
    mail($email, $sitename." account confirmation", $msg, $headers);
    echo "<script type = \"text/javascript\">location.href='/user-registration/accepted';</script>";
}

?>
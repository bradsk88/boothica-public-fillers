<?PHP

require_once "{$_SERVER['DOCUMENT_ROOT']}/common/boiler.php";
require_once "{$_SERVER['DOCUMENT_ROOT']}/framing/PageFrame.php";
require_once "{$_SERVER['DOCUMENT_ROOT']}/pages/InfoPage.php";

error_reporting(E_ALL);

if (!isset($_SESSION)) session_start();

if (isset($_GET['z']) && isset($_GET['username'])) {

    if (isset($_GET['agree']) && $_GET['agree'] == "yes") {

        require_once "{$_SERVER['DOCUMENT_ROOT']}/common/utils.php";
        require_once "{$_SERVER['DOCUMENT_ROOT']}/common/db_auth.php";

        $dblink = connect_boothDB();

        $sql = "SELECT `username`, `password`, `email`, `public` FROM `registertbl` WHERE `code` = '".$_GET['z']."' AND `username` = '".$_GET['username']."' LIMIT 1;";

        $result = $dblink->query($sql);

        if (!$result) {
            echo sql_death1($sql);
            return;
        }

        if ($result->num_rows == 1) {

            $ok = makeAccount($result->fetch_array());

            if ($ok == 0) {

                echo "<h1>Account confirmed.  Please wait...</h1><script type = 'text/javascript'>location.href = '/activity?firsttime=true';</script>";

            } else {

                echo "There was a problem with the registration.  Please contact administration if the problem persists";

            }

        } else {

            echo "Activation code was not accepted";

        }

    } else {

        $page = new PageFrame();
        $page->title("One more thing...");
        $page->css(base()."/css/tutorial.css");
        $page->excludeLoginNotification();
        $page->setBodyTemplateAndValues("{$_SERVER['DOCUMENT_ROOT']}/actions/templates/readTheRules.mst", array(
            "confirmationCode" => $_GET['z'],
            "username" => $_REQUEST['username']
        ));
        $page->css("http://fonts.googleapis.com/css?family=Bitter:400,700");
        $page->echoHtml();

    }

    if (isset($dblink)) {
        $dblink->close();
    }

} else {
    echo "URL is invalid";
}

function makeAccount($row) {

    $displayname = $row['username'];

    $username = strtolower($row['username']);

    $encryptedPassword = $row['password'];

    $email = $row['email'];

    initializeNewUser($username, $displayname, $encryptedPassword, $email);

    $_SESSION['username'] = $username;

    return 0;

}


function initializeNewUser($username, $displayname, $encryptedPassword, $email) {

    //initialize metrics data

    $dblink = connect_boothDB();
    $sql = "INSERT INTO `logintbl`(`username`, `displayname`, `password`, `isBanned`, `isDisabled`) VALUES ('".$username."','".$displayname."','".$encryptedPassword."',0,0)";
    $insert = $dblink->query($sql);

    if (!$insert) {
        sql_death1($sql);
        return -1;
    }

    $dblink->query("INSERT INTO `friendstbl` (`fkUsername` ,`fkFriendName`) VALUES ('".$username."', '".$username."');");

    $dblink->query("INSERT INTO `usersecuritytbl` (`fkUsername` ,`security`) VALUES ('".$username."', 'NORMAL');");

    $dblink->query("INSERT INTO `usersprivacytbl` (`fkUsername` ,`privacyDescriptor`) VALUES ('".$username."', 'public');");

    $dblink->query("INSERT INTO `emailtbl` (`fkUsername`, `email`, `fromMods`, `friendBooth`, `boothComment`, `mention`, `friendRequest`, `friendAccept`) VALUES ('".$username."', '" . $email . "', '1', '1', '1', '1', '1', '1');");

    $dblink->query("DELETE FROM `registertbl` WHERE `username` = '".$username."';");
}
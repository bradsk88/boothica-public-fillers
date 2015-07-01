<?php 

require_once "{$_SERVER['DOCUMENT_ROOT']}/common/boiler.php";
require_common("utils");
require_common("internal_utils");
dologin($dblink);

function dologin()
{

    session_start();
    if (isset($_POST['username'])) {
        $_SESSION['username'] = $_POST['username'];
    } else if (isset($_GET['username'])) {
        $_SESSION['username'] = $_GET['username'];
    } else {
        echo "404";
        return;
    }

    echo "<!DOCTYPE html>
<html>
    <script type = 'text/javascript'>
        location.href = '/activity';
    </script>
</html>
";
}
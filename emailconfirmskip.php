<?PHP

    require_once "{$_SERVER['DOCUMENT_ROOT']}/common/boiler.php";
    require_once "{$_SERVER['DOCUMENT_ROOT']}/common/db.php";

    if (isset($_REQUEST['username'])) {
        $sql = "SELECT code FROM registertbl WHERE username = '".$_REQUEST['username']."' ORDER BY expiry DESC LIMIT 1;";
        $db = connect_boothDB();
        $query = $db->query($sql);
        $code = sql_get_expectOneRow($query, 'code');
        header("Location: " . base() . "/actions/confirmregistration?username=".$_REQUEST['username']."&z=".$code);
        return;
    }

    echo "<html><body>
Enter username to skip email confirmation:<br/>
<form action = '".base()."/emailconfirmskip'>
<input type = 'text' name = 'username'/>
<button type = 'submit'>DO IT</button>
</form>
</body></html>";
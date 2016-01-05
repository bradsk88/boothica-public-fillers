<?PHP
function generateRandomString()
{
    $length = 20;
    $letters = '1234567890qwertyuiopasdfghjklzxcvbnm_-';
    $s = '';
    $lettersLength = strlen($letters)-1;

    for($i = 0 ; $i < $length ; $i++)
    {
        $s .= $letters[rand(0,$lettersLength)];
    }

    return $s;
}

function getBoothSalt() {
    return "some_salt";
}

function generateUserUniqueHash($username) {
    return generateSaltedHash("some_salt", $username . time(), generateRandomString());
}

function generateSaltedHash($salt, $password) {
    $hash = $salt . $password;

    for ( $i = 0; $i < 100000; $i ++ ) {
        $hash = hash('sha256', $hash);
    }
    $hash = $salt . $hash;
    return $hash;
}

function changePassword($changeuser, $pass) {
    $salt = hash('sha256', uniqid(mt_rand(), true).'some_salt'.$changeuser);

    // Prefix the password with the salt
    $hash = $salt . $pass;

    // Hash the salted password a bunch of times
    for ( $i = 0; $i < 100000; $i ++ ) {
        $hash = hash('sha256', $hash);
    }

    // Prefix the hash with the salt so we can find it back later
    $hash = $salt . $hash;

    $dblink = connect_boothDB();
    $sql = "UPDATE
			`logintbl`
			SET `password` = '".$hash."'
			WHERE `username` = '".$changeuser."';";
    $result = $dblink->query($sql);

    if(!$result) {
        sql_death1($sql);
        return false;
    }

    return true;
}

function htmlEmoticons($string) {
    return preg_replace("/<3{1}/", "&lt;3", $string);
}

function preProcessPrivateMessage($message) {
    $formattedmessage = htmlEmoticons($message);
    $formattedmessage = strip_tags($formattedmessage);
    return preg_replace('/(\r\n|\n|\r)/','<br/>',$formattedmessage);
}

function encryptPrivateMessage($text) {
    $key = "some_secret_two_way_key";
    $iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    $crypttext = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $key, $text, MCRYPT_MODE_ECB, $iv);
    return $crypttext;
}

function decryptPrivateMessage($value) {
    if ($value == '') {
        return '';
    }
    $key = "some_secret_two_way_key";
    $crypttext = $value;
    $iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    $decrypttext = mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $key, $crypttext, MCRYPT_MODE_ECB, $iv);
    return trim($decrypttext);
}

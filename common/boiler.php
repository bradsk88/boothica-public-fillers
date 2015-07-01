<?php

/**
 * Contains boilerplate code for writing cleaner code.  Hopefully.
 */

require_once "{$_SERVER['DOCUMENT_ROOT']}/common/universal_utils.php";

function doesSiteAppearDown() {
    if (isLoggedIn() && $_SESSION['username'] == 'moderator') {  # TODO: Don't just use one user.
        return false;
    }
    return false; # toggle this to shut down the site
}

function base() {
    return "http://".baseWithoutProtocol();
}

function baseWithoutProtocol() {
    return "localhost";
}

function basePretty() {
    return "Boothi.ca on localhost";
}

function require_common( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/common/".$asset.".php";
}

function require_lib( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/lib/".$asset.".php";
}

function require_account_asset( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/account/assets/".$asset.".php";
}

function require_asset( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/common/assets/".$asset.".php";
}

function require_mod_asset( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/mod_assets/".$asset.".php";
}

function require_page( $asset ) {
    require_once "{$_SERVER['DOCUMENT_ROOT']}/pages/".$asset.".php";
}

function include_error( $page ) {
    include "{$_SERVER['DOCUMENT_ROOT']}/errors/".$page.".php";
}

function isLoggedIn() {
    if (!isset($_SESSION)) {
        session_start();
    }
    return isset($_SESSION['username']) && strlen(trim($_SESSION['username'])) > 0;
}

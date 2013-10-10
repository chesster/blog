<?php
function Redirect($url, $permanent = false) {
    header('Location: ' . $url, true, $permanent ? 301 : 302);
    exit();
}
switch (substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2)){
    case "en":
        Redirect('/index.html');
        break;
    default:
        Redirect('/pl/index.html');
        break;
}
?>

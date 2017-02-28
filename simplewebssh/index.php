<?php 
date_default_timezone_set('Asia/Jakarta'); 
$tgl=date('Y-m-d');
$habis= date('Y-m-d', strtotime($tgl. ' + 30 days'));
if(isset($_POST['submit'])){
$user=$_POST['user'];
$pass=$_POST['pass'];
$type = '/bin/false -m';

$connection = ssh2_connect('ip', 22);
}
if (ssh2_auth_password($connection, 'root', 'passroot')) { 
//$result = ssh2_exec($connection, "useradd -e `date -d '30 days' +'%Y-%m-%d'` $user -s $type; { echo $pass; echo $pass; } | passwd $user; usermod -c $kaka $user");


$result = ssh2_exec($connection, "useradd -e `date -d '30 days' +'%Y-%m-%d'` $user; { echo $pass; echo $pass; } | passwd $user;");
}
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Create Account for SGDO By SoneD InjectoR">
    <meta name="keywords" content="Create Account for SGDO By SoneD InjectoR"/>	
    <meta name="author" content="ssh.mastahit.com">
    <meta name="rating" content="general"/>
    <meta name="distribution" content="global"/>
    <meta name="copyright" content="ssh.mastahit.com"/>	
    <title>Create Account For SSH SGDO</title>
    <link href="http://ssh.mastahit.com/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://ssh.mastahit.com/css/custom.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="https://use.fontawesome.com/f84acb2433.js"></script>    
    <script src="http://ssh.mastahit.com/js/sshmastahit.js"></script>    
  </head>
  
  <body>

   <div class="container">
    <div class="page-header">
    <center>
     <h1 style="color:#FFA500">Create Premium SSH Account for SGDO</h1>  
    </center>
    </div>

<div class="col-md-6">
<?php
if ($result) {
echo "Host: ip";
echo "<br>";
echo "Port: 443";
echo "<br>";
echo "Username: $user";
echo "<br>";
echo "Password: $pass";
}else{
}
?>
<form method="POST">
		<div class="input-group">
		  <span class="input-group-addon">Username</span>
		  <input name="user" type="text" class="form-control" maxlength="12" placeholder="Username" id="user" required="required">
		</div>
		<div class="input-group">
		  <span class="input-group-addon">Password</span>
		  <input name="pass" type="text" class="form-control" placeholder="Password" id="pass" required="required">
		</div>
		 <button name="submit" class="btn btn-warning btn-block" id="submit" type="submit">Create Account</button>
</form>	
</div><br>
   </div>
     
  </body>
</html>

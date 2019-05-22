
<?php
session_start();
//echo"<script>alert('welcome')</script>";
if($_POST["t1"]=="abcd"&&$_POST["t2"]=="123")
{
     $_SESSION['user']="pavanchikka";
    $con = mysqli_connect("localhost","root","","Petshop_management");
if(!$con)
{ 
die("could not connect database".mysql_error());
}
  
else
{
    echo"<script>location.href='home.html'</script>";
}
}
else
{
     echo"<script>alert('invaild username or password')</script>";
    echo"<script>location.href='login.html'</script>";
}

?>


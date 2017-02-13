<?php
session_start();
?>
<!-- Piyush Zode -->
<!DOCTYPE HTML>
<html>
<head>
  <title>Shopping Cart Project</title>
  <link rel="stylesheet" type="text/css" href="my_stylesheet.css">
</head>
<body>
  <div class="centerLogin">
    <div id="loginPage">
      <p><h4>Login User</h4></p>
      <form action="login.php" method="POST">
          Username:
          <input type="text" name="username"></br></br>
          Password:
          <input type="password" name="password"></br></br>
          <a href="register.php">Not Registered yet? Click Here</a></br></br>
          <input type="submit" value="Login" class="Button_class">
      </form>
      </div>
  </div>
<?php
error_reporting(E_ALL);
ini_set('display_errors','On');

try {
    $dbh = new PDO("mysql:host=127.0.0.1:3306;dbname=cheapbooks","root","",array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    #print_r($dbh);
    $dbh->beginTransaction();

    if(isset($_POST['username']) && isset($_POST['password'])){
      $stmt = $dbh->prepare('select fullname,username from customer where username="'.$_POST['username'].'" and pass="'.md5($_POST['password']).'";');
      $row=$stmt->execute();
            
      $row_test = $stmt->fetch(); 
      if (!$row_test)
      {
        $message = "Login Unsuccessful! Please enter correct Username and Password";
        echo "<script type='text/javascript'>alert('$message');</script>";
        #header( 'Location: login.php');
      }
      else {
        $_SESSION['username']=$row_test['username'];
        $_SESSION['fullname']=$row_test['fullname'];
        header( 'Location: search.php');
      }
    } 
  } catch (PDOException $e) {
      print "Error!: " . $e->getMessage() . "<br/>";
      die();
}
?>
</body>
</html>

<!-- Piyush Zode  -->
<html>
<head>
  <title>Shopping Cart Project</title>
  <link rel="stylesheet" type="text/css" href="my_stylesheet.css">
</head>
<body>
    <div class="centerLogin">
        <div id="registerPage">
        <p><h4>Register User</h4></p>
        <form action="register.php" method="POST" class="user-form">
        <div class="field">
            <label for="fullname">Full Name:</label>
            <input type="text" name="fullname"></br></br>
        </div>
        <div class="field">
            <label for="address">Address:</label>
            <input type="text" name="address"></br></br>
        </div>
        <div class="field">
            <label for="email">Email:</label>
            <input type="text" name="email"></br></br>
        </div>
        <div class="field">
            <label for="phone">Phone:</label>
            <input type="text" name="phone"></br></br>
        </div>
        <div class="field">
            <label for="username">Username:</label>
            <input type="text" name="username"></br></br>
        </div>
        <div class="field">
            <label for="password">Password:</label>
            <input type="password" name="password"></br></br>
        </div>
        <input type="submit" value="Register" class="Button_class">
        &nbsp;<a href="login.php">Already Registered? Click Here</a></br></br>
    </form>
    </div>
</body>
</html>
<?php
error_reporting(E_ALL);
ini_set('display_errors','On');

try {
    $dbh = new PDO("mysql:host=127.0.0.1:3306;dbname=cheapbooks","root","",array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    #print_r($dbh);
    $dbh->beginTransaction();
    $dbh->commit();
}
catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}

if( isset($_POST['fullname']) && isset($_POST['address']) && isset($_POST['email']) && isset($_POST['phone']) && isset($_POST['username']) && isset($_POST['password']) ) {
    if($_POST['fullname']!='' && $_POST['address']!='' && $_POST['email']!='' && $_POST['phone']!='' && $_POST['username']!='' && $_POST['password']!='')
    {
        $query='select * from customer where username="'.$_POST['username'].'";';
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $user_flag = false;
        
        while ($row = $stmt->fetch()) {
            $user_flag = true;
        }

        if(!$user_flag)
        {
            $query='insert into customer values("'.$_POST['username'].'","'.$_POST['address'].'","'.$_POST['email'].'","'.$_POST['phone'].'","'.md5($_POST['password']).'","'.$_POST['fullname'].'");';
            $stmt = $dbh->prepare($query);
            $stmt->execute();
            header( 'Location: login.php');
        }
        else {
            $message = "Username already exists. Try with a different Username";
            echo "<script type='text/javascript'>alert('$message');</script>";
        }
    }
    else {
        $message = "Enter valid values in the Register form";
        echo "<script type='text/javascript'>alert('$message');</script>";
    }
}
?>
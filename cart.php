<?php
session_start();
## Piyush Zode ##

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

if (isset($_GET['delete_book'])) {
    $book_ISBN=$_GET['delete_book'];

    $_SESSION['count'] = $_SESSION['count'] - 1;
    //print $_SESSION['cart'][$book_ISBN][5];
    $_SESSION['cart'][$book_ISBN][5] = $_SESSION['cart'][$book_ISBN][5] - ($_SESSION['cart'][$book_ISBN][5] / $_SESSION['cart'][$book_ISBN][6]);
    $_SESSION['cart'][$book_ISBN][6] = $_SESSION['cart'][$book_ISBN][6] - 1;
    #$_SESSION['cart'][$book_ISBN]

    if($_SESSION['cart'][$book_ISBN][6] == 0) {
        unset($_SESSION['cart'][$book_ISBN]);
        unset($_SESSION['book_ISBN'][$book_ISBN]);
    }
    #unset($_SESSION['cart'][$deleteProdId]);
    #unset($_SESSION['productId'][$deleteProdId]);
}


if( isset($_POST['Buy']) ) {
    //print "Here";
    $unique_id = uniqid();
    $username = $_SESSION['username'];
    $order_placed_flag = false;
    $order_count_initial = $_SESSION['count'];
    $order_count = 0;

    if(!empty($_SESSION['cart']))
    {       
        foreach ($_SESSION['cart'] as $v)
        {
            if($v!='')
            {
                $book_isbn = $v[1];
                $quantity = $v[6];
                $warehouse_code = $v[4];
                $present = false;
                $db_value=0;

                $query='Select WAREHOUSE_NUMBER from Stocks where ISBN = "'.$book_isbn.'" and WAREHOUSECODE = "'.$warehouse_code.'";';
                $stmt = $dbh->prepare($query);
                $stmt->execute();

                while ($row = $stmt->fetch()) {
                    $present = true;
                    $db_value = $row['WAREHOUSE_NUMBER'];
                }

                if($db_value < $quantity) {
                    $message = "Book ".$book_isbn." has quantity ".$db_value." in the DB which is more than your quantity in the shopping cart. So, please change the quantity or delete the book! Rest Books if any have been purchased. Thank You!";
                    echo "<script type='text/javascript'>alert('$message');</script>";
                }
                else {
                    if(!$order_placed_flag) {
                        # Insert into Shopping Basket
                        $query='insert into SHOPPINGBASKET values("'.$unique_id.'","'.$username.'");';
                        $stmt = $dbh->prepare($query);
                        $stmt->execute();
                        $order_placed_flag=true;
                    }
                    

                    # Insert into Contains table
                    $query='insert into CONTAINS values("'.$book_isbn.'","'.$unique_id.'","'.$quantity.'");';
                    $stmt = $dbh->prepare($query);
                    $stmt->execute();

                    # Insert into Shipping Order Table
                    

                    # Check if the book from that warehouse exists for that user in the Shippingorder table 
                    $query='select * from SHIPPINGORDER where ISBN="'.$book_isbn.'" and WAREHOUSECODE="'.$warehouse_code.'" and USERNAME="'.$username.'";';
                    $stmt = $dbh->prepare($query);
                    $stmt->execute();
                    $present_flag = false;
                    
                    while ($row = $stmt->fetch()) {
                        $present_flag = true;
                    }

                    if(!$present_flag)
                    {
                        $query='insert into SHIPPINGORDER values("'.$book_isbn.'","'.$warehouse_code.'","'.$username.'","'.$quantity.'");';
                        $stmt = $dbh->prepare($query);
                        $stmt->execute();
                    }
                    else {
                        $query='Update SHIPPINGORDER set SHIPPINGORDER_NUMBER = SHIPPINGORDER_NUMBER + '.$quantity.' where ISBN="'.$book_isbn.'" and WAREHOUSECODE="'.$warehouse_code.'" and USERNAME="'.$username.'";';
                        $stmt = $dbh->prepare($query);
                        $stmt->execute();
                    }

                    # Update the Stocks table
                    $query='Update Stocks set WAREHOUSE_NUMBER = WAREHOUSE_NUMBER - '.$quantity.' where ISBN = "'.$book_isbn.'" and WAREHOUSECODE = "'.$warehouse_code.'";';
                    $stmt = $dbh->prepare($query);
                    $stmt->execute();

                    unset($_SESSION['cart'][$book_isbn]);
                    unset($_SESSION['book_ISBN'][$book_isbn]);
                    $_SESSION['count'] = $_SESSION['count'] - $quantity;
                }
            }
        }

        if($_SESSION['count'] == 0) {
            $message = "Order Place Successfully!";
            echo "<script type='text/javascript'>alert('$message');</script>";
            #header('Location: login.php');
        }
    }
}
else if( isset($_POST['ShopMore']) ) {
    //print "Here";
    header( 'Location: search.php?session_search=1');
    #header('Location: search.php');
}

?>
<!DOCTYPE HTML>
<html>
<head>
  <title>Shopping Cart Project</title>
  <link rel="stylesheet" type="text/css" href="my_stylesheet.css">
</head>
<body>
  <div class="centerLogin">

        <?php
        $TotalValue=0;
        if(!empty($_SESSION['cart']))
        {
            print '<p>
            <table border="1">
            <tbody>';
            print '<tr class="header">
                <td>TITLE</td>
                <td>ISBN</td>
                <td>AUTHOR NAME</td>
                <td>QUANTITY</td>
                <td>PRICE</td>
            </tr>';
            foreach ($_SESSION['cart'] as $v)
            {
                if($v!='')
                {
                    $delete_href='cart.php?delete_book='.$v[1];
                    print '<tr>';
                    print '<td>'.$v[0].'</td>';
                    print '<td>'.$v[1].'</td>';
                    print '<td>'.$v[2].'</td>';
                    print '<td>'.$v[6].'</td>';
                    print '<td>$'.$v[5].'</td>';
                    print '<td><a href='.$delete_href.'>delete</td>';
                    print '</tr>';
                    $TotalValue=$TotalValue+$v[5];
                }
            }
        }
        else {
            print '<p>Your cart is empty.</p>';
        }
        print '</tbody>
                </table>
                </p>';
        print 'Total: $'.$TotalValue;
        ?>
        <form action="cart.php" method="POST" class="user-form">         
            <input type="submit" value="Shop More" class="Button_class" name="ShopMore">
            <input type="submit" value="Buy" class="Button_class" name="Buy">
        </form>
    </div>

<?php
error_reporting(E_ALL);
ini_set('display_errors','On');


?>
</body>
</html>
<?php
session_start();

## Piyush Zode  ##

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


if(!isset($_SESSION['cart']) || $_SESSION['cart']==null)
{
    $_SESSION['cart']=array();
    $_SESSION['book_ISBN']=array();
    $_SESSION['count']=0;
}
if(!isset($_SESSION['show_search']) || $_SESSION['show_search']==null)
{
    $_SESSION['show_search']=array();    
}


if (isset($_GET['add_book'])) {
    #print "Value added to Basket is: ".$_GET['add_book'];
    $book_ISBN = $_GET['add_book'];
    $book_array=array();
    
    $query = "select b.TITLE, b.ISBN, a.NAME, s.WAREHOUSE_NUMBER, w.WAREHOUSECODE, b.PRICE from author a, writtenby wb, book b, stocks s, warehouse w where a.SSN=wb.SSN and wb.ISBN=b.ISBN and b.ISBN=s.ISBN and w.warehousecode=s.warehousecode and b.ISBN ='".$book_ISBN."' and s.WAREHOUSE_NUMBER > '0';";
        
    if ($res = $dbh->query($query))
    {
        if ($res->fetch() > 0)
        {
            #print '<p><table border="1"><tbody>';
            foreach ($dbh->query($query) as $row)
            {
                #print '<tr>';
                #print '<td>'.$row['TITLE'].'</td>';
                $book_title = $row['TITLE'];
                $book_ISBN = $row['ISBN'];
                $book_name = $row['NAME'];
                $book_warehouse_number = $row['WAREHOUSE_NUMBER'];
                $warehouse_code = $row['WAREHOUSECODE'];
                $book_price = $row['PRICE'];
                array_push($book_array,$book_title);
                array_push($book_array,$book_ISBN);
                array_push($book_array,$book_name);
                array_push($book_array,$book_warehouse_number);
                array_push($book_array,$warehouse_code);
                array_push($book_array,$book_price);
                array_push($book_array,1); //push the quantity as 1 always
            }
        }
    }

    if(!in_array($book_ISBN,$_SESSION['book_ISBN'])) {
        $_SESSION['book_ISBN'][$book_ISBN]=$book_ISBN;
        $_SESSION['cart'][$book_ISBN]=$book_array;
        $_SESSION['count'] = $_SESSION['count'] + 1;
    }
    else {
        $_SESSION['count'] = $_SESSION['count'] + 1;
        #print "hey";
        #print $_SESSION['cart'][$book_ISBN][5];
        $_SESSION['cart'][$book_ISBN][5] = $_SESSION['cart'][$book_ISBN][5] + $_SESSION['cart'][$book_ISBN][5];
        $_SESSION['cart'][$book_ISBN][6] = $_SESSION['cart'][$book_ISBN][6] + 1;
        #$_SESSION['cart'][$book_ISBN]
    }

    header( 'Location: search.php?session_search=1');
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
        <div id="SearchPage">
        <?php 
            print "<p><h4>Welcome ".$_SESSION["fullname"]."</h4></p>" 
        ?>
        <form action="search.php" method="POST" class="user-form">
            <fieldset>
                <legend>Search For Books:</legend>
                <div class="field">
                    <label for="fullname">Enter a Keyword:</label>
                    <input type="text" name="search_value"></br></br>
                </div>
                <input type="submit" value="Search by Author" class="Button_class" name="Search_by_Author">
                <input type="submit" value="Search by Book Title" class="Button_class" name="Search_by_Book_Title">
                <input type="submit" value="Basket" class="Button_class" name="Basket">
                <input type="text" name="counter" value="<?php echo htmlspecialchars($_SESSION['count']); ?>" style="width: 30px;" readonly></br></br>
                <input type="submit" value="Logout" class="Button_class" name="Logout">
            </fieldset>
        </form>
        </div>


<?php


#print_r ($_SESSION['show_search']);

if( isset($_POST['search_value']) && isset($_POST['Search_by_Author']) ) {
    #$new_book_array=array();
    $_SESSION['show_search']=array();
    if($_POST['search_value']!='')
    {
        $query = "select b.TITLE, b.ISBN, s.WAREHOUSE_NUMBER from author a, writtenby wb, book b, stocks s where a.SSN=wb.SSN and wb.ISBN=b.ISBN and b.ISBN=s.ISBN and a.NAME like '%".$_POST['search_value']."%' and s.WAREHOUSE_NUMBER > '0';";
        
        if ($res = $dbh->query($query))
        {
            if ($res->fetch() > 0)
            {
                #print '<p><table border="1"><tbody>';
                #print '<tr class="header">
                #<td>TITLE</td>
                #<td>ISBN</td>
                #<td>QUANTITY AVAILABLE</td>
                #</tr>';
                foreach ($dbh->query($query) as $row)
                {
                    #print '<tr>';
                    #$_SESSION['TITLE'] = $row['TITLE'];
                    #print '<td>'.$row['TITLE'].'</td>';
                    #print '<td>'.$row['ISBN'].'</td>';
                    #print '<td>'.$row['WAREHOUSE_NUMBER'].'</td>';
                    #$href='search.php?add_book='.$row['ISBN'];
                    #$hyper_link = "Add Book to Basket";
                    #print '<td><a href="'.$href.'">'.$hyper_link.'</a></td>';
                    #print '</tr>';   
                    #$new_book_title = $row['TITLE'];
                    #$new_book_ISBN = $row['ISBN'];
                    #$new_book_warehouse_number = $row['WAREHOUSE_NUMBER'];
                    #array_push($new_book_array,$new_book_title);
                    #array_push($new_book_array,$new_book_ISBN);
                    #array_push($new_book_array,$new_book_warehouse_number);
                    $_SESSION['show_search'][]=$row;
                }
                #$_SESSION['show_search'][]=$new_book_array;
                header('Location: search.php?session_search=1');
            }
            else {
                $message = "No Records Found! Please try to change your search parameter!";
                echo "<script type='text/javascript'>alert('$message');</script>";
            }
        }
    }
    else {
        $message = "Enter valid Search value";
        echo "<script type='text/javascript'>alert('$message');</script>";
    }
}
else if( isset($_POST['search_value']) && isset($_POST['Search_by_Book_Title']) ) {
    $_SESSION['show_search']=array();
    if($_POST['search_value']!='')
    {
        $query = "select b.TITLE, b.ISBN, s.WAREHOUSE_NUMBER from book b, stocks s where b.ISBN=s.ISBN and s.WAREHOUSE_NUMBER > '0' and b.title like '%".$_POST['search_value']."%';";
        
        if ($res = $dbh->query($query))
        {
            if ($res->fetch() > 0)
            {
                #print '<p><table border="1"><tbody>';
                #print '<tr class="header">
                #<td>TITLE</td>
                #<td>ISBN</td>
                #<td>QUANTITY AVAILABLE</td>
                #</tr>';
                foreach ($dbh->query($query) as $row)
                {
                    #print '<tr>';
                    #print '<td>'.$row['TITLE'].'</td>';
                    #print '<td>'.$row['ISBN'].'</td>';
                    #print '<td>'.$row['WAREHOUSE_NUMBER'].'</td>';
                    #$href='search.php?add_book='.$row['ISBN'];
                    #$hyper_link = "Add Book to Basket";
                    #print '<td><a href="'.$href.'">'.$hyper_link.'</a></td>';
                    #print '</tr>';
                    $_SESSION['show_search'][]=$row;
                }
                header('Location: search.php?session_search=1');
            }
            else {
                $message = "No Records Found! Please try to change your search parameter!";
                echo "<script type='text/javascript'>alert('$message');</script>";
            }
        }
    }
    else {
        $message = "Enter valid Search value";
        echo "<script type='text/javascript'>alert('$message');</script>";
    }
}
else if(isset($_GET['session_search'])) 
{
    if(!empty($_SESSION['show_search']))
    {
        #print "Reached here. can display table";
        print '<p><table border="1"><tbody>';
        print '<tr class="header">
        <td>TITLE</td>
        <td>ISBN</td>
        <td>QUANTITY AVAILABLE</td>
        <td></td>
        </tr>';
        foreach ($_SESSION['show_search'] as $v)
        {
            if($v!='')
            {
                #print $v;
                print '<tr>';
                print '<td>'.$v['TITLE'].'</td>';
                print '<td>'.$v['ISBN'].'</td>';
                print '<td>'.$v['WAREHOUSE_NUMBER'].'</td>';
                $href='search.php?add_book='.$v[1];
                $hyper_link = "Add Book to Basket";
                print '<td><a href="'.$href.'">'.$hyper_link.'</a></td>';
                print '</tr>';
            }
        }
    }
}
else if( isset($_POST['Basket']) ) {
    header( 'Location: cart.php');
}
else if( isset($_POST['Logout']) ) {
    // remove all session variables
    #unset($_SESSION['cart'][$deleteProdId]);
    #unset($_SESSION['book_ISBN'][$deleteProdId]);
    session_unset();
    // destroy the session 
    session_destroy(); 
    header( 'Location: login.php');
}

    print '</tbody></table></p></div></div>';

?>

    </div>
</body>
</html>
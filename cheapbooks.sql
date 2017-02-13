-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2016 at 02:16 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cheapbooks`
--

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `SSN` varchar(50) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `ADDRESS` varchar(200) NOT NULL,
  `PHONE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`SSN`, `NAME`, `ADDRESS`, `PHONE`) VALUES
('124953212', 'John', 'Nights Watch, TX 76010, USA', '6836501984'),
('667125349', 'Jamey', 'Casterly Rock, OH 12321, USA', '7862984442'),
('812375922', 'Khaleesi', 'Mareen, 805 S Center St, TX 23362, USA', '6761928883'),
('844375989', 'Arya', 'Winterfell, TX 45466, USA', '9082974452');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `ISBN` varchar(60) NOT NULL,
  `TITLE` varchar(100) NOT NULL,
  `YEAR` varchar(20) NOT NULL,
  `PRICE` varchar(50) NOT NULL,
  `PUBLISHER` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`ISBN`, `TITLE`, `YEAR`, `PRICE`, `PUBLISHER`) VALUES
('978-3-16-148410-0', 'Game of Thrones', '2000', '79.99', 'John Snow'),
('978-3-16-148410-1', 'Hobbit', '2008', '35.99', 'Penguin Random House'),
('978-3-16-148410-2', 'Rich Dad Poor Dad', '1999', '20.99', 'Robert Kioski'),
('978-3-16-148410-3', 'Gone Girl', '2012', '68.99', 'Harper Collins'),
('978-3-16-148410-4', 'The Love Story', '2015', '10.99', 'The Wild Side'),
('978-3-16-148410-5', 'Avengers', '2009', '45.99', 'Marvels'),
('978-3-16-148410-6', 'Notebook', '2001', '24.99', 'Lover Boy'),
('978-3-16-148410-7', 'Walk to Remember', '2004', '26.99', 'Lover Boy'),
('978-3-16-148410-8', 'Prison Break', '2002', '20.99', 'John Tully'),
('978-3-16-148410-9', 'Marvels Daredevil', '2010', '69.99', 'Marvels');

-- --------------------------------------------------------

--
-- Table structure for table `contains`
--

CREATE TABLE `contains` (
  `ISBN` varchar(60) DEFAULT NULL,
  `BASKETID` varchar(50) DEFAULT NULL,
  `CONTAINS_NUMBER` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contains`
--

INSERT INTO `contains` (`ISBN`, `BASKETID`, `CONTAINS_NUMBER`) VALUES
('978-3-16-148410-1', '57799cefdefe0', '1'),
('978-3-16-148410-6', '57799cefdefe0', '1'),
('978-3-16-148410-6', '5779a24416f4f', '1'),
('978-3-16-148410-6', '5779a2895544e', '2'),
('978-3-16-148410-3', '5779a2cc9821d', '1'),
('978-3-16-148410-6', '5779a2cc9821d', '2'),
('978-3-16-148410-4', '5779a3121c7cd', '1'),
('978-3-16-148410-1', '5779a44b4ae48', '1'),
('978-3-16-148410-0', '5779a73eb48d8', '1'),
('978-3-16-148410-0', '5779a756ea124', '1'),
('978-3-16-148410-1', '5779a78d6a6bd', '1'),
('978-3-16-148410-0', '5779a78d6a6bd', '1'),
('978-3-16-148410-1', '577b96e409bbe', '2'),
('978-3-16-148410-1', '577c361551ba1', '1'),
('978-3-16-148410-0', '577c361551ba1', '1'),
('978-3-16-148410-1', '577c46adac0e9', '5'),
('978-3-16-148410-5', '577c46c24495a', '1'),
('978-3-16-148410-5', '577c46ea9f3c7', '1'),
('978-3-16-148410-0', '577c48164acc3', '2'),
('978-3-16-148410-7', '577c48164acc3', '1'),
('978-3-16-148410-3', '577c4849836bd', '1'),
('978-3-16-148410-0', '577c486f13a40', '1'),
('978-3-16-148410-7', '577c486f13a40', '1'),
('978-3-16-148410-6', '577c488bbf6da', '1'),
('978-3-16-148410-8', '577c4967d4cfe', '2'),
('978-3-16-148410-7', '577c4967d4cfe', '1'),
('978-3-16-148410-6', '577c4967d4cfe', '1'),
('978-3-16-148410-7', '577c4a259d99d', '1'),
('978-3-16-148410-8', '577c4a259d99d', '1'),
('978-3-16-148410-6', '577c4a259d99d', '1'),
('978-3-16-148410-3', '577c4a259d99d', '1'),
('978-3-16-148410-9', '577c4af843094', '3'),
('978-3-16-148410-0', '577c4b6238cc0', '1'),
('978-3-16-148410-9', '577c4b6238cc0', '2'),
('978-3-16-148410-9', '577c4c3e4cb74', '3');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `USERNAME` varchar(50) NOT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(60) DEFAULT NULL,
  `PHONE` varchar(60) DEFAULT NULL,
  `PASS` varchar(60) DEFAULT NULL,
  `FULLNAME` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`USERNAME`, `ADDRESS`, `EMAIL`, `PHONE`, `PASS`, `FULLNAME`) VALUES
('aish', 'Meadowrun Club', 'aish@gmail.com', '23187231211', 'c32bcd02d43ddd15b9f035b4e22bcc59', 'Aishwarya'),
('piyushz', '805 S Center St, 103', 'piyush.zode@mavs.uta.edu', '6825978884', '78bf3888ebf5ceab0b3b429635196f6a', 'Piyush Zode'),
('sid', '810 W Center St, Apt 111', 'sid@gmail.com', '89231213211', 'b8c1a3069167247e3503f0daba6c5723', 'Sidharth Mehra');

-- --------------------------------------------------------

--
-- Table structure for table `shippingorder`
--

CREATE TABLE `shippingorder` (
  `ISBN` varchar(60) DEFAULT NULL,
  `WAREHOUSECODE` varchar(50) DEFAULT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `SHIPPINGORDER_NUMBER` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shippingorder`
--

INSERT INTO `shippingorder` (`ISBN`, `WAREHOUSECODE`, `USERNAME`, `SHIPPINGORDER_NUMBER`) VALUES
('978-3-16-148410-1', '7185', 'piyushz', '9'),
('978-3-16-148410-6', '5412', 'piyushz', '3'),
('978-3-16-148410-6', '5412', 'piyushz', '3'),
('978-3-16-148410-6', '5412', 'piyushz', '4'),
('978-3-16-148410-3', '5412', 'piyushz', '3'),
('978-3-16-148410-6', '5412', 'piyushz', '4'),
('978-3-16-148410-4', '7126', 'piyushz', '1'),
('978-3-16-148410-1', '7185', 'piyushz', '9'),
('978-3-16-148410-0', '5412', 'aish', '4'),
('978-3-16-148410-1', '7185', 'aish', '1'),
('978-3-16-148410-0', '5412', 'piyushz', '4'),
('978-3-16-148410-5', '7126', 'piyushz', '2'),
('978-3-16-148410-7', '6321', 'piyushz', '3'),
('978-3-16-148410-7', '6321', 'aish', '1'),
('978-3-16-148410-6', '5412', 'aish', '1'),
('978-3-16-148410-8', '6321', 'piyushz', '3'),
('978-3-16-148410-9', '7126', 'piyushz', '5'),
('978-3-16-148410-9', '7126', 'aish', '3');

-- --------------------------------------------------------

--
-- Table structure for table `shoppingbasket`
--

CREATE TABLE `shoppingbasket` (
  `BASKETID` varchar(50) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shoppingbasket`
--

INSERT INTO `shoppingbasket` (`BASKETID`, `USERNAME`) VALUES
('5779a73eb48d8', 'aish'),
('5779a756ea124', 'aish'),
('5779a78d6a6bd', 'aish'),
('577c486f13a40', 'aish'),
('577c488bbf6da', 'aish'),
('577c4c3e4cb74', 'aish'),
('57799cefdefe0', 'piyushz'),
('5779a24416f4f', 'piyushz'),
('5779a2895544e', 'piyushz'),
('5779a2cc9821d', 'piyushz'),
('5779a3121c7cd', 'piyushz'),
('5779a44b4ae48', 'piyushz'),
('577b96e409bbe', 'piyushz'),
('577c361551ba1', 'piyushz'),
('577c46adac0e9', 'piyushz'),
('577c46c24495a', 'piyushz'),
('577c46ea9f3c7', 'piyushz'),
('577c48164acc3', 'piyushz'),
('577c4849836bd', 'piyushz'),
('577c4967d4cfe', 'piyushz'),
('577c4a259d99d', 'piyushz'),
('577c4af843094', 'piyushz'),
('577c4b6238cc0', 'piyushz');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `ISBN` varchar(60) DEFAULT NULL,
  `WAREHOUSECODE` varchar(50) DEFAULT NULL,
  `WAREHOUSE_NUMBER` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`ISBN`, `WAREHOUSECODE`, `WAREHOUSE_NUMBER`) VALUES
('978-3-16-148410-6', '5412', '5'),
('978-3-16-148410-3', '5412', '2'),
('978-3-16-148410-0', '5412', '4'),
('978-3-16-148410-7', '6321', '10'),
('978-3-16-148410-8', '6321', '20'),
('978-3-16-148410-2', '6321', '2'),
('978-3-16-148410-4', '7126', '1'),
('978-3-16-148410-1', '7185', '5'),
('978-3-16-148410-5', '7126', '2'),
('978-3-16-148410-9', '7126', '20');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `WAREHOUSECODE` varchar(50) NOT NULL,
  `NAME` varchar(60) DEFAULT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `PHONE` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `warehouse`
--

INSERT INTO `warehouse` (`WAREHOUSECODE`, `NAME`, `ADDRESS`, `PHONE`) VALUES
('5412', 'Jackalope', '101 E Morningside Dr', '9657121771'),
('6321', 'Louis Backyard', '3400 Padre Blvd', '6721391239'),
('7126', 'Kelly Irish Warehouse', '3109 Padre Blvd, South Padre Island, TX 78597', '8921301231'),
('7185', 'Sherlock Warehouse', '219 St Cooper Arlington', '3217612771');

-- --------------------------------------------------------

--
-- Table structure for table `writtenby`
--

CREATE TABLE `writtenby` (
  `SSN` varchar(50) DEFAULT NULL,
  `ISBN` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `writtenby`
--

INSERT INTO `writtenby` (`SSN`, `ISBN`) VALUES
('124953212', '978-3-16-148410-6'),
('124953212', '978-3-16-148410-4'),
('124953212', '978-3-16-148410-3'),
('667125349', '978-3-16-148410-1'),
('667125349', '978-3-16-148410-5'),
('844375989', '978-3-16-148410-0'),
('812375922', '978-3-16-148410-2'),
('844375989', '978-3-16-148410-7'),
('844375989', '978-3-16-148410-8'),
('812375922', '978-3-16-148410-9');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`SSN`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indexes for table `contains`
--
ALTER TABLE `contains`
  ADD KEY `fk_contains_basketid` (`BASKETID`),
  ADD KEY `fk_contains_isbn` (`ISBN`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`USERNAME`);

--
-- Indexes for table `shippingorder`
--
ALTER TABLE `shippingorder`
  ADD KEY `fk_shippingorder_isbn` (`ISBN`),
  ADD KEY `fk_shippingorder_warehousecode` (`WAREHOUSECODE`),
  ADD KEY `fk_shippingorder_username` (`USERNAME`);

--
-- Indexes for table `shoppingbasket`
--
ALTER TABLE `shoppingbasket`
  ADD PRIMARY KEY (`BASKETID`),
  ADD KEY `fk_shippingbasket_username` (`USERNAME`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD KEY `fk_stocks_isbn` (`ISBN`),
  ADD KEY `fk_stocks_warehousecode` (`WAREHOUSECODE`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`WAREHOUSECODE`);

--
-- Indexes for table `writtenby`
--
ALTER TABLE `writtenby`
  ADD KEY `fk_writtenby_ssn` (`SSN`),
  ADD KEY `fk_writtenby_isbn` (`ISBN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contains`
--
ALTER TABLE `contains`
  ADD CONSTRAINT `fk_contains_basketid` FOREIGN KEY (`BASKETID`) REFERENCES `shoppingbasket` (`BASKETID`),
  ADD CONSTRAINT `fk_contains_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`);

--
-- Constraints for table `shippingorder`
--
ALTER TABLE `shippingorder`
  ADD CONSTRAINT `fk_shippingorder_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `fk_shippingorder_username` FOREIGN KEY (`USERNAME`) REFERENCES `customer` (`USERNAME`),
  ADD CONSTRAINT `fk_shippingorder_warehousecode` FOREIGN KEY (`WAREHOUSECODE`) REFERENCES `warehouse` (`WAREHOUSECODE`);

--
-- Constraints for table `shoppingbasket`
--
ALTER TABLE `shoppingbasket`
  ADD CONSTRAINT `fk_shippingbasket_username` FOREIGN KEY (`USERNAME`) REFERENCES `customer` (`USERNAME`);

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `fk_stocks_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `fk_stocks_warehousecode` FOREIGN KEY (`WAREHOUSECODE`) REFERENCES `warehouse` (`WAREHOUSECODE`);

--
-- Constraints for table `writtenby`
--
ALTER TABLE `writtenby`
  ADD CONSTRAINT `fk_writtenby_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `fk_writtenby_ssn` FOREIGN KEY (`SSN`) REFERENCES `author` (`SSN`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2019 at 04:02 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petshop_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculations_for_pets` (IN `pid` VARCHAR(9), IN `sid` VARCHAR(9))  NO SQL
BEGIN
DECLARE 
 cpid ,csid int DEFAULT 0;
set cpid=(select cost from pets where pet_id=pid);
set csid=(select total from sales_details where sd_id=sid);
set csid=csid+cpid;
update sales_details set total=csid where sd_id=sid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calculations_for_product` (IN `ppid` VARCHAR(9), IN `sid` VARCHAR(9), IN `qnty` INT(11))  NO SQL
BEGIN
DECLARE 
 cppid ,csid int DEFAULT 0;
set cppid=(select cost from pet_products where pp_id=ppid);
set csid=(select total from sales_details where sd_id=sid);
set csid=csid+qnty*cppid;
update sales_details set total=csid where sd_id=sid;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `pet_id` varchar(9) NOT NULL,
  `breed` varchar(30) NOT NULL,
  `weight` float NOT NULL,
  `height` float NOT NULL,
  `age` int(11) NOT NULL,
  `fur` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `animals`
--

INSERT INTO `animals` (`pet_id`, `breed`, `weight`, `height`, `age`, `fur`) VALUES
('pa01', 'labrador', 11.3, 30, 2, 'white'),
('pa02', 'parsian', 3.6, 20, 2, 'white'),
('pa03', 'golden retriever', 12.5, 40, 2, 'gloden'),
('pa04', 'boxer', 11.5, 45, 3, 'black'),
('pa05', 'rag doll', 2.6, 20, 5, 'white'),
('pa06', 'st bernard', 10.8, 35, 3, 'brownish yellow'),
('pa07', 'bulldog', 8, 25, 3, 'white');

-- --------------------------------------------------------

--
-- Table structure for table `birds`
--

CREATE TABLE `birds` (
  `pet_id` varchar(9) NOT NULL,
  `type` varchar(25) NOT NULL,
  `noise` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `birds`
--

INSERT INTO `birds` (`pet_id`, `type`, `noise`) VALUES
('pb01', 'grey parrot', 'moderate'),
('pb02', 'black cheeked', 'low'),
('pb03', 'grey headed', 'moderate'),
('pb04', 'lilian', 'moderate'),
('pb05', 'white cockatoo', 'moderate');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cs_id` varchar(9) NOT NULL,
  `cs_fname` varchar(10) NOT NULL,
  `cs_minit` varchar(10) NOT NULL,
  `cs_lname` varchar(10) NOT NULL,
  `cs_address` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cs_id`, `cs_fname`, `cs_minit`, `cs_lname`, `cs_address`) VALUES
('cs01', 'Naveen', 'kumar', 'k', 'Mandya'),
('cs02', 'manjunath', 'kumar', 'h v', 'BENGALURU'),
('cs03', 'pavan', 'chikkanna', 'gowda', 'BENGALURU'),
('cs04', 'kushal', 'kumar', 'k', 'BENGALURU'),
('cs05', 'ravi', 'shankar', 'c', 'BENGALURU');

-- --------------------------------------------------------

--
-- Table structure for table `pets`
--

CREATE TABLE `pets` (
  `pet_id` varchar(9) NOT NULL,
  `pet_category` varchar(15) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pets`
--

INSERT INTO `pets` (`pet_id`, `pet_category`, `cost`) VALUES
('pa01', 'dog', 8000),
('pa02', 'cat', 3000),
('pa03', 'dog', 8500),
('pa04', 'dog', 15000),
('pa05', 'cat', 3500),
('pa06', 'dog', 10500),
('pa07', 'dog', 12000),
('pb01', 'parrot', 2000),
('pb02', 'lovebirds', 800),
('pb03', 'lovebirds', 600),
('pb04', 'lovebirds', 800),
('pb05', 'cockatoo', 10000);

--
-- Triggers `pets`
--
DELIMITER $$
CREATE TRIGGER `check_sold` BEFORE UPDATE ON `pets` FOR EACH ROW BEGIN
DECLARE
 checking int;
 set checking=(select count(*) from sold_pets where pet_id=old.pet_id);
  if (checking > 0) then   
        signal sqlstate '45000' set message_text = 'cannot  update sold pet';
    end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pet_products`
--

CREATE TABLE `pet_products` (
  `pp_id` varchar(9) NOT NULL,
  `pp_name` varchar(30) NOT NULL,
  `pp_type` varchar(20) NOT NULL,
  `cost` int(11) NOT NULL,
  `belongs_to` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pet_products`
--

INSERT INTO `pet_products` (`pp_id`, `pp_name`, `pp_type`, `cost`, `belongs_to`) VALUES
('pp01', 'dog collar', 'accesories', 500, 'dog'),
('pp02', 'chain', 'accesories', 100, 'cat'),
('pp03', 'pedigree', 'food', 1500, 'dog'),
('pp04', 'mouth mask', 'accesories', 250, 'dog'),
('pp05', 'food bowl', 'accesories', 250, 'dog '),
('pp06', 'bird feeds', 'food', 300, 'birds');

-- --------------------------------------------------------

--
-- Table structure for table `phone`
--

CREATE TABLE `phone` (
  `cs_id` varchar(9) NOT NULL,
  `cs_phone` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `phone`
--

INSERT INTO `phone` (`cs_id`, `cs_phone`) VALUES
('cs01', 8867762336),
('cs01', 9902587276),
('cs03', 9845034784),
('cs04', 6361261639),
('cs05', 86660873855);

-- --------------------------------------------------------

--
-- Table structure for table `sales_details`
--

CREATE TABLE `sales_details` (
  `sd_id` varchar(9) NOT NULL,
  `cs_id` varchar(9) NOT NULL,
  `date` date NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales_details`
--

INSERT INTO `sales_details` (`sd_id`, `cs_id`, `date`, `total`) VALUES
('sd01', 'cs03', '2018-10-26', 9500),
('sd02', 'cs01', '2018-11-01', 3000),
('sd03', 'cs03', '2018-11-08', 500),
('sd04', 'cs04', '2018-11-15', 12250),
('sd05', 'cs02', '2018-11-17', 9350),
('sd06', 'cs05', '2018-11-20', 1900),
('sd07', 'cs03', '2018-12-08', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `sold_pets`
--

CREATE TABLE `sold_pets` (
  `sd_id` varchar(9) NOT NULL,
  `pet_id` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sold_pets`
--

INSERT INTO `sold_pets` (`sd_id`, `pet_id`) VALUES
('sd01', 'pa01'),
('sd02', 'pa02'),
('sd04', 'pa07'),
('sd05', 'pa03'),
('sd06', 'pb02'),
('sd06', 'pb04');

-- --------------------------------------------------------

--
-- Table structure for table `sold_products`
--

CREATE TABLE `sold_products` (
  `sd_id` varchar(9) NOT NULL,
  `pp_id` varchar(9) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sold_products`
--

INSERT INTO `sold_products` (`sd_id`, `pp_id`, `quantity`) VALUES
('sd01', 'pp03', 1),
('sd03', 'pp01', 1),
('sd04', 'pp04', 1),
('sd05', 'pp05', 1),
('sd05', 'pp06', 2),
('sd06', 'pp06', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`pet_id`);

--
-- Indexes for table `birds`
--
ALTER TABLE `birds`
  ADD PRIMARY KEY (`pet_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cs_id`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`pet_id`);

--
-- Indexes for table `pet_products`
--
ALTER TABLE `pet_products`
  ADD PRIMARY KEY (`pp_id`);

--
-- Indexes for table `phone`
--
ALTER TABLE `phone`
  ADD PRIMARY KEY (`cs_id`,`cs_phone`);

--
-- Indexes for table `sales_details`
--
ALTER TABLE `sales_details`
  ADD PRIMARY KEY (`sd_id`,`cs_id`),
  ADD KEY `cs_id` (`cs_id`);

--
-- Indexes for table `sold_pets`
--
ALTER TABLE `sold_pets`
  ADD PRIMARY KEY (`pet_id`),
  ADD KEY `sd_id` (`sd_id`);

--
-- Indexes for table `sold_products`
--
ALTER TABLE `sold_products`
  ADD PRIMARY KEY (`sd_id`,`pp_id`),
  ADD KEY `sold_products_ibfk_2` (`pp_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `animals`
--
ALTER TABLE `animals`
  ADD CONSTRAINT `animals_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE;

--
-- Constraints for table `birds`
--
ALTER TABLE `birds`
  ADD CONSTRAINT `birds_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE;

--
-- Constraints for table `phone`
--
ALTER TABLE `phone`
  ADD CONSTRAINT `phone_ibfk_1` FOREIGN KEY (`cs_id`) REFERENCES `customer` (`cs_id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_details`
--
ALTER TABLE `sales_details`
  ADD CONSTRAINT `sales_details_ibfk_1` FOREIGN KEY (`cs_id`) REFERENCES `customer` (`cs_id`) ON DELETE CASCADE;

--
-- Constraints for table `sold_pets`
--
ALTER TABLE `sold_pets`
  ADD CONSTRAINT `sold_pets_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sold_pets_ibfk_2` FOREIGN KEY (`sd_id`) REFERENCES `sales_details` (`sd_id`) ON DELETE CASCADE;

--
-- Constraints for table `sold_products`
--
ALTER TABLE `sold_products`
  ADD CONSTRAINT `sold_products_ibfk_1` FOREIGN KEY (`sd_id`) REFERENCES `sales_details` (`sd_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sold_products_ibfk_2` FOREIGN KEY (`pp_id`) REFERENCES `pet_products` (`pp_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

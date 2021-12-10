-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Pi 10.Dec 2021, 10:19
-- Verzia serveru: 10.4.20-MariaDB
-- Verzia PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `epptec`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `client.id` int(11) NOT NULL,
  `type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `account`
--

INSERT INTO `account` (`id`, `client.id`, `type`) VALUES
(1, 1, 'Debit'),
(2, 2, 'Credit'),
(3, 1, 'Credit'),
(4, 2, 'Debit');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `balance`
--

CREATE TABLE `balance` (
  `id` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `account.id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `principal` decimal(10,2) NOT NULL,
  `interest` decimal(10,2) NOT NULL,
  `fees` decimal(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `balance`
--

INSERT INTO `balance` (`id`, `clientid`, `account.id`, `amount`, `principal`, `interest`, `fees`, `timestamp`) VALUES
(1, 1, 1, '100.00', '0.00', '0.00', '0.00', '2021-12-10 08:52:13'),
(2, 2, 2, '20.00', '0.00', '0.00', '0.00', '2021-12-10 08:52:34');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `phone` int(11) NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `client`
--

INSERT INTO `client` (`id`, `name`, `address`, `phone`, `email`) VALUES
(1, 'John Doe', 'Hlavna 1, Praha 1', 123456789, 'john.doe@gmail.com'),
(2, 'Jane Doe', 'Hlavna 2, Praha 1', 987654321, 'jane.doe@gmail.com');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `account.id` int(11) NOT NULL,
  `type` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `target_account` text NOT NULL,
  `status` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `transaction`
--

INSERT INTO `transaction` (`id`, `account.id`, `type`, `amount`, `target_account`, `status`, `timestamp`) VALUES
(1, 1, 'HVK', '100.00', '1', 'Complete', '2021-12-09 19:50:59'),
(2, 2, 'BPR', '20.00', '2', 'Complete', '2021-12-09 19:50:59');

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client.id` (`client.id`);

--
-- Indexy pre tabuľku `balance`
--
ALTER TABLE `balance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acc.id` (`account.id`),
  ADD KEY `us.id` (`clientid`);

--
-- Indexy pre tabuľku `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account.id` (`account.id`);

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `client.id` FOREIGN KEY (`client.id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Obmedzenie pre tabuľku `balance`
--
ALTER TABLE `balance`
  ADD CONSTRAINT `acc.id` FOREIGN KEY (`account.id`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `us.id` FOREIGN KEY (`clientid`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Obmedzenie pre tabuľku `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `account.id` FOREIGN KEY (`account.id`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

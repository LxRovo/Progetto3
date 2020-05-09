-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2020 at 01:43 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `lista`
--

CREATE TABLE `lista` (
  `idLista` int(11) NOT NULL,
  `rifRichiesta` int(11) NOT NULL,
  `rifProdotto` int(11) NOT NULL,
  `Quantità` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `prodotti`
--

CREATE TABLE `prodotti` (
  `idProdotto` int(11) NOT NULL,
  `genere` varchar(30) NOT NULL,
  `etichetta` longtext NOT NULL,
  `costo` double(6,2) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `descrizione` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prodotti`
--

INSERT INTO `prodotti` (`idProdotto`, `genere`, `etichetta`, `costo`, `nome`, `marca`, `descrizione`) VALUES
(1, 'provaPUT', 'provaPUT', 20.00, 'provaPUT', 'provaPUT', 'provaPUT'),
(4, 'prova', 'prova', 20.00, 'prova', 'prova', 'prova');

-- --------------------------------------------------------

--
-- Table structure for table `richiesta`
--

CREATE TABLE `richiesta` (
  `idRichiesta` int(11) NOT NULL,
  `rifUtente` varchar(30) NOT NULL,
  `oraInizioConsegna` time NOT NULL,
  `oraFineConsegna` time NOT NULL,
  `durataRichiesta` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `risposta`
--

CREATE TABLE `risposta` (
  `idRisposta` int(11) NOT NULL,
  `rifUtente` varchar(30) NOT NULL,
  `rifRichiesta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `utente`
--

CREATE TABLE `utente` (
  `idUtente` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `codiceFiscale` varchar(16) NOT NULL,
  `regione` varchar(25) NOT NULL,
  `via` varchar(30) NOT NULL,
  `civico` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lista`
--
ALTER TABLE `lista`
  ADD PRIMARY KEY (`idLista`);

--
-- Indexes for table `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`idProdotto`);

--
-- Indexes for table `richiesta`
--
ALTER TABLE `richiesta`
  ADD PRIMARY KEY (`idRichiesta`);

--
-- Indexes for table `risposta`
--
ALTER TABLE `risposta`
  ADD PRIMARY KEY (`idRisposta`);

--
-- Indexes for table `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`idUtente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lista`
--
ALTER TABLE `lista`
  MODIFY `idLista` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prodotti`
--
ALTER TABLE `prodotti`
  MODIFY `idProdotto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `richiesta`
--
ALTER TABLE `richiesta`
  MODIFY `idRichiesta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `risposta`
--
ALTER TABLE `risposta`
  MODIFY `idRisposta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utente`
--
ALTER TABLE `utente`
  MODIFY `idUtente` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

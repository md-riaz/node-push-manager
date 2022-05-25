-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 23, 2022 at 03:32 PM
-- Server version: 10.7.3-MariaDB-log
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `push_notification`
--

-- --------------------------------------------------------

--
-- Table structure for table `acl`
--

CREATE TABLE `acl` (
  `id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `acl`
--

INSERT INTO `acl` (`id`, `permission_id`, `group_id`, `user_id`) VALUES
(1, 2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `keys`
--

CREATE TABLE `keys` (
  `id` int(11) NOT NULL,
  `auth` varchar(100) NOT NULL,
  `p256dh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keys`
--

INSERT INTO `keys` (`id`, `auth`, `p256dh`) VALUES
(1, 'UrBcFBhkzgy6mx1HAZQg3A', 'BCZRreENEtowH8DnQymrYW9MV66wp0FqECZH3-NKR5GqE2gO903dNjbr4v0QZIMVmxF53Ci1X1MxqJE7_B2u-VI');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `api_path` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`id`, `api_path`) VALUES
(2, '/api/websites');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `id` int(11) NOT NULL,
  `endpoint` text NOT NULL,
  `expirationTime` varchar(100) DEFAULT NULL,
  `web_id` int(11) NOT NULL,
  `key_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`id`, `endpoint`, `expirationTime`, `web_id`, `key_id`) VALUES
(1, 'https://fcm.googleapis.com/fcm/send/e2scOGNbxwU:APA91bFcV63CQhCmT4g8QAfmfm1roC3t-6c7ppBPJrYbqInDDfPBvsGNiV7Fq9PRvY2ELC2jVlHIbbF8X4nxOD4GbXDXsZEh9Xv9IJkSH18s0S-tWsZF6OZKJjxNxhntzukBKx-W-6VY', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `type` enum('Portal') NOT NULL,
  `value` varchar(64) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id`, `uid`, `type`, `value`, `ip_address`, `updated_at`, `created_at`) VALUES
(1, 1, 'Portal', '7f5583ce53f04223161e662e5eaf305a07dd362752c3ccee118808296fcf8517', '::1', '2022-05-22 03:18:38', '2022-05-22 03:18:38'),
(2, 1, 'Portal', '40a455c7f5602773e4f1c6a3453d325a59d87cc42213c902a627e1a9605ba032', '::1', '2022-05-22 03:24:32', '2022-05-22 03:24:32'),
(3, 1, 'Portal', 'b149556ebb0aa53849bf889f794c77a17bcdb1423674748c15f773b7094cb5ef', '::1', '2022-05-22 03:26:41', '2022-05-22 03:26:41'),
(4, 1, 'Portal', '2d9fdba7594ce4ad8c69912a0f00468a243ed8e7a7a33276e59dac28d13f6d3b', '::1', '2022-05-22 19:21:46', '2022-05-22 19:21:46'),
(5, 1, 'Portal', 'e3e485eb39878b66d39b8c55b6b826e55f056eb2d81266eaa040ea75756b7ad8', '::1', '2022-05-22 19:25:42', '2022-05-22 19:25:42'),
(6, 1, 'Portal', '4f0a86ecc806d3ec2282b714ae2b4077fdc2cc04e95f6ce6b0d56c1526921e3e', '::1', '2022-05-22 19:25:58', '2022-05-22 19:25:58'),
(7, 1, 'Portal', '30707bc06f437132ac052c871bfe1cf077988d71f9280af51b1890372ffc78ee', '::1', '2022-05-22 19:26:12', '2022-05-22 19:26:12'),
(8, 1, 'Portal', '1d2f02eff40ddc234146126cfdd8ec0d5ca4a9627e875fed0f52f67139145777', '::1', '2022-05-22 19:26:44', '2022-05-22 19:26:44'),
(9, 1, 'Portal', '79fe7d9eaf41932ab7b6f68fd4d63a2ebd972efe92d6f10585d60a9a886d6cb6', '::1', '2022-05-22 19:46:58', '2022-05-22 19:46:58'),
(10, 1, 'Portal', 'fa09821cff552ccebd8121c00f32a1ca6df45a3c7d2546afc267b198294677b5', '::1', '2022-05-22 21:34:07', '2022-05-22 20:48:15'),
(11, 1, 'Portal', '74a2e315a1d7a121deca73b193f92ed03ad1dfc4a0e5691748d8e4769a85e466', '::1', '2022-05-23 08:33:55', '2022-05-23 08:28:13'),
(12, 1, 'Portal', '163a26769a480d837e978c6d2cc340b04b9a952a5dfd13838441df665fde7044', '::1', '2022-05-23 09:02:38', '2022-05-23 09:02:38'),
(13, 1, 'Portal', '32282a44e19ff1b6301077b480df1309a42b033c40cf6a0b3b9cfb7e61e1dc9e', '::1', '2022-05-23 19:21:48', '2022-05-23 19:21:48'),
(14, 1, 'Portal', '25e387c6bb4ad2f915b0aa179809eddb1c31576161810fea2a9d830fae06a66d', '::1', '2022-05-23 19:22:24', '2022-05-23 19:22:24'),
(15, 1, 'Portal', 'ceb7cf4f14d83ac40db1cbed5d85900e9609f1da534853a4bb95d98f8b7f68e4', '::1', '2022-05-23 20:14:54', '2022-05-23 19:56:16');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `phone`, `email`, `password`, `created_at`) VALUES
(1, 'admin', '8801797810793', 'admin@admin.com', '$2a$12$msQ8QnpfZYm3cnYt6ZdxGuaLMMz2emE54NsxoQBZganBophtEhfKq', '2022-05-18 11:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'User');

-- --------------------------------------------------------

--
-- Table structure for table `user_group_relation`
--

CREATE TABLE `user_group_relation` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_group_relation`
--

INSERT INTO `user_group_relation` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `website`
--

CREATE TABLE `website` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `website`
--

INSERT INTO `website` (`id`, `user_id`, `domain`, `created_at`) VALUES
(1, 1, 'abcd.com', '2022-05-22 13:31:48'),
(2, 1, 'alpha.net.bd', '2022-05-22 21:34:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acl`
--
ALTER TABLE `acl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `keys`
--
ALTER TABLE `keys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_relation`
--
ALTER TABLE `user_group_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website`
--
ALTER TABLE `website`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acl`
--
ALTER TABLE `acl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `keys`
--
ALTER TABLE `keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_group_relation`
--
ALTER TABLE `user_group_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `website`
--
ALTER TABLE `website`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

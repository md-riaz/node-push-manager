-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 20, 2022 at 03:42 PM
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
-- Table structure for table `app`
--

CREATE TABLE `app` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app`
--

INSERT INTO `app` (`id`, `user_id`, `name`, `created_at`) VALUES
(21, 1, 'riaz.dev.alpha.net.bd', '2022-06-10 12:23:58');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` mediumtext NOT NULL,
  `image` text DEFAULT NULL,
  `launch_url` varchar(255) DEFAULT NULL,
  `scheduled` datetime NOT NULL,
  `app_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `name`, `title`, `body`, `image`, `launch_url`, `scheduled`, `app_id`, `status`, `created_at`) VALUES
(8, 'push1', 'Push Manager', 'Message body', 'https://screenshot-proxy.netlify.app/f_avif,w_336/https://d33wubrfki0l68.cloudfront.net/62a2e3fcf5a7b40008f7c37c/screenshot_2022-06-10-06-26-36-0000.png', 'https://screenshot-proxy.netlify.app/f_avif,w_336/https://d33wubrfki0l68.cloudfront.net/62a2e3fcf5a7b40008f7c37c/screenshot_2022-06-10-06-26-36-0000.png', '2022-06-10 18:33:50', 21, 1, '2022-06-10 12:55:06'),
(9, 'MD RIAZ', 'Push msg', 'Push', '', '', '2022-06-14 20:36:00', 21, 1, '2022-06-14 20:35:28'),
(10, 'push49', 'Push from svelte', 'Have a coffee 😁‼️', '', '', '2022-06-15 18:50:00', 21, 1, '2022-06-15 12:49:44'),
(11, 'push49', 'Push Notification', 'Nazrul is a devs ‼️😁', 'https://avatars.githubusercontent.com/u/33659227?v=4', 'https://nazrul.dev.alpha.net.bd/', '2022-06-15 18:55:00', 21, 1, '2022-06-15 12:54:56'),
(12, 'nazrul', 'Nazrul', 'Nazrul is a dev ‼️😁', 'https://avatars.githubusercontent.com/u/33659227?v=4', 'https://nazrul.dev.alpha.net.bd/', '2022-06-15 09:58:00', 21, 0, '2022-06-16 12:57:32');

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
(2, '/api/apps');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `id` int(11) NOT NULL,
  `endpoint` text NOT NULL,
  `expirationTime` varchar(100) DEFAULT NULL,
  `app_id` int(11) NOT NULL,
  `auth` varchar(100) NOT NULL,
  `p256dh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`id`, `endpoint`, `expirationTime`, `app_id`, `auth`, `p256dh`) VALUES
(11, 'https://fcm.googleapis.com/fcm/send/fzxzn58yT1k:APA91bFOxOLdaYatmttAiZOY8oC08-8Q5ALsSlk9hPd9iKJmifXOYWtr1OHy8kN_VVpr7u-XbV9uXn0S3lbIHzT6o-BOlEgRPptuQE7yRBHnBq7HYKR7cUuBbv7TWRUspe6FavQD_V6y', NULL, 21, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `type` enum('Portal') NOT NULL,
  `value` varchar(64) NOT NULL,
  `ip_address` varchar(20) NOT NULL,
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
(15, 1, 'Portal', 'ceb7cf4f14d83ac40db1cbed5d85900e9609f1da534853a4bb95d98f8b7f68e4', '::1', '2022-05-23 20:14:54', '2022-05-23 19:56:16'),
(16, 1, 'Portal', '37bc713ca84cfd5c4dae8407ed0a6bb2b3088ed5bb98bffa80aaf75360bc9b5f', '::1', '2022-05-25 08:27:57', '2022-05-25 08:27:57'),
(17, 1, 'Portal', '9cd4cd3840fa1dc8aa323cbfb73ccd4bac938163decae6dc83dbd2cad15a38cb', '::1', '2022-05-25 08:33:57', '2022-05-25 08:33:57'),
(18, 1, 'Portal', '323c64d552a85891090978e4f4cf8c8cb5d2f80a4c5e567ed5e6379e9f42c46d', '::1', '2022-05-25 19:20:09', '2022-05-25 19:20:09'),
(19, 1, 'Portal', 'faee1697240299b32cac30d963a6dc24a489b98608738588ed79b4fc776b2cae', '::1', '2022-05-25 19:36:28', '2022-05-25 19:36:28'),
(20, 1, 'Portal', 'e5fab39dc639b063538c4e094b874c4ce2aff42aa25f4b2c72866ab3a1c03a48', '::1', '2022-05-25 19:37:04', '2022-05-25 19:37:04'),
(21, 1, 'Portal', 'b31eab90ce47a9a72d0d429048e2ad557b4b15af0d129af39d2ca9a82764403d', '::1', '2022-05-26 08:46:04', '2022-05-26 08:46:04'),
(22, 1, 'Portal', '9ef7d3522bf40c46140bb64c60d41e47210521d8b85cdbd2bb57e4acbe7056b8', '::1', '2022-05-26 18:19:18', '2022-05-26 18:00:12'),
(23, 1, 'Portal', '005ec33affcb6c7d54a47c4c1f2e804621b08a62afa49072f5bb71854c78279e', '::1', '2022-05-27 10:14:54', '2022-05-27 10:13:32'),
(24, 1, 'Portal', '0c6a760ef0f059a65bb653cb0b76ae0c2dbbe96ac8fbb45d102192a35ba1124d', '::1', '2022-05-27 11:17:10', '2022-05-27 10:25:17'),
(25, 1, 'Portal', '6ca743cce739d47386844d359a2bb8e27979b7f2dd0199170c3c53f6b72fa880', '::1', '2022-05-27 11:18:27', '2022-05-27 11:18:27'),
(26, 1, 'Portal', '10fb07da9b30ba9c94e08938410c059f63b2c0a0c13d61a271775cc7a4c11995', '::1', '2022-05-27 11:18:57', '2022-05-27 11:18:50'),
(27, 1, 'Portal', '76e34e6fa261c2d774876a09b41dcd158455ac0eb4737520d570b371fee2d5c1', '::1', '2022-05-27 11:31:27', '2022-05-27 11:31:27'),
(28, 1, 'Portal', '8391e5251aaebbe933eaaf3e8e4d33b8246700b9d484c18eab7cf04fa8b37877', '::1', '2022-05-27 11:48:15', '2022-05-27 11:48:15'),
(29, 1, 'Portal', '558ffcfe1da7c7040350eba03faa749141bdaa23da8d36b28fba28d737c080d1', '::1', '2022-05-27 14:44:40', '2022-05-27 14:44:40'),
(30, 1, 'Portal', 'eb6b700276b4a9fbf0bfaa8adbf2b1fda1575dca9dec9bd3a6a805d5f73ea32b', '::1', '2022-05-27 15:46:07', '2022-05-27 15:46:07'),
(31, 1, 'Portal', '9a221b73692a39a5411e7354c7f250eab1f318c170525a6290a734fa28f04ab3', '::1', '2022-05-27 16:39:50', '2022-05-27 16:39:50'),
(32, 1, 'Portal', '6aa52985630ea9c8a3673d8d09ca92ef33c1c37ab25f0d7e073f1179a182df5d', '::1', '2022-05-27 17:04:01', '2022-05-27 17:04:01'),
(33, 1, 'Portal', 'd68cd810f6d8b6c4030c5b55d54f820f9eab85ef1d0004b82544c4e368fbfc53', '::1', '2022-05-27 17:05:12', '2022-05-27 17:05:12'),
(34, 1, 'Portal', '6eb999259f3703eaa5e44b02921a1a356114dd3e103669f2de1e2dd30bf8e5a1', '::1', '2022-05-27 18:53:31', '2022-05-27 18:05:51'),
(35, 1, 'Portal', 'a30ae00a9e37969ac0e1d350ee2186b23cc89e5d6b38b4f6467dda1c06679751', '::1', '2022-05-27 20:28:16', '2022-05-27 20:04:19'),
(36, 1, 'Portal', '11d94c9af4d5a92315734971c333c3d40ac85844c83858a3be8d96de8112d531', '::1', '2022-05-28 18:37:20', '2022-05-28 18:37:11'),
(37, 1, 'Portal', '12b0456c684a3f121ea3dc31370dc3556d2540d9adde0f415454e3710237609b', '::1', '2022-05-28 20:48:46', '2022-05-28 20:07:42'),
(38, 1, 'Portal', '07ac0f82e6980480486d9b79755fd443b3c1d7b870c02ed3015ef7c7f92d8087', '::1', '2022-05-28 21:28:10', '2022-05-28 20:49:30'),
(39, 1, 'Portal', 'c7b2d2063761fe84feb1b48d12130976a0fa0ad3f607885f8f3ca6399a8b4952', '::1', '2022-05-29 08:27:04', '2022-05-29 08:27:04'),
(40, 1, 'Portal', '125b155f2f8002089e530a5afe629f26ab6af128e04d35915daefa8d534711f4', '::1', '2022-05-29 09:06:34', '2022-05-29 09:02:26'),
(41, 1, 'Portal', '7e52585decc6f8c18a438a17cd7a95ed45512f589e08c6b15a7dc2fe76f279ab', '::1', '2022-05-29 18:42:50', '2022-05-29 18:42:50'),
(42, 1, 'Portal', 'd05a35c9bcc045e4d284821231e2e4a339bc581458c28755fe6df4e7e935e1e4', '::1', '2022-05-29 19:31:07', '2022-05-29 19:27:47'),
(43, 1, 'Portal', 'e5385fd28389d131f26c1cf0d97897a54dae242906008a316f56211d9c59c306', '::1', '2022-05-29 19:35:44', '2022-05-29 19:35:44'),
(44, 1, 'Portal', '08cb20b5ed0fcbab8c8fccaf5ca3e38fb71f26b604dd04f4978a493541ba64bc', '::1', '2022-05-30 18:37:53', '2022-05-30 18:37:53'),
(45, 1, 'Portal', 'aca21221838b964c7ce0e22091fda602ece0647f45e09151955a41d080e844b6', '::1', '2022-05-30 20:06:21', '2022-05-30 19:54:24'),
(46, 1, 'Portal', 'bf0a39365063e32990344743090d9b2cbce2637e2b0b3be328e2d7db2b373a80', '::1', '2022-05-30 21:13:17', '2022-05-30 20:49:17'),
(47, 1, 'Portal', '2dafa7f11cdecb91b8355134e9a079c09a19ab95badfe1d856573e23d69aa378', '::1', '2022-05-30 21:13:33', '2022-05-30 21:13:33'),
(48, 1, 'Portal', 'dd1a817bf061b26a291c0ecfb3f8eb42d0c18b06f14504463e7e77bb5d12de9f', '::1', '2022-05-31 19:23:35', '2022-05-31 19:23:25'),
(49, 1, 'Portal', '180367abc29346c2bf98b277ba44c6174bde06854c833cca9685c2684978954c', '::1', '2022-05-31 21:18:24', '2022-05-31 21:15:05'),
(50, 1, 'Portal', 'f6a5aabdfeebb31deb5ffe16dda83ce898cbd9aea34a9c40f4552c546f5263d1', '::1', '2022-06-01 18:48:49', '2022-06-01 18:33:08'),
(51, 1, 'Portal', '3d97eea4fafd61e0ae90abe8a280e0ae5ab584939e4e0dd9a9c6259ff63eacd7', '::1', '2022-06-01 20:53:31', '2022-06-01 20:52:16'),
(52, 1, 'Portal', 'd12bdf98934c4d92dc49d831f9cdf869bdcc562b31b454845e7eb648b999cdfa', '::1', '2022-06-01 20:55:25', '2022-06-01 20:54:49'),
(53, 1, 'Portal', 'e8347b7a4b208f0d7bbe9645f1a55cdb2cb6a6708ccd81afb9a43f2b832adad8', '::1', '2022-06-01 20:55:33', '2022-06-01 20:55:33'),
(54, 1, 'Portal', '1596a4fa12154e93a0d297f06f096d440c4e4fccf3c62cff5b9d46902c1ff5eb', '::1', '2022-06-01 20:57:13', '2022-06-01 20:57:13'),
(55, 1, 'Portal', 'a401c6ad3dae4744118e2c88bd746b92c510aa8dfc1eb0e92cb5bd04d76b6be0', '::1', '2022-06-01 20:58:42', '2022-06-01 20:58:42'),
(56, 1, 'Portal', '4abc20c91b168a247bc8b9a5310396648034bfe51ad8701b509cfddc9982fb30', '::1', '2022-06-01 20:58:59', '2022-06-01 20:58:59'),
(57, 1, 'Portal', 'd693fb8def3d49f251e21a7b64d1bdc473146e3894d4d3ec388c64655b388351', '::1', '2022-06-04 19:21:06', '2022-06-04 18:39:27'),
(58, 1, 'Portal', 'edee47a7241fbae0d0e6b8f0ca7061b851b354e980bb4f229c5fc07726e9fb2e', '::1', '2022-06-06 19:19:14', '2022-06-06 19:19:14'),
(59, 1, 'Portal', 'adfefbee756b3ab5d09bdcb15002162e90f6ea476d83dda4bf564b5b03fe81f2', '::1', '2022-06-07 18:42:10', '2022-06-07 18:42:10'),
(60, 1, 'Portal', '71c60c4e0caf391bcd6ca231c18634cf6963a634153602dc76822356139fc1f3', '::1', '2022-06-07 19:31:36', '2022-06-07 19:23:14'),
(61, 1, 'Portal', '37fe1786754cf6533f82e8d3b965d1c43a1d44ba3736b12f4bfb5e5c9c804ac2', '::1', '2022-06-08 18:38:49', '2022-06-08 18:38:49'),
(62, 1, 'Portal', '7fd40354e0f9a6e47e65da5e08618500dd4c96f36db3949c3af947e92d4523ac', '::1', '2022-06-08 19:31:38', '2022-06-08 19:30:31'),
(63, 1, 'Portal', '5326ec02760b2ceba95c28e6563b894db57e6f404f8dcce742d2b4ccba8816d9', '::1', '2022-06-08 20:24:50', '2022-06-08 20:24:50'),
(64, 1, 'Portal', 'f73f13e76c2a6977950a293215ba05f5f5de742aedb80024c99a78345de5aa3d', '::1', '2022-06-09 08:51:25', '2022-06-09 08:51:25'),
(65, 1, 'Portal', 'be89ca3a16cedc2c1fa01a5be8339a8f933f810fc8683927aae729783066c776', '::1', '2022-06-09 14:01:09', '2022-06-09 13:55:22'),
(66, 1, 'Portal', 'dccb37c26ba772ab2bcb8714163608f94657bd0d7930c47ba4506db351d06ecc', '::1', '2022-06-09 19:15:14', '2022-06-09 19:15:14'),
(67, 1, 'Portal', '5dcce048886ddbcfcf32f030a6c38a413b23b1814704ba53c44fac7a09ba58ac', '::1', '2022-06-10 10:49:54', '2022-06-10 10:47:19'),
(68, 1, 'Portal', '9c440bed11e4ef21351095ee8acefbb5a8748353531a207ab8ab2cdc870b97e6', '::1', '2022-06-10 11:28:21', '2022-06-10 11:24:54'),
(69, 1, 'Portal', 'c41f2a7180b7220ad5267ae6a1c457be2b7f2acc567d1a8bd8d2b977a9a43504', '::1', '2022-06-10 12:23:58', '2022-06-10 11:58:28'),
(70, 1, 'Portal', '21666563da9f8ec39a7e3c3126e51d36b2ed2ad92d9e9ef8dd9f7bafc0473bc1', '::1', '2022-06-10 12:41:50', '2022-06-10 12:41:03'),
(71, 1, 'Portal', '3fad1315a4a2181e06e1033bfc17aadd22c88b71f562d75211960223f704548d', '::1', '2022-06-10 18:44:30', '2022-06-10 18:44:30'),
(72, 1, 'Portal', 'f6c045bf32ba98dd838ff0f193318dd5dad384772f711b29c69c8c66ea255288', '::1', '2022-06-12 18:36:24', '2022-06-12 18:36:10'),
(73, 1, 'Portal', '2673a814207848c5b802d80d0bfa26a90398fc1fe84861d649347f433ba3f860', '::1', '2022-06-12 18:39:19', '2022-06-12 18:39:19'),
(74, 1, 'Portal', '74ed6c79fb3102948a50ff9280545416bdd481578b1f2688dc6520e9212faa6b', '::1', '2022-06-12 18:49:32', '2022-06-12 18:49:32'),
(75, 1, 'Portal', 'eeeec9fcefb97579cdc704762b4a39aaf1ccfc95e1195ad6a6f2c6093a4cd844', '::1', '2022-06-12 18:50:15', '2022-06-12 18:50:15'),
(76, 1, 'Portal', 'e80a94ab8fde947727f710b9400e472739de8cf87a9d760143c8b4a8a0354fab', '::1', '2022-06-12 18:54:04', '2022-06-12 18:53:31'),
(77, 1, 'Portal', 'bd2874df15073852401b98f5a5c02ebaf114ccb0d9c7da0bcf5950989b43e04c', '::1', '2022-06-12 18:54:37', '2022-06-12 18:54:24'),
(78, 1, 'Portal', 'b831073c3e139d5f3eece237b51ecd31af40979d47eb3fe66664f0642f1ba41a', '::1', '2022-06-12 19:32:50', '2022-06-12 19:30:11'),
(79, 1, 'Portal', 'b084544dac6abca35886b998b3f693df8721ebdc8ee9371c00c12cfb750b8340', '::1', '2022-06-12 20:28:04', '2022-06-12 20:28:04'),
(80, 1, 'Portal', 'd6870b4026a9ff2b9f99f073d5c808b16d8b7ef4afe95c4666559f745627a988', '::ffff:127.0.0.1', '2022-06-13 19:02:13', '2022-06-13 19:02:13'),
(81, 1, 'Portal', 'c2795ecfc9ec7a16bb720c64a4f7107d5bf32c4886e3b1d533a05ce7c7b23cce', '::ffff:127.0.0.1', '2022-06-13 19:03:26', '2022-06-13 19:03:26'),
(82, 1, 'Portal', 'abf98d4badadc824199fd2f57cc0ec872f602c7bc2e767fd1108d887f0ca2f26', '::ffff:127.0.0.1', '2022-06-13 19:03:38', '2022-06-13 19:03:38'),
(83, 1, 'Portal', 'd1f0350f83dfe118f93003c9083f12fc88a58bf0ccbc036dd57587903429eab5', '::ffff:127.0.0.1', '2022-06-13 19:03:41', '2022-06-13 19:03:41'),
(84, 1, 'Portal', '060a74aa93adcfcbd6a524520a4fecdbd62f5bced3190ab616f4207056a5b3c7', '::ffff:127.0.0.1', '2022-06-13 19:16:56', '2022-06-13 19:16:56'),
(85, 1, 'Portal', 'ad7cd84bd6ee81390c4ea007567a560f35c68be8be8cd9d07122a8dc87844c64', '::ffff:127.0.0.1', '2022-06-13 19:19:48', '2022-06-13 19:19:48'),
(86, 1, 'Portal', 'dd343d69693d5cf20ba488950b997de66a3b35fbc540f219665ee0ca96a8eb62', '::ffff:127.0.0.1', '2022-06-13 19:19:49', '2022-06-13 19:19:49'),
(87, 1, 'Portal', '0ad53d41dac25f4738f22be5d53613494fd7a1ab2f6763bb4ff0f9bb7f1c0531', '::ffff:127.0.0.1', '2022-06-13 19:30:53', '2022-06-13 19:30:53'),
(88, 1, 'Portal', 'a5dd4c0f912d6fa643ecfe99e38480af84ae7860a1e664d92d5baab5f81c46a7', '::1', '2022-06-14 18:45:37', '2022-06-14 18:45:36'),
(89, 1, 'Portal', '9eb78ae9e7a647ef9ecf0068257d0d7f0f870c70b6e91ff909ddb89c70445568', '::1', '2022-06-14 18:52:56', '2022-06-14 18:51:39'),
(90, 1, 'Portal', '89c8c451e6bc9af4c413cda07d3a6d2792ed42123bcd8c2ab2f22ee9d88d0cf3', '::1', '2022-06-14 18:56:00', '2022-06-14 18:56:00'),
(91, 1, 'Portal', '0abeebb1e613317439c8fa4d8872b7211398cf4e91799e7a3b11071730f78459', '::1', '2022-06-14 18:56:50', '2022-06-14 18:56:50'),
(92, 1, 'Portal', 'f393e15db8fad8dbfac56f832350ac6db3023fa0e07115426ac6ee9f780fb6b9', '::1', '2022-06-14 18:57:24', '2022-06-14 18:57:24'),
(93, 1, 'Portal', 'edbaa530ead8fce77619ef8c29550113711919a12f6fc7a48fc3c75ea28bf9fa', '::1', '2022-06-14 18:58:02', '2022-06-14 18:58:02'),
(94, 1, 'Portal', '346771337fa6be15765bd754d3ce75eb407d0fa6dfc3e2d89ff2d902f748ec8a', '::1', '2022-06-14 18:59:18', '2022-06-14 18:59:18'),
(95, 1, 'Portal', 'b8fec5e63cd86eb00250ec6aac957b9d077fd8f220d13bbb4291976f4ab01c25', '::1', '2022-06-14 19:02:26', '2022-06-14 19:02:26'),
(96, 3, 'Portal', '3bc522d82565b58378d555368c73f0a2e51045cc7377b91f15820ee8aac168a5', '::1', '2022-06-14 19:04:20', '2022-06-14 19:04:20'),
(97, 1, 'Portal', 'dd615b24d9f2fb01a76483c404ff9f33fc3c2c31b857a6231af39c921bec8476', '::1', '2022-06-14 20:35:02', '2022-06-14 20:35:02'),
(98, 1, 'Portal', '463dbaa2f3ef60244f5aab76f8e50903a8b0d08b4480aa86c72b4ae906d2d83e', '203.190.34.64', '2022-06-15 12:51:48', '2022-06-15 12:47:48'),
(99, 1, 'Portal', '8aaa029e3096de885ae8265eaaa53bd4f1d5eb7cfd7712669e0e08eb380a18c6', '203.190.34.64', '2022-06-15 12:52:59', '2022-06-15 12:52:58');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `phone`, `email`, `password`, `status`, `created_at`) VALUES
(1, 'admin', '8801797810793', 'admin@admin.com', '$2a$12$msQ8QnpfZYm3cnYt6ZdxGuaLMMz2emE54NsxoQBZganBophtEhfKq', 1, '2022-05-18 11:07:18'),
(3, 'test1', '8801777777777', 'test1@gmail.com', '$2a$12$msQ8QnpfZYm3cnYt6ZdxGuaLMMz2emE54NsxoQBZganBophtEhfKq', 1, '2022-06-13 19:35:54'),
(4, 'Jaquelyn Mccormick', '8801966666666', 'vaqyr@mailinator.com', '$2b$12$IlOYxwRgTNzayHjD.WCXA.xnPP0s76tOWurWJcdNIDFfttY2NJF3C', 1, '2022-06-13 20:36:54'),
(5, 'Rhona Osborn', '8801633336694', 'lyticu@mailinator.com', '$2b$12$Rg0Cykyy0/oueNCQzPkOg.zI6.3TZW9MhpcUk/zig.KFI1UfjLHf2', 1, '2022-06-13 20:42:49');

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
(1, 1, 1),
(2, 3, 2),
(3, 4, 2),
(4, 5, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acl`
--
ALTER TABLE `acl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `app`
--
ALTER TABLE `app`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_id` (`app_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_id` (`app_id`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acl`
--
ALTER TABLE `acl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app`
--
ALTER TABLE `app`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_group_relation`
--
ALTER TABLE `user_group_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acl`
--
ALTER TABLE `acl`
  ADD CONSTRAINT `acl_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `acl_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `acl_ibfk_3` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`);

--
-- Constraints for table `app`
--
ALTER TABLE `app`
  ADD CONSTRAINT `app_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`);

--
-- Constraints for table `subscription`
--
ALTER TABLE `subscription`
  ADD CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`);

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `token_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`);

--
-- Constraints for table `user_group_relation`
--
ALTER TABLE `user_group_relation`
  ADD CONSTRAINT `user_group_relation_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `user_group_relation_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

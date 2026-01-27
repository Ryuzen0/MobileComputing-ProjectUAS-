-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 27 Jan 2026 pada 13.19
-- Versi server: 10.11.14-MariaDB-cll-lve
-- Versi PHP: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tify9948_myNotes`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1, 'Pribadi', '2026-01-23 19:22:00'),
(2, 'Kuliah', '2026-01-23 19:22:00'),
(3, 'Pekerjaan', '2026-01-23 19:22:00'),
(4, 'Penting', '2026-01-23 19:22:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `notes`
--

INSERT INTO `notes` (`id`, `user_id`, `category_id`, `title`, `content`, `image`, `created_at`) VALUES
(11, 1, NULL, 'zxczxc', 'zxczxcz', 'xczxczxc', '2026-01-23 21:42:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `todos`
--

CREATE TABLE `todos` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `is_done` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `token`, `created_at`) VALUES
(1, 1, 'a651b8c4e132802f45a77c86b3e26319', '2026-01-19 09:05:00'),
(2, 1, '95bfdc17f8cf180676b40b051512a254', '2026-01-19 09:19:07'),
(3, 1, '7032fb5438c0484094221291039bced6', '2026-01-20 04:31:20'),
(4, 1, '5be030affdc3a20f1b2d6a5b19049362', '2026-01-20 04:35:56'),
(5, 1, '93e2233472e744c811ac1aeb7fa23164', '2026-01-21 13:12:40'),
(6, 1, '63b87750dea091bd2f76a9cc5d401049', '2026-01-21 13:16:14'),
(7, 1, '7e257af49833618d622fc8537b90f9fc', '2026-01-21 13:17:24'),
(8, 1, '80db298359e9825e3e949f69995978d8', '2026-01-21 13:17:47'),
(9, 1, '064a7af19b4af0beb567d6c61a8dd37a', '2026-01-21 13:23:41'),
(10, 3, '6aa927bcc2f21518632b49b161fd5b08', '2026-01-22 13:55:24'),
(11, 1, 'c7e871362cd6855e76089fabd26d7b36', '2026-01-23 17:29:50'),
(12, 1, 'df343ddb60d72754e16aced4604209a8', '2026-01-23 18:31:01'),
(13, 1, '790cee9b2a5836ee7d6387a0938b7064', '2026-01-23 18:38:00'),
(14, 1, '2c1090b4f7d94c8d15f5bcad81314cdb', '2026-01-23 19:10:49'),
(15, 1, 'c3170775ac508e931d1fc89b63192e5b', '2026-01-23 19:17:49'),
(16, 1, '1f003146c4ec4262279ded3ac0c23beb', '2026-01-23 19:43:02'),
(17, 1, '49597140730d27f82e6eb01c15ac5d53', '2026-01-23 20:03:30'),
(18, 4, '94c03992cd85719d82110cdf04725f02', '2026-01-23 20:07:39'),
(19, 4, '4affbdbf5eb3d4c6f6f6724ea7a4ce7c', '2026-01-23 20:10:30'),
(20, 1, 'ec9fd03f66d6be295fb46395649042f0', '2026-01-23 20:11:40'),
(21, 1, '3738a6d8a304d2c1ae7520f98d87de4c', '2026-01-23 20:19:06'),
(22, 5, '840b15d935c7a4ba17a3c1b6f67e66e2', '2026-01-23 20:22:52'),
(23, 1, '72dcb692480a33faed96746d91d27c39', '2026-01-23 20:25:43'),
(24, 1, '335fe6c916dafbfb316e9506515c701c', '2026-01-23 20:26:51'),
(25, 1, 'b9554fc7fd470fcbb178ecde03fc7ad1', '2026-01-23 20:48:27'),
(26, 1, '82bff7649e9666b823a6f18bf86cb28f', '2026-01-23 21:08:12'),
(27, 7, 'e3145dd978db8288cc0c5b1fca9948f2', '2026-01-23 21:14:47'),
(28, 1, '8cbd3f2cedf767cd4bd5d0680ae4297e', '2026-01-23 21:28:43'),
(29, 1, '8d144d14176bdd0dfbdc6b73b5040d9d', '2026-01-23 21:28:56'),
(30, 1, '98692ec9f9e53658191d5f3d9168c851', '2026-01-23 21:34:57'),
(31, 1, '7a5870a3f5ec3f0c8bb2d94794f7e67b', '2026-01-23 21:39:41'),
(32, 1, '965c4a9ea968669df34e4a4ab6c45112', '2026-01-23 21:41:47'),
(33, 1, '3013e0b50ea60d54f0820f6855090a73', '2026-01-24 03:35:39'),
(34, 1, 'da5b0705793e97765a37b3f0b266dc65', '2026-01-24 03:48:20'),
(35, 1, 'e033893f0e27ada417de392fdd12975b', '2026-01-24 03:50:43'),
(36, 1, '5e84c6f2a3f01a3bddbd52c5961a37a6', '2026-01-24 03:57:18'),
(37, 1, 'c95d3aff5d9f1c3a5b2201f134364ccb', '2026-01-24 04:26:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'tommy', 'tommy@gmail.com', '$2y$10$rvrpXvJY.ahtZiApCgV/eOxrzK4hmhLITOA53A1falPEfqcorTETa', '2026-01-19 09:04:48'),
(2, 'Afri Yudha', 'twtwt', '$2y$10$84vNqL5oEnH36ndkTU8JGOCU3dvpV5jy2hxwSc17pDm59yaWGEdrC', '2026-01-22 13:54:45'),
(3, 'Afri Yudha', 'test@gmail.com', '$2y$10$RySasYDniQ5ULzlY6B9jueSu9jJtfmH91iI4aap/KYlL4xup1ZNnW', '2026-01-22 13:55:12'),
(4, 'asdasd', 'asdasd@gmail.com', '$2y$10$h.nRdpL5TzzfjyJRcO3cbebdWKIlJ2jEiydZQNnWgIKIRUjp1aPu.', '2026-01-23 20:02:23'),
(5, 'asdasdasdas', 'kiri@gmail.com', '$2y$10$V8KEBkWOSDaIcQm/6klyjubH9rMAJGwiaVNVA6nCERtMMBX3PVMb2', '2026-01-23 20:22:43'),
(6, 'asdasd', 'asdasdas', '$2y$10$A1/qlfcWmKyWdGzN4OylWuv8slVnRMf8ljRbOI7Ic59A3j6DJ99xG', '2026-01-23 21:09:02'),
(7, 'kanan', 'kanan@gmail.com', '$2y$10$v8Tmw1ycnMWGdtUMEbm96.Pq06kEgMOt/K50mBpgGpf9UxWc8MdJy', '2026-01-23 21:14:37'),
(8, 'asdasdas', 'asdasda@gmail.com', '$2y$10$acyYxb7LgNsmcQKg3Zg7G..poufvNaVHSEC23OF0/2AGLjtiO/t92', '2026-01-23 21:35:32');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notes_users` (`user_id`),
  ADD KEY `fk_notes_categories` (`category_id`);

--
-- Indeks untuk tabel `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tokens_users` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `fk_notes_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_notes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `todos`
--
ALTER TABLE `todos`
  ADD CONSTRAINT `todos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `fk_tokens_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

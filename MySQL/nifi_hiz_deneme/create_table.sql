CREATE TABLE `nifi_aktarim_hizi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aktarilan_satir_sayisi` bigint(21) DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `finished_at` datetime(6) DEFAULT NULL,
  `sure_dakika` decimal(22,1) DEFAULT NULL,
  `satir_dakika` decimal(22,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=789172 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




--

CREATE SCHEMA IF NOT EXISTS `renthouse` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `renthouse`;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images` text COLLATE utf8mb4_unicode_ci,
  `owner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted_date` date DEFAULT NULL,
  `total_images` int DEFAULT '1',
  `rooms` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` int DEFAULT NULL,
  `balcony` int DEFAULT NULL,
  `area` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_floor` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_floors` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `furnished` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amenities` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES 
(1,'Modern Flats and Apartments','Ho Chi Minh, Quan 1','15 lac','images/house-img-1.webp','images/house-img-1.webp,images/hall-img-1.webp,images/kitchen-img-1.webp,images/bathroom-img-1.webp','John Deo','1234567890','flat','sale','2022-11-10',4,'2 BHK','0','ready to move',3,2,1,'750sqft','3 years','3','22','semi-furnished','available','lifts,security guards,gardens,water supply,power backup,parking area,shopping mall,hospital,schools,market area','Modern flat in prime location with excellent amenities.'),
(2,'Luxury House','Hanoi, Dong Da','20 lac','images/house-img-2.webp','images/house-img-2.webp,images/hall-img-2.webp,images/kitchen-img-2.webp,images/bathroom-img-2.webp','Jane Doe','1112223333','house','sale','2022-11-10',1,'3 BHK','500000','ready to move',4,3,2,'1000sqft','5 years','1','10','furnished','available','lifts,gardens,water supply,parking area','Luxury house with modern design and spacious interiors.'),
(3,'Beachfront Apartment','Khanh Hoa, Nha Trang','18 lac','images/house-img-3.jpg','images/house-img-3.jpg,images/hall-img-3.webp,images/kitchen-img-3.webp,images/bathroom-img-3.webp','John Deo','1234567890','flat','sale','2022-11-10',1,'2 BHK','0','ready to move',3,2,1,'750sqft','2 years','5','15','semi-furnished','available','lifts,security guards,gardens,water supply','Cozy apartment near the beach with stunning views.'),
(4,'City View Flat','Ho Chi Minh, Quan 2','17 lac','images/house-img-4.webp','images/house-img-4.webp,images/hall-img-4.webp,images/kitchen-img-4.webp,images/bathroom-img-4.jpg','John Deo','1234567890','flat','sale','2022-11-10',1,'2 BHK','0','ready to move',3,2,1,'750sqft','4 years','7','20','semi-furnished','available','lifts,security guards,water supply,parking area','Modern flat with panoramic city views.'),
(5,'Seaside Apartment','Quy Nhon, Binh Dinh','16 lac','images/house-img-5.webp','images/house-img-5.webp,images/hall-img-5.webp,images/kitchen-img-5.webp,images/bathroom-img-5.webp','John Deo','1234567890','flat','sale','2022-11-10',1,'2 BHK','0','ready to move',3,2,1,'750sqft','3 years','4','18','semi-furnished','available','lifts,gardens,water supply,parking area','Comfortable seaside apartment with modern facilities.'),
(6,'Urban Flat','Hanoi, Cau Giay','19 lac','images/house-img-6.webp','images/house-img-6.webp,images/hall-img-6.webp,images/kitchen-img-6.webp,images/bathroom-img-6.jpg','John Deo','1234567890','flat','sale','2022-11-10',1,'2 BHK','0','ready to move',3,2,1,'750sqft','3 years','6','25','semi-furnished','available','lifts,security guards,gardens,water supply,parking area','Modern flat in vibrant urban area with excellent connectivity.'),
(21,'Modern Apartment','Dong Nai','200000 VND','https://th.bing.com/th/id/OIP.-R0RrcfyXBRrtMmIxgSXywHaE8?w=299&h=199&c=7&r=0&o=5&dpr=1.3&pid=1.7','','thuan1@gmail.com',NULL,'flat','sale','2025-06-01',1,'','','ready',1,1,0,'2000','2','1','2','unfurnished','yes','\'2\', \'Luxury House\', \'Hanoi, Dong Da\', \'20 lac\', \'images/house-img-2.webp\', \'images/house-img-2.webp,images/hall-img-2.webp,images/kitchen-img-2.webp,images/bathroom-img-2.webp\', \'Jane Doe\', \'1112223333\', \'house\', \'sale\', \'2022-11-10\', \'1\', \'3 BHK\', \'500000\', \'ready to move\', \'4\', \'3\', \'2\', \'1000sqft\', \'5 years\', \'1\', \'10\', \'furnished\', \'available\', \'lifts,gardens,water supply,parking area\', \'Luxury house with modern design and spacious interiors.\'',''),
(22,'Modern Apartment','Dong Nai','200000 VND','https://th.bing.com/th/id/OIP.-R0RrcfyXBRrtMmIxgSXywHaE8?w=299&h=199&c=7&r=0&o=5&dpr=1.3&pid=1.7','','thuan2@gmail.com',NULL,'flat','sale','2025-06-01',1,'','','ready',1,1,0,'2000','2','1','2','unfurnished','yes','\'2\', \'Luxury House\', \'Hanoi, Dong Da\', \'20 lac\', \'images/house-img-2.webp\', \'images/house-img-2.webp,images/hall-img-2.webp,images/kitchen-img-2.webp,images/bathroom-img-2.webp\', \'Jane Doe\', \'1112223333\', \'house\', \'sale\', \'2022-11-10\', \'1\', \'3 BHK\', \'500000\', \'ready to move\', \'4\', \'3\', \'2\', \'1000sqft\', \'5 years\', \'1\', \'10\', \'furnished\', \'available\', \'lifts,gardens,water supply,parking area\', \'Luxury house with modern design and spacious interiors.\'','');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'student',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES 
(7,'thuan@gmail.com','thuan@gmail.com','123456','staff','0337030071'),
(9,'thuan1@gmail.com','thuan1@gmail.com','123456','landlord','0337030072'),
(10,'thuan3@gmail.com','thuan3@gmail.com','123456','student','0337030073'),
(11,'thuan2@gmail.com','thuan2@gmail.com','123456','landlord','0337030074');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `student_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landlord_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES 
(11,21,'thuan3@gmail.com','thuan1@gmail.com','2025-06-01','pending'),
(12,1,'thuan3@gmail.com','John Deo','2025-06-01','pending');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

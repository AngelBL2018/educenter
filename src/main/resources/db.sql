/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.21-0ubuntu0.17.10.1 : Database - eduCenter
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`eduCenter` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `eduCenter`;

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `duration` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `lecturer` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `subject` */

insert  into `subject`(`id`,`name`,`duration`,`price`,`lecturer`) values (4,'java ',100,2000,'Karen Gasparyan'),(5,'js',50,1500,'Gurgen Poxosyan'),(6,'matem',70,80000,'Simonyan Vardan');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('MANAGER','STUDENT') NOT NULL DEFAULT 'STUDENT',
  `verify` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`surname`,`email`,`password`,`user_type`,`verify`,`token`) values (1,'manager','manager','manager@mail.com','$2a$10$VBhsRzjR5z2VLImN7exCkOPsTkcgGgW1JNLHJGD4bv9oiQATO00l2','MANAGER',1,NULL),(2,'poxos','poxosyan','poxos@mail.com','$2a$10$q9J8qxdYviGRuvjuT3QBKuaEY4N4LeXxDWNrDLScye1f2NnIkXaWK','STUDENT',0,NULL),(4,'Ash','Ash','ash@mail.com','$2a$10$TZ9PzMPV8CjnmGnms4CDbeUjrzE/pGLP6dYDDn3ZF1A9pMvmDW2ae','STUDENT',0,NULL),(5,'Vardan','Vardanyan','vardan@mail.com','$2a$10$B6Nw2nd.ODSBiwlCiZ8fUOj0o8OOEXQxJJQC9kGofiHw.Mgb8alpS','STUDENT',0,NULL),(7,'lus','lusyan','lus@mail.com','$2a$10$z929TVikFSo2tdQ1gwhfpuq9hByPzmtJva/n.2ucsqFlIYBGUqu5W','STUDENT',0,'4e37a8f4-4850-464c-a569-9c9b8b2d7cc4'),(12,'ara','arayan','angelakarapetyan93@gmail.com','$2a$10$EDriISEVFqgeDOQ9JhFJruCsv.8A0YDNbmDxMGv70a2kE16MUpMaK','STUDENT',1,NULL);

/*Table structure for table `user_subject` */

DROP TABLE IF EXISTS `user_subject`;

CREATE TABLE `user_subject` (
  `user_id` int(11) unsigned NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `user_subject_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_subject_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_subject` */

insert  into `user_subject`(`user_id`,`subject_id`) values (4,6),(2,5),(2,6),(5,6);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

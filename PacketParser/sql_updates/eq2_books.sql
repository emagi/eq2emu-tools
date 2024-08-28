DROP TABLE IF EXISTS `raw_books`;
CREATE TABLE `raw_books` (
  `id` TINYINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `spawn_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `book_title` VARCHAR(100) NOT NULL,
  `unknown` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `book_type` VARCHAR(100) NOT NULL,
  `unknown2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `unknown3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `unknown4` INT(10) NOT NULL DEFAULT '0',
  `unknown5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `data_version` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `log_file` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `NewIndex` (`spawn_id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `raw_book_images`;
CREATE TABLE `raw_book_images` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `spawn_id` INT(10) UNSIGNED NOT NULL,
  `image_file` VARCHAR(255) DEFAULT NULL,
  `image_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `unknown6` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY  (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `raw_book_pages`;
CREATE TABLE `raw_book_pages` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `spawn_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `page_text` VARCHAR(1024) DEFAULT NULL,
  `page_text_valign` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `page_text_halign` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY  (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

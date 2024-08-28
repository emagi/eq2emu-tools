TRUNCATE `raw_item_appearances`;
TRUNCATE `raw_item_classes`;
TRUNCATE `raw_item_descriptions`;
TRUNCATE `raw_item_details_armor`;
TRUNCATE `raw_item_details_armorset`;
TRUNCATE `raw_item_details_bag`;
TRUNCATE `raw_item_details_bauble`;
TRUNCATE `raw_item_details_book`;
TRUNCATE `raw_item_details_food`;
TRUNCATE `raw_item_details_house`;
TRUNCATE `raw_item_details_house_container`;
TRUNCATE `raw_item_details_pattern`;
TRUNCATE `raw_item_details_range`;
TRUNCATE `raw_item_details_recipe`;
TRUNCATE `raw_item_details_recipe_items`;
TRUNCATE `raw_item_details_shield`;
TRUNCATE `raw_item_details_skills`;
TRUNCATE `raw_item_details_thrown`;
TRUNCATE `raw_item_details_weapon`;
TRUNCATE `raw_item_effects`;
TRUNCATE `raw_item_sets`;
TRUNCATE `raw_item_sets_effects`;
TRUNCATE `raw_item_sets_stats`;
TRUNCATE `raw_item_skill_classes`;
TRUNCATE `raw_item_stats`;
TRUNCATE `raw_items`;
ALTER TABLE `raw_items` ADD `item_id` INT DEFAULT '0' NOT NULL AFTER `id`;
ALTER TABLE `raw_items` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL;
ALTER TABLE `raw_items` DROP PRIMARY KEY;
ALTER TABLE `raw_items` ADD PRIMARY KEY (`id`);
ALTER TABLE `raw_items` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `raw_items` AUTO_INCREMENT = 1;
ALTER TABLE `raw_items` ADD UNIQUE `ItemIDLanguageTypeIDX` (`item_id`, `language_type`);
ALTER TABLE `raw_items` CHANGE `menu_type` `menu_type` SMALLINT UNSIGNED DEFAULT '3' NOT NULL;
ALTER TABLE `raw_items` DROP `sub_type`;

TRUNCATE `raw_spell_details`;
TRUNCATE `raw_spell_effects`;
TRUNCATE `raw_spell_levels`;
TRUNCATE `raw_spells`;
ALTER TABLE `raw_spells` ADD `spell_id` INT UNSIGNED DEFAULT '0' NOT NULL AFTER `id`;
ALTER TABLE `raw_spells` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL;
ALTER TABLE `raw_spells` DROP PRIMARY KEY;
ALTER TABLE `raw_spells` ADD PRIMARY KEY (`id`);
ALTER TABLE `raw_spells` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `raw_spells` AUTO_INCREMENT = 1;
ALTER TABLE `raw_spells` ADD UNIQUE `SpellLanguageTypeIDX` (`spell_id`, `tier`, `language_type`);

DELETE FROM `raw_collections`;
ALTER TABLE `raw_collections` ADD `id` INT UNSIGNED DEFAULT '0' NOT NULL FIRST;
ALTER TABLE `raw_collections` ADD PRIMARY KEY (`id`);
ALTER TABLE `raw_collections` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;


ALTER TABLE `raw_items` ADD `data_version` SMALLINT(5) UNSIGNED NOT NULL AFTER `log_file`;
ALTER TABLE `raw_spells` ADD `data_version` SMALLINT(5) UNSIGNED NOT NULL AFTER `log_file`;
ALTER TABLE `raw_quests` ADD `data_version` SMALLINT(5) UNSIGNED NOT NULL AFTER `log_file`;
ALTER TABLE `raw_spawns` ADD `data_version` SMALLINT(5) UNSIGNED NOT NULL AFTER `log_file`;

ALTER TABLE `raw_items` ADD COLUMN `populate_item_id` INT(10) UNSIGNED DEFAULT '0' NOT NULL AFTER `processed`;
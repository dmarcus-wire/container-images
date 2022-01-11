CREATE TABLE `Item` (`id` BIGINT not null auto_increment primary key, `description` VARCHAR(100), `done` INT);
INSERT INTO `Item` (`id`, `description`, `done`) VALUES (1, 'pickup trash', 0);
INSERT INTO `Item` (`id`, `description`, `done`) VALUES (2, 'buy lottery tix', 1);

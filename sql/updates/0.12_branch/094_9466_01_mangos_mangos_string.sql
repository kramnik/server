ALTER TABLE db_version CHANGE COLUMN required_093_9385_01_mangos_command required_094_9466_01_mangos_mangos_string bit;

DELETE FROM mangos_string WHERE entry=60;

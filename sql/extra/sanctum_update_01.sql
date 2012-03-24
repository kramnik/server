-- Sanctum updates

-- ##### Creature template addon 4277 #####
-- Eye of Kilrogg aura
DELETE FROM `creature_template_addon` WHERE (`entry`=4277);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `emote`, `moveflags`, `auras`) VALUES (4277, 0, 0, 1, 0, 0, 2585);

-- ##### Quest 10162 #####
-- quest 10162 spell target area
delete from spell_area where spell=33836;
insert into spell_area values
(33836,3803,0,0,0,0,0,2,0);

-- ##### Quest 10211 #####
-- speed update for npc_khadgars_servant
UPDATE `creature_template` SET `speed_walk` = 2 WHERE `entry` = 19685;

-- ##### Quest 10909 #####
-- Anchorite Relic Bunny - dummy aura
-- ToDo: summon 22454 (by spell 39206) when aura is removed by death
DELETE FROM `creature_template_addon` WHERE (`entry`=22444);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (22444, 0, 0, 0, 0, 0, 0, 39184);
-- spell script targets
delete from spell_script_target where entry in (39206,39184);
insert into spell_script_target values
(39206, 1, 22444),
(39184, 1, 16878);



-- ToDo: add DB script for quest 9923 - use gameobject 182521 as a starting point
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
-- speed update for npc_khadgars_servant (workaround, original walk speed = 1.125)
UPDATE `creature_template` SET `speed_walk`=1.14286 WHERE `entry` = 19685;

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

-- ### Quest 10838 ####
UPDATE creature_template SET npcflag=npcflag|1 WHERE entry=22258;
UPDATE `creature_template` SET `MovementType` = 0 WHERE `entry` IN (22267,22258);

-- ### Quest 6144 - Missing NPCs ###
-- Varimathras
DELETE FROM creature WHERE id=2425;
INSERT INTO creature (`id`,`map`,`spawnMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(2425, 0, 1, 0, 0, 1287.7, 333.589, -59.9998, 0.959931, 180, 0, 0, 18900, 0, 0, 0);

-- ### Quest 5902/5904 ###
-- Missing GO
DELETE FROM `gameobject` WHERE `id`=177491;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(177491, 0, 1, 2449.43, -1662.39, 104.37, 2.18166, 0, 0, 0.88701, 0.461749, -180, 255, 1);
Delete from gossip_menu_option where menu_id=4362;
insert into gossip_menu_option values
(4362,0,0,'Put the barrel of termites on this box.',1,1,-1,0,4362,0,0,'',2,15044,1,9,5902,0,0,0,0,0),
(4362,1,0,'Put the barrel of termites on this box.',1,1,-1,0,4362,0,0,'',2,15044,1,9,5904,0,0,0,0,0);
delete from gossip_scripts where id=4362;
insert into gossip_scripts values
(4362,0,9,0,60,177491,5,0,0,0,0,0,0,0,0,0,'Respawn Termite Barrel');

-- ### Quest 9444 ###
-- High Priest Thel'danis fix
Delete from creature_ai_texts where entry=-581;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-581','By the Light, you will leave this tomb!','0','0','0','1854','0');
UPDATE creature_ai_scripts SET action1_param1=-581 WHERE id=185402;
-- Uther
UPDATE creature_template SET MovementType=0, unit_flags=unit_flags|33600, InhabitType=InhabitType|4  WHERE entry=17233;
UPDATE `quest_template` SET `ReqSpellCast1` = 0 WHERE `entry` = 9444;
-- Quest script
delete from db_script_string where entry in (2000009001,2000009002,2000009003,2000009004);
insert into db_script_string (entry, content_default) values
(2000009001,'Why do you do this? Did I somehow wrong you in life?'),
(2000009002,'Ah, I see it now in your mind. This is the work of one of my former students... Mehlar Dawnblade. It is sad to know that his heart has turned so dark.'),
(2000009003,'Return to him. Return to Mehlor and tell him that I forgive him and that I understand why he believes what he does.'),
(2000009004,'I can only hope that he will see the Light and instead turn his energies to restoring once-beautiful Quel\'Thalas.');
-- Script id: 10561
DELETE FROM event_scripts WHERE id=10561;
INSERT INTO event_scripts VALUES 
(10561,0,10,17233,60000,17253,10,0,0,0,0,0,972.96,-1824.82,82.54,0.27,'Summon Ghost of Uther Lightbringer'),
(10561,8,0,0,0,17233,10,0,2000009001,0,0,0,0,0,0,0,'Ghost of Uther Lightbringer - Say Text'),
(10561,16,0,0,0,17233,10,0,2000009002,0,0,0,0,0,0,0,'Ghost of Uther Lightbringer - Say Text'),
(10561,30,0,0,0,17233,10,0,2000009003,0,0,0,0,0,0,0,'Ghost of Uther Lightbringer - Say Text'),
(10561,43,0,0,0,17233,10,0,2000009004,0,0,0,0,0,0,0,'Ghost of Uther Lightbringer - Say Text');
-- spell script target
delete from spell_script_target where entry=30098;
insert into spell_script_target values
(30098,0,181653);

-- ### Pet trainer fix
UPDATE `creature_template` SET `trainer_class` = 3 WHERE `entry` = 16675;

-- ### Quest 411 ###
-- fix typo
DELETE FROM `quest_end_scripts` WHERE `id`=411;
INSERT INTO `quest_end_scripts` VALUES
(411, 2, 15, 7673, 0, 0, 0, 4, '0', '0', '0', '0', 0, 0, 0, 0, 'Bethor use Nether Gem'),
(411, 7, 10, 5666, 23000, 0, 0, 0, '0', '0', '0', '0', 1768.58, 55.4891, -46.3198, 2.28248, 'Summon Visage'),
(411, 23, 0, 0, 0, 5666, 10, 16, '2000000210', '0', '0', '0', 0, 0, 0, 0, 'Visage Say 3'),
(411, 23, 1, 2, 0, 5666, 10, 0, '0', '0', '0', '0', 0, 0, 0, 0, ''),
(411, 30, 0, 0, 0, 1498, 10, 0, '2000000211', '0', '0', '0', 0, 0, 0, 0, 'Bethor Say');

-- ### Quest 10162/10163 ###
update item_template set area=0 where entry=28132;

-- ### Quest 8346 ###
-- Rewrite all scripts for npcs
DELETE FROM creature_ai_scripts WHERE creature_id=15274;
INSERT INTO creature_ai_scripts VALUES 
('1527401','15274','8','0','100','0','28734','-1','0','0','33','15468','6','0','0','0','0','0','0','0','0','0','Mana Wyrm - Killed Credit for Sunstrider Mana Tap Counter');
DELETE FROM creature_ai_scripts WHERE creature_id=15294;
INSERT INTO creature_ai_scripts VALUES 
('1529401','15294','8','0','100','0','28734','-1','0','0','33','15468','6','0','0','0','0','0','0','0','0','0','Mana Wyrm - Killed Credit for Sunstrider Mana Tap Counter'),
('1529402','15294','2','0','100','1','50','0','15300','22900','11','31325','0','0','0','0','0','0','0','0','0','0','Feral Tender - Cast Renew at 50% HP');
DELETE FROM creature_ai_scripts WHERE creature_id=15273;
INSERT INTO creature_ai_scripts VALUES 
('1527301','15273','8','0','100','0','28734','-1','0','0','33','15468','6','0','0','0','0','0','0','0','0','0','Mana Wyrm - Killed Credit for Sunstrider Mana Tap Counter'),
('1527302','15273','0','0','100','1','10100','16500','12700','24800','11','37361','1','0','0','0','0','0','0','0','0','0','Arcane Wraith - Cast Arcane Bolt');
DELETE FROM creature_ai_scripts WHERE creature_id=15298;
INSERT INTO creature_ai_scripts VALUES 
('1529801','15298','8','0','100','0','28734','-1','0','0','33','15468','6','0','0','0','0','0','0','0','0','0','Mana Wyrm - Killed Credit for Sunstrider Mana Tap Counter'),
('1529802','15298','0','0','100','1','9000','18800','21100','32200','11','25603','1','0','0','0','0','0','0','0','0','0','Tainted Arcane Wraith - Cast Slow');

-- Shattrath guild banks
delete from gameobject where id in (188126,188127);
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(188126,530,1,-1709.69,5461.01,-7.92767,1.85005,0,0,0.798635,0.601815,180,255,1),
(188126,530,1,-1745.81,5533.84,-7.92614,-0.977383,0,0,-0.469471,0.882948,180,255,1),
(188127,530,1,-1987.36,5320.47,-6.77673,-1.23918,0,0,-0.580703,0.814116,180,255,1),
(188127,530,1,-2025.81,5396.9,-6.56243,2.11185,0,0,0.870356,0.492424,180,255,1);

-- Fix battlemasters
delete from game_event_creature where guid in (select guid from creature a join creature_template b on a.id = b.entry where b.subname like '%battlemaster')



-- ToDo: add DB script for quest 9923 - use gameobject 182521 as a starting point
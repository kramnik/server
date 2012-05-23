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
delete from game_event_creature where guid in (select guid from creature a join creature_template b on a.id = b.entry where b.subname like '%battlemaster');

-- Kaliri egg targets (the rest is in core)
delete from spell_script_target where entry =39844;
insert into spell_script_target values
(39844, 0, 185549);

-- Doors for TK and SSC:
delete from gameobject where id in (184597,184596,184324,184325,184329,184328,184327,184326);
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(184597,550,1,744.045,42.3536,46.661,3.14159,0,0,1,1.26759E-06,300,100,1),
(184596,550,1,744.045,-44.6345,46.661,3.14159,0,0,1,1.26759E-06,300,100,1),
(184324,550,1,676.698,43.1643,48.2814,0.610866,0,0,0.300706,0.953717,300,100,0),
(184325,550,1,676.517,-44.5225,48.2813,2.53073,0,0,0.953717,0.300705,300,100,0),
(184329,550,1,544.626,141.888,26.3453,2.87979,0,0,0.991445,0.130528,300,100,0),
(184328,550,1,654.129,75.3316,48.195,0.610866,0,0,0.300706,0.953717,300,100,0),
(184327,550,1,544.538,-143.139,26.3453,-2.87979,0,0,-0.991445,0.130528,300,100,0),
(184326,550,1,654.145,-76.828,48.195,2.53073,0,0,0.953717,0.300705,300,100,0);


delete from gameobject where id in (184568,185117,185118,185115,185116,185114,184205,184204,184203);
delete from gameobject where id in (184697,184573,184572,184919,184574,184920,184699,184698,184571,184914,184570,184917,184916,184918,184915, 184913, 184921, 184569);
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(184697,548,1,-228.012,-332.929, 40.453,-1.92, 0,0,-0.819,0.574,300,100,1),
(184573,548,1,  41.542,-554.927, 29.939, 0.0,  0,0, 0.0,  1.0,300,100,1),
(184572,548,1, 141.557,-509.788, 29.939, 0.0,  0,0, 0.0,  1.0,300,100,1),
(184919,548,1,-229.725,-445.593,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184574,548,1, -56.749,-482.874, 29.939, 0.0,  0,0, 0.0,  1.0,300,100,1),
(184920,548,1,-108.709,-445.593,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184699,548,1,-266.816,-359.075, 10.329,-1.776,0,0,-0.776,0.631,300,100,1),
(184698,548,1,-213.757,-374.003,  6.425, 1.554,0,0, 0.701,0.713,300,100,1),
(184571,548,1, 141.557,-353.075, 29.939, 0.0,  0,0, 0.0,  1.0,300,100,1),
(184914,548,1,-108.709,-265.369,-47.789, 0.569,0,0, 0.281,0.96,300,100,1),
(184570,548,1,  42.017,-304.074, 29.939, 0.0,  0,0, 0.0,  1.0,300,100,1),
(184917,548,1,-230.126,-140.215,-40.935, 0.569,0,0, 0.281,0.96,300,100,1),
(184916,548,1,-193.682,-140.215,-40.935, 0.569,0,0, 0.281,0.96,300,100,1),
(184918,548,1,-255.617,-187.402,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184915,548,1, -45.519,-244.865,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184913,548,1,-148.112,-296.595,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184921,548,1, 127.849,-278.511,-39.939, 0.569,0,0, 0.281,0.96,300,100,1),
(184569,548,1, -57.284,-370.514, 29.939, 0.0,  0,0, 0.1,  0,   300,100,1),

(184568,548,1,47.757,-581.829,4.656,3.142,    0,0,1.0,0.0,300,100,1),
(185117,548,1,-245.729,-381.393,-0.187,2.88,  0,0,0.991,0.131,300,0,0),
(185118,548,1,123.258,-432.357,-1.197,-1.484, 0,0,-0.676,0.737,300,0,0),
(185115,548,1,373.139,-465.106,30.716,-3.054, 0,0,-0.999,0.044,300,0,0),
(185116,548,1,348.987,-684.119,-12.39,0.004,  0,0,0.002,1.0,300,0,0),
(185114,548,1,457.411,-555.27,-6.996,1.833,   0,0,0.793,0.609,300,0,0),

(184205,548,1,26.3285,-654.495,15.4742,3.14159,0,0,-1,0,30,100,0),
(184204,548,1,26.3285,-654.495,15.4742,3.14159,0,0,-1,0,30,100,0),
(184203,548,1,26.3285,-654.495,15.4742,3.14159,0,0,-1,0,30,100,0);

-- Update some gameobject flags
update gameobject set state = 1 where id in (184324,184325,184329,184328,184327,184326,185117,185118,185115,185116,185114,184205,184204,184203);
update gameobject_template set faction=14 where entry in (184324,184325,184329,184328,184327,184326,184597,184596);
UPDATE gameobject_template SET flags=flags|48 WHERE entry IN (185117,185118,185115,185116,185114,184568);

-- Spawns for 23219 from UDB
delete from creature where id = 23219;
insert into creature(id, map, spawnmask,modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, movementtype) values
(23219,530,1,0,0,-3583.43,3482.01,286.535,3.308,300,5,0,6761,0,0,1),
(23219,530,1,0,0,-3607.32,3445.24,298.612,2.934,300,5,0,6761,0,0,1),
(23219,530,1,0,0,-4231.74,3102.79,331.26,2.998,180,5,0,761,0,0,1),
(23219,530,1,0,0,-4128.9,3282.62,291.03,2.684,180,5,0,761,0,0,1),
(23219,530,1,0,0,-4086.46,3605.21,313.85,2.912,180,5,0,761,0,0,1),
(23219,530,1,0,0,-4144.58,3554.15,319.213,5.572,180,5,0,6761,0,0,1),
(23219,530,1,0,0,-4017.68,3682.79,300.721,5.805,180,5,0,6761,0,0,1),
(23219,530,1,0,0,-4120.2,3440.34,291.884,4.488,180,5,0,6761,0,0,1),
(23219,530,1,0,0,-3629.75,3450.12,283.498,0.129,180,5,0,6761,0,0,1),
(23219,530,1,0,0,-3587.48,3721.54,286.794,1.726,180,5,0,6761,0,0,1),
(23219,530,1,0,0,-4052.56,3587.41,289.699,6.241,180,5,0,6761,0,0,1);

-- quest 10896 fix
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` IN (22095,22307);

-- quest 10870 gossip (it still requires script)
delete from gossip_menu where entry=8492;
insert into gossip_menu values
(8492, 10605,0,0,0,0,0,0,0,0);
UPDATE `creature_template` SET `gossip_menu_id` = 8492 WHERE `entry` = 22112;









-- ToDo: add DB script for quest 9923 - use gameobject 182521 as a starting point
-- Sanctum updates

-- Eye of Kilrogg
DELETE FROM `creature_template_addon` WHERE (`entry`=4277);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `emote`, `moveflags`, `auras`) VALUES (4277, 0, 0, 1, 0, 0, 2585);
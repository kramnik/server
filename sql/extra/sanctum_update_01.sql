-- Sanctum updates

-- Eye of Kilrogg aura
DELETE FROM `creature_template_addon` WHERE (`entry`=4277);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `emote`, `moveflags`, `auras`) VALUES (4277, 0, 0, 1, 0, 0, 2585);

-- quest 10162 spell target area
delete from spell_area where spell=33836;
insert into spell_area values
(33836,3803,0,0,0,0,0,2,0);

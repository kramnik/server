DELETE FROM `mangos_string` WHERE `entry` BETWEEN 10001 AND 10055;
INSERT INTO `mangos_string` (`entry`, `content_default`) VALUES

-- all messages are sent in yellow text in SMSG_DEFENSE_MESSAGE (LocalDefense channel)
-- losing control of a capture point doesnt send a text (not yet confirmed for all)
-- TODO: Switch alliance and horde position (alliance before horde)

-- silithus
(10001,'|cffffff00The Horde has collected 200 silithyst!|r'),
(10002,'|cffffff00The Alliance has collected 200 silithyst!|r'),

-- eastern plaguelands
(10003,'|cffffff00The Horde has taken the Northpass Tower!|r'),
(10004,'|cffffff00The Alliance has taken the Northpass Tower!|r'),
(10005,'|cffffff00The Horde has taken the Eastwall Tower!|r'),
(10006,'|cffffff00The Alliance has taken the Eastwall Tower!|r'),
(10007,'|cffffff00The Horde has taken the Crown Guard Tower!|r'),
(10008,'|cffffff00The Alliance has taken the Crown Guard Tower!|r'),
(10009,'|cffffff00The Horde has taken the Plaguewood Tower!|r'),
(10010,'|cffffff00The Alliance has taken the Plaguewood Tower!|r'),
(10011,'|cffffff00The Horde lost the Northpass Tower!|r'),
(10012,'|cffffff00The Alliance lost the Northpass Tower!|r'),
(10013,'|cffffff00The Horde lost the Eastwall Tower!|r'),
(10014,'|cffffff00The Alliance lost the Eastwall Tower!|r'),
(10015,'|cffffff00The Horde lost the Crown Guard Tower!|r'),
(10016,'|cffffff00The Alliance lost the Crown Guard Tower!|r'),
(10017,'|cffffff00The Horde lost the Plaguewood Tower!|r'),
(10018,'|cffffff00The Alliance lost the Plaguewood Tower!|r'),

-- hellfire peninsula
(10019,'|cffffff00The Overlook has been taken by the Horde!|r'),
(10020,'|cffffff00The Overlook has been taken by the Alliance!|r'),
(10021,'|cffffff00The Stadium has been taken by the Horde!|r'),
(10022,'|cffffff00The Stadium has been taken by the Alliance!|r'),
(10023,'|cffffff00Broken Hill has been taken by the Horde!|r'),
(10024,'|cffffff00Broken Hill has been taken by the Alliance!|r'),

 -- following does not exist on retail (confirmed!)
(10025,'|cffffff00The Horde lost The Overlook!|r'),
(10026,'|cffffff00The Alliance lost The Overlook!|r'),
(10027,'|cffffff00The Horde lost The Stadium!|r'),
(10028,'|cffffff00The Alliance lost The Stadium!|r'),
(10029,'|cffffff00The Horde lost Broken Hill!|r'),
(10030,'|cffffff00The Alliance lost Broken Hill!|r'),

-- zangarmarsh
(10031,'|cffffff00The Horde has taken control of the West Beacon!|r'),
(10032,'|cffffff00The Alliance has taken control of the West Beacon!|r'),
(10033,'|cffffff00The Horde has taken control of the East Beacon!|r'),
(10034,'|cffffff00The Alliance has taken control of the East Beacon!|r'),
-- '|cffffff00The Horde has taken control of both beacons!|r'
-- '|cffffff00The Alliance has taken control of both beacons!|r'
-- '|cffffff00The Horde Field Scout is now issuing battle standards.|r' -- right after 'both beacons' message
-- '|cffffff00The Alliance Field Scout is now issuing battle standards.|r'
(10035,'|cffffff00The Horde has taken control of Twin Spire Ruins!|r'),
(10036,'|cffffff00The Alliance has taken control of Twin Spire Ruins!|r'), -- SMSG_PLAY_SOUND id 8173, from npc 15384 (npc id may be a parsing error, but unlikely)

-- following might not exist (not confirmed)
(10037,'|cffffff00The Horde lost the West Beacon!|r'),
(10038,'|cffffff00The Alliance lost the West Beacon!|r'),
(10039,'|cffffff00The Horde lost the East Beacon!|r'),
(10040,'|cffffff00The Alliance lost the East Beacon!|r'),
(10041,'|cffffff00The Horde lost the Twin Spire Graveyard!|r'),
(10042,'|cffffff00The Alliance lost the Twin Spire Graveyard!|r'),

-- nagrand
-- '|cffffff00The Horde is gaining control of Halaa!|r' -- at 51 % (progress event)
-- '|cffffff00The Alliance is gaining control of Halaa!|r'
(10043,'|cffffff00The Horde has taken control of Halaa!|r'),
(10044,'|cffffff00The Alliance has taken control of Halaa!|r'),

-- following might not exist (not confirmed)
(10045,'|cffffff00The Horde lost Halaa!|r'),
(10046,'|cffffff00The Alliance lost Halaa!|r'),

-- terokkar forest
(10047,'|cffffff00The Horde has taken control of a Spirit Tower!|r'),
(10048,'|cffffff00The Alliance has taken control of a Spirit Tower!|r'),
-- '|cffffff00The Alliance has taken control of The Bone Wastes!|r'
-- '|cffffff00The Horde has taken control of The Bone Wastes!|r'

-- following might not exist (not confirmed)
(10049,'|cffffff00The Horde lost a Spirit Tower!|r'),
(10050,'|cffffff00The Alliance lost a Spirit Tower!|r');

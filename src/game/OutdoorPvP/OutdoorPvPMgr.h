/*
 * Copyright (C) 2005-2012 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef WORLD_PVP_MGR_H
#define WORLD_PVP_MGR_H


#include "OutdoorPvP.h"
#include "Common.h"
#include "Policies/Singleton.h"
#include "../SharedDefines.h"
#include "Platform/Define.h"
#include "../Map.h"

class Player;
class GameObject;
class Creature;
class ZoneScript;
class OutdoorPvP;

class OutdoorPvPMgr
{
    public:
        OutdoorPvPMgr();
        ~OutdoorPvPMgr();

        // create world pvp events
        void InitOutdoorPvP();

        // called when a player enters an world pvp area
        void HandlePlayerEnterZone(Player* pPlayer, uint32 uiZoneId);

        // called when player leaves an world pvp area
        void HandlePlayerLeaveZone(Player* pPlayer, uint32 uiZoneId);

        // return assigned world pvp
        OutdoorPvP* GetOutdoorPvPToZoneId(uint32 uiZoneId);

        // return assigned zone script
        ZoneScript* GetZoneScript(uint32 uiZoneId);

        // add zone id to world pvp handler
        void AddZone(uint32 uiZoneId, OutdoorPvP* pScriptHandler);

        // add capture poit id to pvp handler
        void AddCapturePoint(uint32 uiPointId, OutdoorPvP* pScriptHandler);

        void Update(uint32);

        // Handle cases when a player drops a flag
        void HandleDropFlag(Player* pPlayer, uint32 uiSpellId);

        // Handle cases when a gameobject is used
        bool HandleObjectUse(Player* pPlayer, GameObject* pGo);

        // Handle the complete credit for capture point win events
        void HandleObjectiveComplete(uint32 uiEventId, std::list<Player*> players, Team team);

        // Handle the kill event inside the area
        void HandlePlayerKill(Player* pPlayer, Unit* pVictim);

        // Handle capture point stuff
        int8 GetCapturePointSliderValue(uint32 uiEntry);
        void SetCapturePointSlider(uint32 uiEntry, int8 iValue) { m_CapturePointSlider[uiEntry] = iValue; }

        typedef std::vector<OutdoorPvP*> OutdoorPvPSet;
        typedef std::map<uint32 /* zoneid */, OutdoorPvP*> OutdoorPvPMap;

    private:
        // contains all initiated world pvp events
        // used when initing / cleaning up
        OutdoorPvPSet m_OutdoorPvPSet;

        // maps the zone ids to an world pvp event
        // used in player event handling
        OutdoorPvPMap m_OutdoorPvPMap;

        std::map<uint32 /*capture point entry*/, int8 /*slider value*/> m_CapturePointSlider;

        // update interval
        IntervalTimer m_UpdateTimer;
};

#define sOutdoorPvPMgr MaNGOS::Singleton<OutdoorPvPMgr>::Instance()

#endif

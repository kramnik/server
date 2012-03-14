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

#include "OutdoorPvP.h"
#include "OutdoorPvPSI.h"

OutdoorPvPSI::OutdoorPvPSI() : OutdoorPvP(),
    m_uiResourcesAlliance(0),
    m_uiResourcesHorde(0),
    m_zoneOwner(TEAM_NONE)
{
}

// Init outdoor pvp zones
bool OutdoorPvPSI::InitOutdoorPvPArea()
{
    RegisterZone(ZONE_ID_SILITHUS);
    RegisterZone(ZONE_ID_GATES_OF_AQ);
    RegisterZone(ZONE_ID_TEMPLE_OF_AQ);
    RegisterZone(ZONE_ID_RUINS_OF_AQ);

    return true;
}

// Send initial world states
void OutdoorPvPSI::FillInitialWorldStates(WorldPacket& data, uint32& count)
{
    FillInitialWorldState(data, count, WORLD_STATE_SI_GATHERED_A, m_uiResourcesAlliance);
    FillInitialWorldState(data, count, WORLD_STATE_SI_GATHERED_H, m_uiResourcesHorde);
    FillInitialWorldState(data, count, WORLD_STATE_SI_SILITHYST_MAX, MAX_SILITHYST);
}

// Remove world states
void OutdoorPvPSI::SendRemoveWorldStates(Player* pPlayer)
{
    pPlayer->SendUpdateWorldState(WORLD_STATE_SI_GATHERED_A, WORLD_STATE_REMOVE);
    pPlayer->SendUpdateWorldState(WORLD_STATE_SI_GATHERED_H, WORLD_STATE_REMOVE);
    pPlayer->SendUpdateWorldState(WORLD_STATE_SI_SILITHYST_MAX, WORLD_STATE_REMOVE);
}

// Update current world states
void OutdoorPvPSI::UpdateWorldState()
{
    SendUpdateWorldState(WORLD_STATE_SI_GATHERED_A, m_uiResourcesAlliance);
    SendUpdateWorldState(WORLD_STATE_SI_GATHERED_H, m_uiResourcesHorde);
}

// Handle buffs when player enters the zone
void OutdoorPvPSI::HandlePlayerEnterZone(Player* pPlayer)
{
    // remove the buff from the player first; Sometimes on relog players still have the aura
    pPlayer->RemoveAurasDueToSpell(SPELL_CENARION_FAVOR);

    // buff the player if same team is controlling the zone
    if (pPlayer->GetTeam() == m_zoneOwner)
        pPlayer->CastSpell(pPlayer, SPELL_CENARION_FAVOR, true);

    OutdoorPvP::HandlePlayerEnterZone(pPlayer);
}

// Remove buffs when player leaves zone
void OutdoorPvPSI::HandlePlayerLeaveZone(Player* pPlayer)
{
    // remove the buff from the player
    pPlayer->RemoveAurasDueToSpell(SPELL_CENARION_FAVOR);

    OutdoorPvP::HandlePlayerLeaveZone(pPlayer);
}

// Handle case when player returns a silithyst
bool OutdoorPvPSI::HandleAreaTrigger(Player* pPlayer, uint32 uiTriggerId)
{
    if (pPlayer->isGameMaster() || pPlayer->isDead())
        return false;

    if (uiTriggerId == AREATRIGGER_SILITHUS_ALLIANCE)
    {
        if (pPlayer->GetTeam() == ALLIANCE && pPlayer->HasAura(SPELL_SILITHYST))
        {
            // remove aura
            pPlayer->RemoveAurasDueToSpell(SPELL_SILITHYST);

            ++m_uiResourcesAlliance;
            if (m_uiResourcesAlliance == MAX_SILITHYST)
            {
                // apply buff to owner team
                BuffTeam(ALLIANCE, SPELL_CENARION_FAVOR);

                //send zone text and reset stats
                sWorld.SendZoneText(ZONE_ID_SILITHUS, sObjectMgr.GetMangosStringForDBCLocale(LANG_OPVP_SI_CAPTURE_A));

                m_zoneOwner = ALLIANCE;
                m_uiResourcesAlliance = 0;
                m_uiResourcesHorde = 0;
            }

            // update the world states
            UpdateWorldState();

            // reward the player
            pPlayer->CastSpell(pPlayer, SPELL_TRACES_OF_SILITHYST, true);
            pPlayer->RewardHonor(NULL, 1, HONOR_REWARD_SILITHYST);
            pPlayer->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(FACTION_CENARION_CIRCLE), REPUTATION_REWARD_SILITHYST);

            // complete quest
            if (pPlayer->GetQuestStatus(QUEST_SCOURING_DESERT_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                pPlayer->KilledMonsterCredit(NPC_SILITHUS_DUST_QUEST_ALLIANCE);

            return true;
        }
    }
    else if (uiTriggerId == AREATRIGGER_SILITHUS_HORDE)
    {
        if (pPlayer->GetTeam() == HORDE && pPlayer->HasAura(SPELL_SILITHYST))
        {
            // remove aura
            pPlayer->RemoveAurasDueToSpell(SPELL_SILITHYST);

            ++ m_uiResourcesHorde;
            if (m_uiResourcesHorde == MAX_SILITHYST)
            {
                // apply buff to owner team
                BuffTeam(HORDE, SPELL_CENARION_FAVOR);

                //send zone text and reset stats
                sWorld.SendZoneText(ZONE_ID_SILITHUS, sObjectMgr.GetMangosStringForDBCLocale(LANG_OPVP_SI_CAPTURE_H));
                m_zoneOwner = HORDE;
                m_uiResourcesAlliance = 0;
                m_uiResourcesHorde = 0;
            }

            // update world states
            UpdateWorldState();

            // reward the player
            pPlayer->CastSpell(pPlayer, SPELL_TRACES_OF_SILITHYST, true);
            pPlayer->RewardHonor(NULL, 1, HONOR_REWARD_SILITHYST);
            pPlayer->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(FACTION_CENARION_CIRCLE), REPUTATION_REWARD_SILITHYST);

            // complete quest
            if (pPlayer->GetQuestStatus(QUEST_SCOURING_DESERT_HORDE) == QUEST_STATUS_INCOMPLETE)
                pPlayer->KilledMonsterCredit(NPC_SILITHUS_DUST_QUEST_HORDE);

            return true;
        }
    }

    return false;
}

// Handle case when player drops flag
bool OutdoorPvPSI::HandleDropFlag(Player* pPlayer, uint32 uiSpellId)
{
    if (uiSpellId != SPELL_SILITHYST)
        return false;

    // don't drop flag at area trigger
    // we are checking distance from the AT hardcoded coords because it's much faster than checking the area trigger store
    if ((pPlayer->GetTeam() == ALLIANCE && pPlayer->IsWithinDist3d(aSilithusLocs[0].m_fX, aSilithusLocs[0].m_fY, aSilithusLocs[0].m_fZ, 5.0f)) ||
        (pPlayer->GetTeam() == HORDE && pPlayer->IsWithinDist3d(aSilithusLocs[1].m_fX, aSilithusLocs[1].m_fY, aSilithusLocs[1].m_fZ, 5.0f)))
        return false;

    // drop the flag in other case
    pPlayer->CastSpell(pPlayer, SPELL_SILITHYST_FLAG_DROP, true);
    return true;
}

// Handle the case when player picks a silithus mount or geyser
// This needs to be done because the spells used by these objects are missing
bool OutdoorPvPSI::HandleObjectUse(Player* pPlayer, GameObject* pGo)
{
    if (pGo->GetEntry() == GO_SILITHYST_MOUND || pGo->GetEntry() == GO_SILITHYST_GEYSER)
    {
        pPlayer->CastSpell(pPlayer, SPELL_SILITHYST, true);
        return true;
    }

    return false;
}

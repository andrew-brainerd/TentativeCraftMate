TentativeCraftMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> CraftMate", "AceConsole-3.0", "AceEvent-3.0")

TradeList = {}
CraftList = {}

function TentativeCraftMate:SaveTrades()
    TentativeCraftMate:Print("Saving Trades Data")

    local characterName = GetUnitName("player", true)

    for i = 1, GetNumTradeSkills() do
        tradeItemLink = GetTradeSkillItemLink(i)
        if tradeItemLink then 
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(tradeItemLink)

            TradeList[i] = {
                itemName = itemName,
                itemRarity = itemRarity,
                itemLevel = itemLevel,
                itemMinLevel = itemMinLevel,
                itemType = itemType,
                itemStackCount = itemStackCount,
                itemEquipLoc = itemEquipLoc,
                itemTexture = itemTexture, itemSellPrice
            }
        end
    end

    CraftLocker = {
        characterName = {
            CraftList = CraftList,
            TradeList = TradeList
        }
    }
end

function TentativeCraftMate:SaveCrafting()
    TentativeCraftMate:Print("Saving Crafting Data")

    local characterName = GetUnitName("player", true)

    CraftList[characterName] = {}

    local prof, lev, maxlev = GetCraftDisplaySkillLine()
    TentativeCraftMate:Print("Craft Skill Line: " .. prof .. " | " .. lev .. "/" .. maxlev)

    for i = 1, GetNumCrafts() do
        craftItemLink = GetCraftItemLink(i)
        if craftItemLink ~= nil then 
            local _, _, id = string.find(craftItemLink, "enchant:(%d+)")
            local spellName = ""

            if id ~= nil then
                local name, rank, icon = GetSpellInfo(id)

                if spellName then
                    spellName = name
                end

                CraftList[characterName][i] = {
                    spellName = spellName,
                    spellid = id,
                    spellIcon = icon
                }
            end
        end
    end

    CraftLocker = {
        characterName = {
            CraftList = CraftList,
            TradeList = TradeList
        }
    }
end

TentativeCraftMate:RegisterEvent("TRADE_SKILL_UPDATE", function()
    local guildName = GetGuildInfo("player")

    if (guildName == "Tentative") then
        TentativeCraftMate:SaveTrades()
    end
end)

TentativeCraftMate:RegisterEvent("CRAFT_UPDATE", function()
    local guildName = GetGuildInfo("player")

    if (guildName == "Tentative") then
        TentativeCraftMate:SaveCrafting()
    end
end)

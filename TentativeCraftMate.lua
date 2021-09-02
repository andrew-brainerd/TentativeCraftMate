TentativeCraftMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> CraftMate", "AceConsole-3.0", "AceEvent-3.0")

function TentativeCraftMate:SaveTrades(name)
    TentativeCraftMate:Print("Saving Trades Data")
    local TradeList = {}

    TradeList[name] = {}

    for i = 1, GetNumTradeSkills() do
        tradeItemLink = GetTradeSkillItemLink(i)
        if tradeItemLink then 
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(tradeItemLink) 
            TentativeCraftMate:Print("Trade: " .. itemLink)
            TradeList[name][i] = {
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
        TradeList = TradeList
    }
end

function TentativeCraftMate:SaveCrafting(characterName)
    TentativeCraftMate:Print("Saving Crafting Data for " .. characterName)
    local CraftList = {}

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
        CraftList = CraftList
    }
end

TentativeCraftMate:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    name = GetUnitName("player", true)
    -- CraftLocker = {}
    TentativeCraftMate:Print("Welcome " .. name .. "!")
end)

TentativeCraftMate:RegisterEvent("TRADE_SKILL_UPDATE", function()
    name = GetUnitName("player", true)
    TentativeCraftMate:SaveTrades(name)
end)

TentativeCraftMate:RegisterEvent("CRAFT_UPDATE", function()
    name = GetUnitName("player", true)
    TentativeCraftMate:SaveCrafting(name)
end)

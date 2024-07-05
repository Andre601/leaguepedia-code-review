--[[
    The data for the different chances and multiplier values can be found on Data:Tile_Chances
]]--
local p = {}
local h = {} -- For some helper methods...

local tileChances = mw.loadJsonData('Data:Tile_Chances')

function p.main(frame)
    local arg = frame.args[0]
    if arg == nil then
        return {}
    end
    
    if arg == 'def' then
        return p._main()
    elseif arg == 'wed' then
        return p._wednesday()
    elseif arg == 'sun' then
        return p._sunday()
    else
        return {}
    end
end

function p._main()
    local ranks = tileChances.ranks
    local output = mw.html.create()
    local tbl = output:tag('table'):addClass('wikitable'):addClass('wikitable-text--right')
    local row = tbl:tag('tr')
    h.printHeader(row, ranks, 2, 3)
    row = tbl:tag('tr')
    for _, _ in ipairs(ranks) do
        row:tag('th'):wikitext('Chance')
        row:tag('th'):wikitext('Tile Multiplier')
        row:tag('th'):wikitext('Gold Multiplier')
    end
    for _, chance in ipairs(tileChances.chances) do
        local row = tbl:tag('tr')
        h.addDefRow(row, chance, ranks)
    end
    return output
end

function p._wednesday()
    local ranks = tileChances.ranks
    local output = mw.html.create()
    local tbl = output:tag('table'):addClass('wikitable'):addClass('wikitable-text--right')
    local row = tbl:tag('tr')
    h.printHeader(row, ranks, 2, 2)
    row = tbl:tag('tr')
    for _, _ in ipairs(ranks) do
        row:tag('th'):wikitext('Chance')
        row:tag('th'):wikitext('Difference')
    end
    for _, chance in ipairs(tileChances.chances) do
        local row = tbl:tag('tr')
        h.addWedRow(row, chance, ranks)
    end
    return output
end

function p._sunday()
    local ranks = tileChances.ranks
    local output = mw.html.create()
    local tbl = output:tag('table'):addClass('wikitable'):addClass('wikitable-text--right')
    local row = tbl:tag('tr')
    h.printHeader(row, ranks, 3, 4)
    row = tbl:tag('tr')
    for _, _ in ipairs(ranks) do
        row:tag('th'):attr('colspan', 2):wikitext('Tile Multiplier')
        row:tag('th'):attr('colspan', 2):wikitext('Gold Multiplier')
    end
    row = tbl:tag('tr')
    for _, _ in ipairs(ranks) do
        row:tag('th'):wikitext('Value')
        row:tag('th'):wikitext('Difference')
        row:tag('th'):wikitext('Value')
        row:tag('th'):wikitext('Difference')
    end
    for _, chance in ipairs(tileChances.chances) do
        local row = tbl:tag('tr')
        h.addSunRow(row, chance, ranks)
    end
    return output
end

function h.printHeader(row, ranks, rowspan, colspan)
    row:tag('th'):attr('rowspan', rowspan):addClass('wikitable-text--bottom'):wikitext('Rarity')
    for _, rank in ipairs(ranks) do
        row:tag('th'):attr('colspan', colspan):wikitext(rank.display)
    end
end

function h.addDefRow(row, chance, ranks)
    row:tag('th'):addClass('wikitable-text--left'):wikitext(chance.rarity)
    for _, rank in ipairs(ranks) do
        local rarity = chance[string.lower(rank)]
        if rarity ~= nil then
            if rarity.chance == nil then
                row:tag('td'):wikitext('N/A')
            elseif rarity.chance < 0 then
                row:tag('td'):wikitext('-')
            else
                row:tag('td'):wikitext(rarity.chance)
            end
            row:tag('td'):wikitext(rarity.tile_multiplier)
            row:tag('td'):wikitext(rarity.gold_multiplier)
        end
    end
end

function h.addWedRow(row, chance, ranks)
    row:tag('th'):addClass('wikitable-text--left'):wikitext(chance.rarity)
    for _, rank in ipairs(ranks) do
        local rarity = chance[string.lower(rank)]
        if rarity ~= nil then
            if rarity.wed_chance == nil then
                row:tag('td'):wikitext('N/A')
                row:tag('td'):wikitext('N/A')
            elseif rarity.wed_chance < 0 then
                row:tag('td'):wikitext('-')
                row:tag('td'):wikitext('-')
            else
                row:tag('td'):wikitext(rarity.wed_chance)
                row:tag('td'):wikitext(rarity.wed_chance - rarity.chance)
            end
        end
    end
end

function h.addSunRow(row, chance, ranks)
    row:tag('th'):addClass('wikitable-text--left'):wikitext(chance.rarity)
    for _, rank in ipairs(ranks) do
        local rarity = chance[string.lower(rank)]
        if rarity ~= nil then
            row:tag('td'):wikitext(rarity.sun_tile_multiplier)
            row:tag('td'):wikitext(('%+.2f'):format(rarity.sun_tile_multiplier - rarity.tile_multiplier))
            row:tag('td'):wikitext(rarity.sun_gold_multiplier)
            row:tag('td'):wikitext(('%+.2f'):format(rarity.sun_gold_multiplier - rarity.gold_multiplier))
        end
    end
end

return p

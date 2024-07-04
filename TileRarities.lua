--[[
    The data for the different chances and multiplier values can be found on Data:Tile_Chances
]]--
local p = {}

function p.main(frame)
	return p._main(frame.args)
end

function p._main(args)
	local json = mw.loadJsonData('Data:Tile_Chances')
    local ranks = json.ranks
	local dom = mw.html.create()
	local tbl = dom:tag('table'):addClass('wikitable'):css('text-align', 'right')
	local row = tbl:tag('tr')
	row:tag('th'):attr('rowspan', 2):wikitext('Rarity'):css('vertical-align', 'bottom')
    for i, v in ipairs(ranks) do
        row:tag('th'):attr('colspan', 3):wikitext(v.display)
    end
    row = tbl:tag('tr')
    for i, v in ipairs(ranks) do
        row:tag('th'):wikitext('Chance')
        row:tag('th'):wikitext('Tile Multiplier')
        row:tag('th'):wikitext('Gold Multiplier')
    end
	for i, v in ipairs(json.chances) do
		local row = tbl:tag('tr')
		row:tag('th'):wikitext(v.rarity):css('text-align', 'left')
        for i2, v2 in ipairs(ranks) do
            local rarity = v[v2.rank]
            if rarity ~= nil then
        	    if rarity.chance ~= nil then
        	    	row:tag('td'):wikitext(rarity.chance .. '%')
        	    else
        	    	row:tag('td'):wikitext('N/A')
        	    end
                row:tag('td'):wikitext(rarity.tile_multiplier)
                row:tag('td'):wikitext(rarity.gold_multiplier)
            end
        end
	end
	return dom
end

function p.wednesday(frame)
	return p._wednesday(frame.args)
end

function p._wednesday(args)
	local json = mw.loadJsonData('Data:Tile_Chances')
    local ranks = json.ranks
	local dom = mw.html.create()
	local tbl = dom:tag('table'):addClass('wikitable'):css('text-align', 'right')
	local row = tbl:tag('tr')
    row:tag('th'):attr('rowspan', 2):wikitext('Rarity'):css('vertical-align', 'bottom')
    for i, v in ipairs(ranks) do
        row:tag('th'):attr('colspan', 2):wikitext(v.display)
    end
    row = tbl:tag('tr')
    for i, v in ipairs(ranks) do
        row:tag('th'):wikitext('Chance')
        row:tag('th'):wikitext('Difference')
    end
	for i, v in ipairs(json.chances) do
		local row = tbl:tag('tr')
        row:tag('th'):wikitext(v.rarity):css('text-align', 'left')
        for i2, v2 in ipairs(ranks) do
            local rarity = v[v2.rank]
            if rarity ~= nil then
                if rarity.wed_chance ~= nil then
                    row:tag('td'):wikitext(rarity.wed_chance .. '%')
                    row:tag('td'):wikitext(rarity.wed_chance - rarity.chance)
                else
                    row:tag('td'):wikitext('N/A')
                    row:tag('td'):wikitext('N/A')
                end
            end
    	end
	end
	return dom
end


function p.sunday(frame)
	return p._sunday(frame.args)
end

function p._sunday(args)
    local json = mw.loadJsonData('Data:Tile_Chances')
    local ranks = json.ranks
	local dom = mw.html.create()
	local tbl = dom:tag('table'):addClass('wikitable'):css('text-align', 'right')
	local row = tbl:tag('tr')
    row:tag('th'):attr('rowspan', 3):wikitext('Rarity')
    for i, v in ipairs(ranks) do
        row:tag('th'):attr('colspan', 4):wikitext(v.display)
    end
    row = tbl:tag('tr')
    for i, v in ipairs(ranks) do
    	row:tag('th'):attr('colspan', 2):wikitext('Tile Multiplier')
	    row:tag('th'):attr('colspan', 2):wikitext('Gold Multiplier')
    end
	row = tbl:tag('tr')
    for i, v in ipairs(ranks) do
    	row:tag('th'):wikitext('Value')
	    row:tag('th'):wikitext('Difference')
    	row:tag('th'):wikitext('Value')
	    row:tag('th'):wikitext('Difference')
    end
	for i, v in ipairs(json.chances) do
		local row = tbl:tag('tr')
        row:tag('th'):wikitext(v.rarity):css('text-align', 'left')
        for i2, v2 in ipairs(ranks) do
            local rarity = v[v2.rank]
            if rarity ~= nil then
                row:tag('td'):wikitext(rarity.sun_tile_multiplier)
                row:tag('td'):wikitext(('%+.2f'):format(rarity.sun_tile_multiplier - rarity.tile_multiplier))
                row:tag('td'):wikitext(rarity.sun_gold_multiplier)
                row:tag('td'):wikitext(('%+.2f'):format(rarity.sun_gold_multiplier - rarity.gold_multiplier))
            end
        end
	end
	return dom
end

return p

-- See https://tex.stackexchange.com/q/56176

-- Checks if a table contains a key
local function contains (table, val)
	for i=1,#table do
		if table[i] == val then
			return true
		end
	end
	return false
end

-- Searches an array of tuples for a specific key
-- Returns the value if found, nil otherwise
local function search_tuple_value (table, key)
	for i=1,#table do
		if table[i][1] == key then
			return table[i][2]
		end
	end
end

function Image (el)
	local id, classes, attrs = unpack(el.c[1])
	local caption = el.c[2]
	local src, title = unpack(el.c[3])

	tprint(caption)

	if FORMAT == "latex" and contains(classes, "wrap") then
		local side
		if contains(classes, "wrap-float") then
			if contains(classes, "wrap-left") then
				side = "L"
			else
				side = "R"
			end
		else
			if contains(classes, "wrap-left") then
				side = "l"
			else
				side = "r"
			end
		end

		local size = search_tuple_value(attrs, "width") or 0

		local latex_head = [[\begin{wrapfigure}{]] .. side .. '}{' .. size .. 'in}'

		if #caption > 0 then
			local latex_body = [[\centering\includegraphics{]] .. src .. [[}\caption]]
			local latex_tail = [[\end{wrapfigure}]]
			return { pandoc.RawInline(FORMAT, latex_head .. latex_body),
					 pandoc.Span(caption), pandoc.RawInline(FORMAT, latex_tail) }
			--  Should this ^ really be a Span?
		else
			local latex_body = [[\centering\includegraphics{]] .. src .. '}'
			local latex_tail = [[\end{wrapfigure}]]
			return pandoc.RawInline(FORMAT, latex_head .. latex_body .. latex_tail)
		end
	end
end

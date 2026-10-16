-- Copy of `awful.layout.suit.fair` (vertical) with a configurable cap on the number of rows.
-- Once the cap is reached, extra clients add more columns instead of more rows.

local awful = require("awful")

local fair = {}

fair.name = "fairv" -- keep the stock name so the theme's layoutbox icon still applies
fair.max_rows = 3 -- default for tags that haven't set their own `max_rows`

local max_rows_cap = 6

local function get_max_rows(t)
  return (t and t.max_rows) or fair.max_rows
end

local function set_max_rows(delta)
  local s = awful.screen.focused()
  local t = s.selected_tag
  if not t then
    return
  end
  local new_max = get_max_rows(t) + delta
  t.max_rows = math.max(1, math.min(new_max, max_rows_cap))
  awful.layout.arrange(s)
end

function fair.max_rows_inc()
  set_max_rows(1)
end

function fair.max_rows_dec()
  set_max_rows(-1)
end

function fair.arrange(p)
	local wa = p.workarea
	local cls = p.clients

	if #cls == 0 then
		return
	end

	local rows, cols
	if #cls == 2 then
		rows, cols = 1, 2
	else
		local max_rows = get_max_rows(screen[p.screen].selected_tag)
		rows = math.min(math.ceil(math.sqrt(#cls)), max_rows)
		cols = math.ceil(#cls / rows)
	end

	for k, c in ipairs(cls) do
		k = k - 1
		local g = {}

		local row = k % rows
		local col = math.floor(k / rows)

		-- The last column holds whatever clients are left over
		local lrows = rows
		if k >= rows * cols - rows then
			lrows = #cls - (rows * cols - rows)
		end

		if row == lrows - 1 then
			g.height = wa.height - math.ceil(wa.height / lrows) * row
			g.y = wa.height - g.height
		else
			g.height = math.ceil(wa.height / lrows)
			g.y = g.height * row
		end

		if col == cols - 1 then
			g.width = wa.width - math.ceil(wa.width / cols) * col
			g.x = wa.width - g.width
		else
			g.width = math.ceil(wa.width / cols)
			g.x = g.width * col
		end

		g.y = g.y + wa.y
		g.x = g.x + wa.x

		p.geometries[c] = g
	end
end

return fair

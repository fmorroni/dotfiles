local naughty = require("naughty")
local inspect = require('libs.inspect')
local helpers = {}

function helpers.debug_print(object, title)
  naughty.notify({
    title = title or nil,
    text = inspect(object),
    timeout = 0,
    max_height = 1000,
    ontop = true,
    position = 'top_left'
  })
end

-- Write debug info to a file (useful for large objects)
function helpers.debug_to_file(object, opts)
  opts = opts or {}

  local path = opts.path or "/tmp/awesome_debug.log"
  local title = opts.title or "debug"
  local append = opts.append ~= false

  local mode = append and "a" or "w"
  local f, err = io.open(path, mode)

  if not f then
    naughty.notify({
      title = "debug_to_file error",
      text = err
    })
    return
  end

  local timestamp = os.date("%Y-%m-%d %H:%M:%S")

  f:write(string.format(
    "\n[%s] %s\n%s\n",
    timestamp,
    title,
    inspect(object)
  ))

  f:close()
  return path
end

-- Pass as callback to spawn.easy_async
function helpers.notifyCommandExitInfo(cmd)
  return function(stdout, stderr, exitreason, exitcode)
    naughty.notify({
      title = cmd or "No command specified",
      text = string.format(
        "stdout: %s\nstderr: %s\nexitreason: %s\nexitcode: %s\n",
        stdout, stderr, exitreason, exitcode
      ),
      timeout = 0,
    })
  end
end

return helpers

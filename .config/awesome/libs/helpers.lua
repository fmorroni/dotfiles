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
    position = 'top_left' })
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

local M = {}

---Run a git command in `cwd`. Returns trimmed stdout, or nil if it failed.
---@param cwd string
---@param ... string
---@return string?
local function git(cwd, ...)
  local out = vim.system({ "git", ... }, { cwd = cwd, text = true }):wait()
  return out.code == 0 and vim.trim(out.stdout) or nil
end

---The current branch's upstream (e.g. `origin/0.17.x`). Falls back to `origin`, which git resolves
---to `origin/HEAD` (the remote's default branch), when the branch has no upstream.
---@param cwd string
---@return string
function M.upstream(cwd)
  return git(cwd, "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{upstream}") or "origin"
end

---The commit where HEAD diverged from `M.upstream()`.
---@param cwd string
---@return string? merge_base nil if there is none (e.g. no upstream and no `origin`)
---@return string upstream
function M.upstream_merge_base(cwd)
  local upstream = M.upstream(cwd)
  return git(cwd, "merge-base", "HEAD", upstream), upstream
end

return M

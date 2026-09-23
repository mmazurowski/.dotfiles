-- Agentic workflow.
--
-- Both the `ai.claudecode` and `ai.sidekick` LazyVim extras claim <leader>a*,
-- and they collide on aa/ad/af/as. Claude Code owns the plain keys because it
-- is the primary integration; sidekick keeps <leader>aa for its CLI picker and
-- its two clashing maps move to the shifted variants.
--
--   <leader>ac  toggle Claude      <leader>ay  accept Claude diff
--   <leader>af  focus Claude       <leader>an  deny Claude diff
--   <leader>ab  add buffer         <leader>ar  resume   <leader>aC  continue
--   <leader>as  send selection (v) / add file (explorer)
--   <leader>aa  sidekick: toggle CLI picker
--   <leader>aF  sidekick: send file       <leader>aS  sidekick: select CLI
--   <leader>gv  diffview open             <leader>gV  diffview close
return {
  {
    "coder/claudecode.nvim",
    -- stylua: ignore
    keys = {
      -- hand <leader>aa and <leader>ad to sidekick
      { "<leader>aa", false },
      { "<leader>ad", false },
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny Claude Diff" },
    },
    init = function()
      local group = vim.api.nvim_create_augroup("claudecode_workflow", { clear = true })

      -- Saving a `(proposed)` buffer is how claudecode ACCEPTS a diff, so any
      -- format-on-save or autosave firing on it would silently accept the
      -- agent's edit. Opt those buffers out of LazyVim's autoformat.
      local function no_autoformat(buf)
        if buf and vim.api.nvim_buf_is_valid(buf) then
          vim.b[buf].autoformat = false
        end
      end

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "ClaudeCodeDiffOpened",
        callback = function(ev)
          local win = type(ev.data) == "table" and ev.data.diff_window or nil
          if win and vim.api.nvim_win_is_valid(win) then
            no_autoformat(vim.api.nvim_win_get_buf(win))
          end
        end,
      })

      -- Belt and braces: catch any buffer claudecode names "… (proposed)".
      vim.api.nvim_create_autocmd({ "BufNew", "BufWinEnter" }, {
        group = group,
        callback = function(ev)
          if vim.api.nvim_buf_get_name(ev.buf):find("(proposed)", 1, true) then
            no_autoformat(ev.buf)
          end
        end,
      })

      -- Agents edit files on disk behind our back; refresh an open diffview.
      local function refresh_diffview()
        local ok, lib = pcall(require, "diffview.lib")
        if ok and lib.get_current_view() then
          vim.cmd("DiffviewRefresh")
        end
      end

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "ClaudeCodeDiffClosed",
        callback = refresh_diffview,
      })
      vim.api.nvim_create_autocmd("FocusGained", {
        group = group,
        callback = refresh_diffview,
      })
    end,
  },

  {
    "folke/sidekick.nvim",
    -- No Copilot subscription, so Next Edit Suggestions are off. This also stops
    -- the extra from registering the `copilot` LSP server (it checks this flag).
    opts = { nes = { enabled = false } },
    -- stylua: ignore
    keys = {
      { "<tab>", false },        -- NES jump/apply, pointless without Copilot
      { "<leader>af", false },   -- Claude Code takes <leader>af (focus)
      { "<leader>as", false },   -- Claude Code takes <leader>as (send selection)
      { "<leader>aF", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Sidekick Send File" },
      { "<leader>aS", function() require("sidekick.cli").select() end,                 desc = "Sidekick Select CLI" },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    opts = {
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = "diff3_mixed" } },
    },
    -- stylua: ignore
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>",  desc = "Diffview Open" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
  },
}

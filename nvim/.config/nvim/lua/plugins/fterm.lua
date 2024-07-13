return {
  "numToStr/FTerm.nvim",
  config = function()
    local fterm = require("FTerm")
    vim.keymap.set("n", "<leader>y", function()
      fterm:toggle()
    end, { desc = "Toggle terminal" })
    vim.keymap.set("t", "<leader>y", function()
      fterm:toggle()
    end, { desc = "Toggle terminal" })
  end,
}

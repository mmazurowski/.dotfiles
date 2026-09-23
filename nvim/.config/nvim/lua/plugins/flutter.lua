-- flutter-tools owns `dartls`. Do NOT enable the `lang.dart` LazyVim extra or
-- configure dartls via nvim-lspconfig — the two would start competing servers.
return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      debugger = {
        enabled = true,
        exception_breakpoints = {},
      },
      dev_log = {
        enabled = true,
        open_cmd = "15split",
      },
      lsp = {
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
          enableSnippets = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dart" } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { dart = { "dart_format" } } },
  },
}

---@type LazySpec
return {
  "mistricky/codesnap.nvim",
  build = "make",
  cmd = { "CodeSnap", "CodeSnapSave" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    save_path = vim.fn.stdpath "cache" .. "/codesnap",
    has_breadcrumbs = true,
  },
}

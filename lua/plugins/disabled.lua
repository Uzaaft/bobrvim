local disabled = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",

  -- Uzaaft disabled shit
  "yetone/avante.nvim",
  "kdheepak/cmp-latex-symbols",
  "jmbuhr/cmp-pandoc-references",
}

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disabled)

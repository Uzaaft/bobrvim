local servers = { "tsgo", "nixd", "clangd" } -- only add local servers if their commands are available
for server, cmd in pairs { rust_analyzer = "rust-analyzer" } do
  if vim.fn.executable(cmd) == 1 then table.insert(servers, server) end
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    autocmds = {
      no_insert_inlay_hints = {
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            if vim.lsp.inlay_hint.is_enabled(filter) then
              vim.lsp.inlay_hint.enable(false, filter)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
    },
    features = {
      codelens = false,
    },
    handlers = {
      julials = function()
        local julials = vim.lsp.config.julials
        if julials then
          local cmd = julials.cmd
          for _, depot in
            ipairs(
              vim.env.JULIA_DEPOT_PATH and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has "win32" == 1 and ";" or ":")
                or { vim.fn.expand "~/.julia" }
            )
          do
            local bin = vim.fs.joinpath(depot, "environments", "nvim-lspconfig", "bin", "julia")
            local file = (vim.uv or vim.loop).fs_stat(bin)
            if file and file.type == "file" then
              cmd[1] = bin
              vim.lsp.config("julials", { cmd = cmd })
              break
            end
          end
          local codesettings_avail, codesettings = pcall(require, "codesettings")
          if codesettings_avail then
            vim.lsp.config("julials", {
              before_init = require("astrocore").patch_func(
                vim.lsp.config["julials"].before_init,
                function(orig, params, config)
                  codesettings.with_local_settings(config.name, config)
                  return orig(params, config)
                end
              ),
            })
          end
          vim.lsp.enable "julials"
        end
      end,
    },
    servers = servers,
  },
}

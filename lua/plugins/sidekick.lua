local prefix = "<Leader>A"
return {
  "folke/sidekick.nvim",
  ---@type sidekick.Config
  opts = {},
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {
            ai_accept = function()
              return require("sidekick").nes_jump_or_apply()
                or (vim.lsp.inline_completion and vim.lsp.inline_completion.get())
            end,
          },
        },
        mappings = {
          n = {
            [prefix] = { desc = " AI" },
            ["<C-.>"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
            [prefix .. "<CR>"] = {
              function() require("sidekick.cli").toggle { name = "pi", focus = true } end,
              desc = "Toggle Codex",
            },
            [prefix .. "A"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
            [prefix .. "d"] = {
              function() require("sidekick.cli").close() end,
              desc = "Detach AI CLI",
            },
            [prefix .. "s"] = {
              function() require("sidekick.cli").select { filter = { intalled = true } } end,
              desc = "Select an AI CLI",
            },
            [prefix .. "t"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This to AI CLI",
            },
            [prefix .. "f"] = {
              function() require("sidekick.cli").send { msg = "{file}" } end,
              desc = "Send File to AI CLI",
            },
            [prefix .. "p"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Send Prompt to AI CLI",
            },
            [prefix .. "l"] = {
              function()
                vim.lsp.enable("copilot", not vim.lsp.is_enabled "copilot")
                require("astrocore").notify(
                  "Copilot LSP " .. (vim.lsp.is_enabled "copilot" and "enabled" or "disabled")
                )
              end,
              desc = "Toggle Copilot LSP",
            },
            [prefix .. "P"] = {
              function()
                require("snacks").picker.files {
                  cmd = "rg",
                  ignored = true,
                  auto_confirm = true,
                  args = { "-g", "PLAN.md", "-g", "PLAN.*.md" },
                }
              end,
              desc = "Select an agent plan",
            },
          },
          x = {
            [prefix] = { desc = " AI" },
            [prefix .. "t"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This to AI CLI",
            },
            [prefix .. "v"] = {
              function() require("sidekick.cli").send { msg = "{selection}" } end,
              desc = "Send Selection to AI CLI",
            },
            [prefix .. "p"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Send Prompt to AI CLI",
            },
            ["<C-.>"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
          },
          t = {
            ["<C-.>"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
          },
          i = {
            ["<C-CR>"] = {
              function()
                if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then return end
                return "<C-CR>"
              end,
              expr = true,
              desc = "Accept inline completion",
            },
            ["<C-.>"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
          },
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        features = { inline_completion = true },
        handlers = { copilot = false },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = { ensure_installed = { "copilot-language-server" } },
    },
  },
}

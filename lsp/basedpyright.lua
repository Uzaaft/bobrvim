return {
  before_init = function(_, c)
    if not c.settings then c.settings = {} end
    if not c.settings.python then c.settings.python = {} end
    if not c.settings.basedpyright then c.settings.basedpyright = {} end
    if not c.settings.basedpyright.analysis then c.settings.basedpyright.analysis = {} end
    c.settings.python.pythonPath = vim.fn.exepath "python"
    c.settings.basedpyright.analysis.stubPath = vim.fs.root(vim.env.PWD, {"pyproject.toml"}) .. "typings"
  end,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "minimal",
        autoImportCompletions = true,
      },
    },
  },
}

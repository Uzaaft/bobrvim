---@type LazySpec
return {
  "wakatime/vim-wakatime",
  lazy = false,
  cond = function()
    vim.fn.system "ip addr | grep -E 'tun|wg|ppp'"
    return vim.v.shell_error ~= 0
  end,
}

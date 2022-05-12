local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return 
end

-- Note : https://github.com/nvim-treesitter/nvim-treesitter#quickstart
treesitter.setup {
  ensure_installed = { "lua", "python", "c", "rust", "latex" },

  highlight = {
    enable = true,
  },
}

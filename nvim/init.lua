require("plugins") -- The plugins need to be loaded before the config

local core_modules = {
  -- General options 
  "options",
  "keymaps",
  
  -- Configs
  "configs/lualine",
  "configs/treesitter",
  "configs/nvim-tree",
  "configs/cmp",
  "configs/nvim-comment",
  "configs/telescope"
}

for _, mod in ipairs(core_modules) do
  local ok, err = pcall(require, mod)
  if not ok then
      error("Error loading" .. mod .. ":\n" .. err)
    return
  end
end

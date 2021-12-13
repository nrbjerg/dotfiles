local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "monekai",
  italic_comments = true,
}

M.options = {
  relativenumber = true,
}

M.plugins = {
  options = {
    statusline = {
      style = "round",
    },
  },
}
return M

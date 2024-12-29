-- source: https://terminalprogrammer.com/the-best-ai-plugin-for-neovim#heading-how-to-get-started-with-codeium-in-neovim
local Plugin = { "Exafunction/codeium.vim" }

Plugin.cmd = { "CodeiumToggle" }

vim.keymap.set("n", "<leader><CR>", ":CodeiumToggle<CR>")

function get_codeium_status()
  return vim.fn["codeium#GetStatusString"]()
end

function Plugin.config()
  vim.g.codeium_enabled = false
  vim.api.nvim_create_user_command("CodeiumChat", function(opts)
    vim.api.nvim_call_function("codeium#Chat", {})
  end, {})

  vim.g.codeium_no_map_tab = true
  vim.keymap.set("i", "<C-l>", function()
    return vim.fn["codeium#Accept"]()
  end, { expr = true, silent = true })
  vim.keymap.set("i", "<C-j>", function()
    return vim.fn["codeium#CycleCompletions"](1)
  end, { expr = true, silent = true })
  vim.keymap.set("i", "<C-k>", function()
    return vim.fn["codeium#CycleCompletions"](-1)
  end, { expr = true, silent = true })
  vim.keymap.set("i", "<C-d>", function()
    return vim.fn["codeium#Clear"]()
  end, { expr = true, silent = true })

  -- Add Codeium status to the statusline
  vim.o.statusline = table.concat({
    "%f", -- Full file path
    " %h", -- Help flag
    " %m", -- Modified flag
    " %r", -- Readonly flag
    "%=", -- Right aligned
    " %y ", -- File type
    "%{&ff} ", -- File format
    " %p%%", -- File position percentage
    " %l:%c ", -- Line and column number
    " [Codeium:%{v:lua.get_codeium_status()}]", -- Codeium status
  })
end

return Plugin

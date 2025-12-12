return {
  -- Database queries
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },

  -- Database UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      -- Load connections from secret file if it exists
      local secret_path = vim.fn.stdpath("config") .. "/secret_dadbod_connections.json"
      if vim.fn.filereadable(secret_path) == 1 then
        local content = vim.fn.readfile(secret_path)
        local json = vim.fn.json_decode(table.concat(content, "\n"))
        if json and json.connections then
          local dbs = {}
          for _, conn in ipairs(json.connections) do
            dbs[conn.name] = conn.url
          end
          vim.g.dbs = dbs
        end
      end
    end,
  },

  -- SQL autocompletion
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      })
    end,
  },
}

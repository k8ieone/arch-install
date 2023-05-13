-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_configuration.skipped_filetypes = vim.tbl_filter(function(filetype)
  return filetype ~= "markdown"
end, lvim.lsp.automatic_configuration.skipped_filetypes)
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return sever ~= "ansiblels"
end, lvim.lsp.automatic_configuration.skipped_servers)

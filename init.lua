-- NVIM basic configuration
vim.opt.number = true            -- Habilitar números de línea
-- vim.opt.relativenumber = true    -- Habilitar números de línea relativos
vim.opt.showcmd = true -- muestra los comando en tiempo real
vim.opt.tabstop = 4         -- Número de espacios que representa una tabulación
vim.opt.cursorline = true -- resalta la linea actual
vim.opt.shiftwidth = 4      -- Número de espacios para indentación automática
vim.opt.expandtab = true    -- Convierte tabulaciones en espacios
-- vim.opt.autowrite = true  -- Guarda los cambios automáticamente
vim.opt.autoread = true   -- Recarga el archivo si cambia externamente
vim.opt.hlsearch = true
vim.opt.incsearch = true  -- Resalta mientras escribes

-- cmd config
-- vim.cmd("set noesckeys") 
vim.opt.clipboard = 'unnamedplus' -- permite usar el porta papeles de macos
vim.g.mapleader = ' '  -- Espacio como líder
vim.opt.ruler = true
vim.opt.smartindent = true

-- espacio como leader
vim.g.mapleader = ' '  -- Espacio como líder

-- Mapeo para mover la línea actual hacia abajo
vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true, silent = true })

-- Mapeo para mover la línea actual hacia arriba
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==', { noremap = true, silent = true })

-- Mapear 'dd' para eliminar sin copiar
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })

-- Auto-instalación de packer si no está instalado
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Usa packer para gestionar plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer puede gestionarse a sí mismo
  -- Aquí puedes agregar más plugins, por ejemplo:
  use 'ellisonleao/gruvbox.nvim'
  -- Para Gruvbox Material
  use 'sainnhe/gruvbox-material'
  -- Para Gruvbox8
  use 'lifepillar/vim-gruvbox8'
  -- Para Gruvbox Flat
  use 'eddyekofo94/gruvbox-flat.nvim'
  -- Instalar nvim-web-devicons
  use 'nvim-tree/nvim-web-devicons'
  -- Telescope
  use 'nvim-lua/plenary.nvim'  -- Dependencia para Telescope
  use 'nvim-telescope/telescope.nvim'
  -- Instalar lualine.nvim
  use 'nvim-lualine/lualine.nvim'
  -- Instalar vim-matchup
  use 'andymass/vim-matchup'
  -- LSP para ver los errores en php
  use 'neovim/nvim-lspconfig'
  -- Instalar nvim-tree.lua
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' } -- Necesario para los iconos de archivos
  }
end)

-- Gruvbox
-- Configurar el fondo a oscuro
vim.o.background = "dark" -- Establecer el fondo oscuro

-- Cargar el esquema de colores Gruvbox
vim.cmd([[colorscheme gruvbox-material]])

-- Configuración para Gruvbox Material
vim.g.gruvbox_material_background = 'hard' -- Opciones: 'soft', 'medium', 'hard'
vim.g.gruvbox_material_foreground = 'material' -- Usa el esquema de colores "material"
vim.g.gruvbox_material_better_performance = 1 -- Mejora el rendimiento

-- Configuración de nvim-tree.lua
require('nvim-tree').setup({
  -- Opciones básicas
--  auto_reload_on_write = true,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    },
  },
  view = {
    width = 30,
    side = 'left',
  },
})

-- Configurar Telescope
require('telescope').setup({
  defaults = {
    -- Configuración general de Telescope
    prompt_prefix = "> ",
    selection_caret = "> ",
    path_display = {"smart"},
    file_ignore_patterns = {},  -- Puedes agregar patrones para ignorar ciertos archivos/directorios
    -- Configuración para mostrar solo archivos de la carpeta actual
    cwd = vim.fn.expand('%:p:h'),  -- Establece el directorio de trabajo actual
  },
})

-- Configuración de lualine.nvim
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material', -- Usa el tema que prefieras
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "packer" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

-- Configuración básica de vim-matchup (opcional)
vim.g.matchup_matchparen_deferred = 1

-- Configuracion de LSP
-- Requiere el plugin 'nvim-lspconfig'
local lspconfig = require'lspconfig'

-- Configura phpactor como servidor de lenguaje
lspconfig.phpactor.setup({
  on_attach = function(client, bufnr)
    -- Configura teclas de acceso rápido para LSP
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- Ejemplo de teclas de acceso rápido:
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  end,
})

-- Autocomando para actualizar el cwd cuando cambies de archivo
-- vim.cmd [[
--   augroup UpdateCwd
--     autocmd!
--     autocmd BufEnter * lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() })
--   augroup END
-- ]]

-- Mapeo para buscar archivos con Telescope usando Control + p
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- Mapeo para abrir y cerrar nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Configuración básica de nvim-web-devicons (opcional)
require('nvim-web-devicons').setup({
  -- Opciones adicionales de configuración aquí
})


-- Autocomando para autoactualizar Packer cuando se modifique init.lua
-- vim.cmd [[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost init.lua source <afile> | PackerSync
--  augroup end
-- ]]

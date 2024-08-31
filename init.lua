NVIM basic configuration
-- BASIC CONFIG
vim.opt.number = true            -- Habilitar números de línea
vim.opt.showcmd = true -- muestra los comando en tiempo real
vim.opt.tabstop = 4         -- Número de espacios que representa una tabulación
vim.opt.cursorline = true -- resalta la linea actual
vim.opt.shiftwidth = 4      -- Número de espacios para indentación automática
vim.opt.expandtab = true    -- Convierte tabulaciones en espacios
vim.opt.autoread = true   -- Recarga el archivo si cambia externamente
vim.opt.hlsearch = true
vim.opt.incsearch = true  -- Resalta mientras escribes
vim.opt.clipboard = 'unnamedplus' -- permite usar el porta papeles de macos
vim.g.mapleader = ' '  -- Espacio como líder
vim.opt.ruler = true
vim.opt.smartindent = true
vim.opt.relativenumber = true    -- Habilitar numeros de la linea relativos
-- vim.opt.autowrite = true  -- Guarda los cambios autom�ɬ�ticamente
-- vim.cmd("set noesckeys") 

-- MAPEO DE TECLAS
vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true, silent = true }) -- Mapeo para mover la linea actual hacia abajo
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==', { noremap = true, silent = true }) -- Mapeo para mover la linea actual hacia arriba

-- Mapear 'dd' para eliminar sin copiar
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })

-- Gitlens keyblinds
vim.api.nvim_set_keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hb', ':Gitsigns blame_line<CR>', { noremap = true, silent = true })

-- KEYBLINDS FOR PLUGGINS
-- Mapeo para buscar archivos con Telescope usando Control + p
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- Mapeo para abrir y cerrar nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Auto-instalacion de packer si no esta instalado
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end


-- Packer
require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/gruvbox-material'
  use 'lifepillar/vim-gruvbox8'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use {
    'sainnhe/sonokai',
    config = function()
        vim.g.sonokai_style = 'default'
        vim.cmd('colorscheme sonokai')
    end
  }
  --[[
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use {
      'sainnhe/everforest',
      config = function()
          vim.g.everforest_background = 'hard'
          vim.g.everforest_better_performance = 1
          vim.cmd('colorscheme everforest')
      end
  }
  use {
      'HoNamDuong/hybrid.nvim',
      config = function()
          vim.cmd('colorscheme hybrid')
      end
  }
  --]]

  -- UI enhancements
  use 'nvim-tree/nvim-web-devicons' -- File icons
  use 'nvim-lua/plenary.nvim' -- Required by various plugins
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Indentation guides

  -- Navigation and search
  use 'nvim-telescope/telescope.nvim'

  -- Syntax highlighting and matching
  use 'andymass/vim-matchup'
  use 'HiPhish/rainbow-delimiters.nvim' -- Rainbow delimiters

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
  }

  -- LSP and diagnostics
  use 'neovim/nvim-lspconfig' -- LSP configuration
  use {
    'VidocqH/lsp-lens.nvim',
    config = function()
        require('lsp-lens').setup({
            enable = true,
            include_declaration = false,
            sections = {
                definition = false,
                references = true,
                implementation = true,
            },
            auto_enable = true,
            position = "above_line",
            icon = "??",
        })
    end
  }

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
        require('gitsigns').setup({
            signs = {
                add          = {hl = 'GitGutterAdd', text = '+', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
                change       = {hl = 'GitGutterChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                topdelete    = {hl = 'GitGutterDelete', text = '?', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                changedelete = {hl = 'GitGutterChangeDelete', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            },
            current_line_blame = true,
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
        })
    end
  }

  -- PHP development
  use {
    'phpactor/phpactor',
    ft = 'php',
    run = 'composer install --no-dev -o',
    config = function()
        vim.g.phpactor_php_bin = '/usr/bin/php'
    end
  }
end)

-- PLUGGINS AND THEMES CONFIG
-- Catppuccin Theme
-- vim.cmd('colorscheme catppuccin')
-- Gruvbox Theme
-- Configurar el fondo a oscuro
-- vim.o.background = "dark" -- Establecer el fondo oscuro

-- Cargar el esquema de colores Gruvbox
-- vim.cmd([[colorscheme gruvbox-material]])

-- Configuración para Gruvbox Material
-- vim.g.gruvbox_material_background = 'hard' -- Opciones: 'soft', 'medium', 'hard'
-- vim.g.gruvbox_material_foreground = 'material' -- Usa el esquema de colores "material"
-- vim.g.gruvbox_material_better_performance = 1 -- Mejora el rendimiento

-- rainbow delemiters
-- Configuraci�n de rainbow-delimiters
-- require('rainbow-delimiters.setup')({
--     strategy = {
--         [''] = require('rainbow-delimiters.strategy.global'),
--         vim = require('rainbow-delimiters.strategy.local'),
--     },
--     query = {
--         [''] = 'rainbow-delimiters',
--         lua = 'rainbow-blocks',
--     },
--     highlight = {
--         'RainbowDelimiterRed',
--         'RainbowDelimiterYellow',
--         'RainbowDelimiterBlue',
--         'RainbowDelimiterOrange',
--         'RainbowDelimiterGreen',
--         'RainbowDelimiterViolet',
--         'RainbowDelimiterCyan',
--     },
-- })
-- require("ibl").setup {
--     indent = { char = "[" },  -- Puedes cambiar "" por otros caracteres de l�nea si lo prefieres.
--     scope = { 
--         enabled = true,
--         char = "[",
--     },
--     -- Otras opciones de configuraci�n si las necesitas
-- }

-- Configuracion de nvim-tree.lua
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
    -- Configuracion general de Telescope
    prompt_prefix = "> ",
    selection_caret = "> ",
    path_display = {"smart"},
    file_ignore_patterns = {},  -- Puedes agregar patrones para ignorar ciertos archivos/directorios
    -- Configuracion para mostrar solo archivos de la carpeta actual
    cwd = vim.fn.expand('%:p:h'),  -- Establece el directorio de trabajo actual
  },
})

-- Configuración de lualine.nvim
require('lualine').setup({
  options = {
    icons_enabled = true,
    -- theme = 'gruvbox-material', -- Usa el tema que prefieras
    theme = 'catppuccin',
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

-- Configuracion basica de nvim-web-devicons (opcional)
require('nvim-web-devicons').setup({
  -- Opciones adicionales de configuración aquí
})

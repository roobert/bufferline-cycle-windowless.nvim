# :window: Bufferline Cycle Windowless

![Screenshot](https://user-images.githubusercontent.com/226654/208528189-10984843-96cc-4e86-bcfe-efa5b4b13707.gif)

A [bufferline](https://github.com/akinsho/bufferline.nvim) extension to cycle through windowless buffers.

## :zap: Motivation

Neovims default tab-window-buffer model allows viewing open buffers in multiple windows.

This plugin helps give a more traditional behaviour for tabs by configuring the ability to skip past
buffers that are already open in an existing window. The behaviour is toggleable and
configurable to be on or off by default.

## :rocket: Installation

### Lazy

```lua
 {
  "roobert/bufferline-cycle-windowless.nvim",
  dependencies = {
   { "akinsho/bufferline.nvim" },
  },
  config = function()
   require("bufferline-cycle-windowless").setup({
    default_enabled = true,
   })
  end,
 },
```

### Packer

```lua
use {
  "roobert/bufferline-cycle-windowless.nvim",
  requires = {
   { "akinsho/bufferline.nvim" },
  },
  setup = function()
   require("bufferline-cycle-windowless").setup({
     -- whether to start in enabled or disabled mode
     default_enabled = true,
   })
  end,
}
```

## :hammer_and_wrench: Usage

### Simple Example

#### Standard Neovim

``` lua
vim.api.nvim_set_keymap("n", "<S-l>", "<CMD>BufferLineCycleWindowlessNext<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", "<CMD>BufferLineCycleWindowlessPrev<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-t>", "<CMD>BufferLineCycleWindowlessToggle<CR>",
    { noremap = true, silent = true })
```

#### Lunarvim

``` lua
lvim.keys.normal_mode["<S-l>"] = "<CMD>BufferLineCycleWindowlessNext<CR>"
lvim.keys.normal_mode["<S-h>"] = "<CMD>BufferLineCycleWindowlessPrev<CR>"
lvim.keys.normal_mode["<S-t>"] = "<CMD>BufferLineCycleWindowlessToggle<CR>"
```

### Advanced Example

I prefer empty splits that get cleaned up as I cycle through open buffers.

#### Standard Neovim

``` lua
-- open empty splits
vim.api.nvim_set_keymap("n", "<leader>|", "<CMD>vsplit +enew<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>_", "<CMD>split +enew<CR>", {})

-- since we open empty splits - clean them up as we cycle through open buffers
function ChangeTab(motion)
 local last_buffer_id = vim.fn.bufnr()
 local last_buffer_name = vim.fn.expand("%")

 if motion == "next" then
  vim.cmd([[BufferLineCycleWindowlessNext]])
 elseif motion == "prev" then
  vim.cmd([[BufferLineCycleWindowlessPrev]])
 else
  error("Invalid motion: " .. motion)
  return
 end

 if last_buffer_name == "" then
  vim.cmd("bd " .. last_buffer_id)
 end
end

-- switch through visible buffers with shift-l/h
vim.api.nvim_set_keymap("n", "<S-l>", "<CMD>lua ChangeTab('next')<CR>", {})
vim.api.nvim_set_keymap("n", "<S-h>", "<CMD>lua ChangeTab('prev')<CR>", {})
vim.api.nvim_set_keymap("n", "<S-t>", "<CMD>BufferLineCycleWindowlessToggle<CR>", {})

-- lighten up bufferline background
lvim.builtin.bufferline = {
 active = true,
 options = {
  separator_style = "slant",
 },
 highlights = {
  fill = {
   bg = "#252d52",
  },

  separator_selected = {
   fg = "#252d52",
  },

  separator_visible = {
   fg = "#252d52",
  },

  separator = {
   fg = "#252d52",
  },

  buffer_visible = {
   fg = "#9696ca",
   bold = false,
  },

  buffer_selected = {
   fg = "#eeeeee",
   bold = false,
  },

  tab_selected = {
   bold = false,
  },
 },
}

```

#### Lunarvim

``` lua
-- open empty splits
lvim.builtin.which_key.mappings["|"] = { "<CMD>vsplit +enew<CR>", "Vertical split" }
lvim.builtin.which_key.mappings["_"] = { "<CMD>split +enew<CR>", "Horizontal split" }

-- since we open empty splits - clean them up as we cycle through open buffers
function ChangeTab(motion)
 local last_buffer_id = vim.fn.bufnr()
 local last_buffer_name = vim.fn.expand("%")

 if motion == "next" then
  vim.cmd([[BufferLineCycleWindowlessNext]])
 elseif motion == "prev" then
  vim.cmd([[BufferLineCycleWindowlessPrev]])
 else
  error("Invalid motion: " .. motion)
  return
 end

 if last_buffer_name == "" then
  vim.cmd("bd " .. last_buffer_id)
 end
end

-- switch through visible buffers with shift-l/h
lvim.keys.normal_mode["<S-l>"] = "<CMD>lua ChangeTab('next')<CR>"
lvim.keys.normal_mode["<S-h>"] = "<CMD>lua ChangeTab('prev')<CR>"
lvim.keys.normal_mode["<S-t>"] = "<CMD>BufferLineCycleWindowlessToggle<CR>"

-- lighten up bufferline background
lvim.builtin.bufferline = {
 active = true,
 options = {
  separator_style = "slant",
 },
 highlights = {
  fill = {
   bg = "#252d52",
  },

  separator_selected = {
   fg = "#252d52",
  },

  separator_visible = {
   fg = "#252d52",
  },

  separator = {
   fg = "#252d52",
  },

  buffer_visible = {
   fg = "#9696ca",
   bold = false,
  },

  buffer_selected = {
   fg = "#eeeeee",
   bold = false,
  },

  tab_selected = {
   bold = false,
  },
 },
}

```

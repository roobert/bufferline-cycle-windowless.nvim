# Bufferline Cycle Windowless

![Untitled](https://user-images.githubusercontent.com/226654/208321256-c7c8e1cc-620e-4c67-bf08-7bb793f8c9ff.gif)

A [bufferline](https://github.com/akinsho/bufferline.nvim) extension to cycle through windowless buffers.

## Usage

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

### Binding

```
vim.api.nvim_set_keymap("n", "[b", "<CMD>BufferLineCycleWindowlessNext<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]b", "<CMD>BufferLineCycleWindowlessPrev<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-t>", "<CMD>BufferLineCycleWindowlessToggle<CR>",
    { noremap = true, silent = true })
```

### Advanced Usage Example

I prefer empty splits that get cleaned up as I cycle through open buffers.

This config uses [LunarVim](https://github.com/lunarvim/lunarvim)

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
   bg = "#2d476e",
  },
  separator_selected = {
   fg = "#2d476e",
  },
  separator_visible = {
   fg = "#2d476e",
  },
  separator = {
   fg = "#2d476e",
  },
 },
}
```

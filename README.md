# Bufferline Cycle Windowless

![Untitled](https://user-images.githubusercontent.com/226654/208321256-c7c8e1cc-620e-4c67-bf08-7bb793f8c9ff.gif)

A bufferline extension to cycle through windowless buffers.

## Usage

### Packer

```lua
use {
  "roobert/bufferline-cycle-windowless.nvim",
  requires = {
   { "akinsho/bufferline.nvim" },
  },
  setup = function()
   require("bufferline-cycle-windowless").setup()
  end,
}
```

### Binding

```
vim.api.nvim_set_keymap("n", "[b", "<CMD>BufferLineCycleWindowlessNext<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]b", "<CMD>BufferLineCycleWindowlessPrev<CR>",
    { noremap = true, silent = true })
```

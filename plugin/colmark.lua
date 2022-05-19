--
-- Cursor Movement for colmark
--
--     ^
--     n
-- < h   i >
--     e
--     v

-- n => j
vim.keymap.set({ "n", "x", "o" }, "n", "j")
vim.keymap.set({ "n", "x", "o" }, "N", "J")

vim.keymap.set("n", "gN", "gJ")
vim.keymap.set("n", "<C-n>", "<C-j>")
vim.keymap.set("n", "<C-w>n", "<C-w>j")
vim.keymap.set("n", "<C-w><C-n>", "<C-w><C-j>")

-- j => e
vim.keymap.set({ "n", "x", "o" }, "j", "e")
vim.keymap.set({ "n", "x", "o" }, "J", "E")

vim.keymap.set({ "n", "x" }, "gj", "ge")
vim.keymap.set("n", "<C-j>", "<C-e>")
vim.keymap.set("n", "<C-w>j", "<C-w>e")
vim.keymap.set("n", "<C-w><C-j>", "<C-w><C-e>")

-- e => k
vim.keymap.set({ "n", "x", "o" }, "e", "k")
vim.keymap.set({ "n", "x", "o" }, "E", "K")

vim.keymap.set({ "n", "x" }, "ge", "gk")
vim.keymap.set("n", "<C-e>", "<C-k>")
vim.keymap.set("n", "<C-w>e", "<C-w>k")
vim.keymap.set("n", "<C-w><C-e>", "<C-w><C-k>")

-- k => n
vim.keymap.set({ "n", "x", "o" }, "k", "n")
vim.keymap.set({ "n", "x", "o" }, "K", "N")

vim.keymap.set({ "n", "x" }, "gk", "gn")
vim.keymap.set("n", "<C-k>", "<C-n>")
vim.keymap.set("n", "<C-w>k", "<C-w>n")
vim.keymap.set("n", "<C-w><C-k>", "<C-w><C-n>")

-- i => l
vim.keymap.set({ "n", "x", "o" }, "i", "l")
vim.keymap.set({ "n", "x", "o" }, "I", "L")

vim.keymap.set({ "n", "x" }, "gi", "gl")
vim.keymap.set({ "n", "x" }, "gi", "gL")
vim.keymap.set("n", "<C-i>", "<C-l>")
vim.keymap.set("n", "<C-w>i", "<C-w>l")
vim.keymap.set("n", "<C-w><C-i>", "<C-w><C-l>")

-- l => i
vim.keymap.set({ "n", "x", "o" }, "l", "i")
vim.keymap.set({ "n", "x", "o" }, "L", "I")

vim.keymap.set({ "n", "x" }, "gl", "gi")
vim.keymap.set({ "n", "x" }, "gL", "gI")
vim.keymap.set("n", "<C-l>", "<C-i>")
vim.keymap.set("n", "<C-w>l", "<C-w>i")
vim.keymap.set("n", "<C-w><C-l>", "<C-w><C-i>")

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<M-n>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-e>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-i>", "<C-\\><C-n><C-w>l")

-- Resize splits with arrow keys
vim.keymap.set("n", "<Up>", "<cmd>res +5<cr>")
vim.keymap.set("n", "<Down>", "<cmd>res -5<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize-5<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize+5<cr>")

-- buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "]B", "<cmd>blast<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "[B", "<cmd>bfirst<cr>")

vim.keymap.set("", "<C-s>", "<cmd>wall<cr>")

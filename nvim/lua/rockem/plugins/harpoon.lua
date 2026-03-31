vim.pack.add({ { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" } })

local harpoon = require("harpoon")
harpoon:setup()

local map = vim.keymap.set

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Add file to harpoon" })

map("n", "<leader>hm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon menu" })

map("n", "<leader>h1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
map("n", "<leader>h2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
map("n", "<leader>h3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
map("n", "<leader>h4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon file 4" })

map("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Harpoon prev file" })
map("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Harpoon next file" })

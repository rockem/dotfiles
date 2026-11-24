vim.pack.add({
  "https://github.com/3rd/image.nvim",
  "https://github.com/3rd/diagram.nvim",
})

-- Requires a terminal with the kitty graphics protocol (Ghostty, kitty, WezTerm),
-- ImageMagick (`magick`) and mermaid-cli (`mmdc`).
require("image").setup({
  backend = "kitty",
  processor = "magick_cli",
  -- diagram.nvim does the rendering; keep image.nvim's own markdown/neorg image handling off
  integrations = {
    markdown = { enabled = false },
    neorg = { enabled = false },
  },
  max_height_window_percentage = 60,
})

local markdown = require("diagram.integrations.markdown")

local renderer_options = {
  mermaid = {
    theme = "dark",
    background = "transparent",
    scale = 2,
  },
}

require("diagram").setup({
  integrations = { markdown },
  events = {
    -- mmdc launches headless Chromium, so skip TextChanged to avoid a render on every edit.
    -- BufEnter re-renders after returning from the diagram tab (BufLeave clears the images).
    render_buffer = { "InsertLeave", "BufWinEnter", "BufEnter" },
    clear_buffer = { "BufLeave" },
  },
  renderer_options = renderer_options,
})

-- Render the diagram under the cursor (cached) and open the PNG in the system viewer
local function open_diagram_in_viewer()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1

  -- The plugin's range only covers the opening fence line, so scan to the closing fence
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local function block_end(start_row)
    for i = start_row + 1, #lines - 1 do
      if lines[i + 1]:match("^%s*```%s*$") then
        return i
      end
    end
    return #lines - 1
  end

  local found
  for _, d in ipairs(markdown.query_buffer_diagrams(bufnr)) do
    if row >= d.range.start_row and row <= block_end(d.range.start_row) then
      found = d
      break
    end
  end
  if not found then
    vim.notify("No diagram found at cursor", vim.log.levels.INFO)
    return
  end

  local renderer
  for _, r in ipairs(markdown.renderers) do
    if r.id == found.renderer_id then
      renderer = r
      break
    end
  end
  if not renderer then
    vim.notify("No renderer for " .. found.renderer_id, vim.log.levels.ERROR)
    return
  end

  local result = renderer.render(found.source, renderer_options[renderer.id] or {})
  if not result then
    return
  end

  local function open()
    if vim.fn.filereadable(result.file_path) == 1 then
      vim.ui.open(result.file_path)
    else
      vim.notify("Diagram render failed", vim.log.levels.ERROR)
    end
  end

  if not result.job_id then
    return open()
  end

  -- Rendering is async on a cache miss: poll until the job finishes
  local timer = assert(vim.uv.new_timer())
  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      if vim.fn.jobwait({ result.job_id }, 0)[1] ~= -1 and not timer:is_closing() then
        timer:stop()
        timer:close()
        open()
      end
    end)
  )
end

-- Open the diagram under the cursor in its own tab (q/Esc closes, o opens in the system viewer)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<leader>md", function()
      require("diagram").show_diagram_hover()
    end, { buffer = ev.buf, desc = "Show diagram in new tab" })
    vim.keymap.set("n", "<leader>mo", open_diagram_in_viewer, {
      buffer = ev.buf,
      desc = "Open diagram in system viewer",
    })
  end,
})
